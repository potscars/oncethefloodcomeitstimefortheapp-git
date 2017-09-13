//
//  AppDelegate.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 31/05/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import Bugsnag
import SystemConfiguration
import UserNotifications

import Firebase
import FirebaseInstanceID
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigation: UINavigationItem?
    var UUID: String?
    var APNSToken: String?
    var saifonUrl: WebServices?
    let gcmMessageIDKey = "gcm.message_id"
    
    //Global River Data
    var FirstRiverData = NSDictionary()
    var SecondRiverData = NSDictionary()
    static var gradientInDelegate: CGGradient = CGGradient(colorSpace: CGColorSpaceCreateDeviceRGB(), colorComponents: [ 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0 ], locations: [ 0.0, 1.0 ] , count: 1)!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Bugsnag.start(withApiKey: "cc097873a16b18a82140b38e806b3e1b");
        
        registerForPushNotifications(application)
        
        //MARK : - Firebase configuration
        FirebaseApp.configure()
        //FIRApp.configure()
        
        let userNotifySettings = UIUserNotificationSettings.init(types: [UIUserNotificationType.alert,UIUserNotificationType.badge, UIUserNotificationType.sound], categories: nil)
        application.registerUserNotificationSettings(userNotifySettings)
        
        print("[AppDelegate] Internet Connection status is ",isConnectedToNetwork())
        
        print("[AppDelegate] Registered UUID is ",Foundation.UUID().uuidString)
        UUID = Foundation.UUID().uuidString
        
        // Add observer for InstanceID token refresh callback.
        NotificationCenter.default.addObserver(self, selector: #selector(tokenRefreshNotification), name: Notification.Name.InstanceIDTokenRefresh, object: nil)
        return true
    }
    
    func registerForPushNotifications(_ application: UIApplication) {
        
        /*DispatchQueue.main.async {
         let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
         UIApplication.shared.registerUserNotificationSettings(settings)
         }*/
        
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { (granted, error) in
                guard error == nil else {
                    print("Noti register error: \(error?.localizedDescription)")
                    return
                }
                
                if granted {
                    UIApplication.shared.registerForRemoteNotifications()
                    print("Noti registered!")
                } else {
                    
                    print("Failed to registered!")
                }
            })
            
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().remoteMessageDelegate = self
            
        } else {
            let userNotificationTypes: UIUserNotificationType = [.alert, .badge, .sound]
            let settings = UIUserNotificationSettings(types: userNotificationTypes, categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types != UIUserNotificationType() {
            application.registerForRemoteNotifications()
        }
        
        print("Successfully registered!")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        /*var token: NSString = deviceToken.description.stringByTrimmingCharactersInSet(NSCharacterSet.init(charactersInString: "<>"))
        token = token.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        print("[AppDelegate] Raw Device Token retrieved is ",deviceToken.description)
        
        APNSToken = token as String
        
        print("[AppDelegate] Device Token retrieved is ",APNSToken!)
        
        if(self.isConnectedToNetwork() == true)
        {
            SendAPNSTokenData(UUID!, apnsToken: APNSToken!)
        }*/
        
        //MARK : - Firebase
        let tokenChars = (deviceToken as NSData).bytes.bindMemory(to: CChar.self, capacity: deviceToken.count)
        var tokenString = ""
        
        for i in 0..<deviceToken.count {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        //Tricky line
        InstanceID.instanceID().setAPNSToken(deviceToken, type: .sandbox)
        InstanceID.instanceID().setAPNSToken(deviceToken, type: .prod)
        print("Device Token:", tokenString)
        
        if let refreshedToken = InstanceID.instanceID().token() {
            print("Firebase Token: \(refreshedToken)")
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID without handler: \(messageID)")
        }
        
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID with handler: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    // [START refresh_token]
    func tokenRefreshNotification(_ notification: Notification) {
        if let refreshedToken = InstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
            
            if(self.isConnectedToNetwork() == true)
            {
                //MARK: - Send firebase instance id to server.
                
                let qualityOfServiceClass = DispatchQoS.QoSClass.background
                let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
                backgroundQueue.async(execute: {
                    
                    print("This is run on the background queue")
                    self.SendAPNSTokenData(self.UUID!, apnsToken: refreshedToken)
                })
            }
        }
        
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
    }
    // [END refresh_token]
    
    // [START connect_to_fcm]
    func connectToFcm() {
        // Won't connect since there is no token
        guard InstanceID.instanceID().token() != nil else {
            return;
        }
        
        // Disconnect previous FCM connection if it exists.
        Messaging.messaging().disconnect()
        
        Messaging.messaging().connect { (error) in
            
            if error != nil {
                print("Unable to connect with FCM. \(error)")
            } else {
                print("Connected to FCM.")
            }
        }
    }
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability,  &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
    }
    
    func SendAPNSTokenData(_ uuid: String, apnsToken: String) {
        
        print("[AppDelegate] Sending device token to Server")
        
        let getLoginURL = URL.init(string: "http://saifon.my/api/mobile")
        let postDataString = "app=ios&imei=\(uuid)&push_notification_token=\(apnsToken)"
        let postData: Data = postDataString.data(using: String.Encoding.ascii, allowLossyConversion: true)!
        let postLength = String.localizedStringWithFormat("%lu", postData.count)
        
        print("[AppDelegate] Preparing to request the server...")
        
        let requestData = NSMutableURLRequest.init(url: getLoginURL!, cachePolicy:NSURLRequest.CachePolicy.useProtocolCachePolicy , timeoutInterval: 60.0)
        requestData.httpMethod = "POST"
        requestData.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        requestData.addValue(postLength, forHTTPHeaderField: "Content-Length")
        requestData.httpBody = postData
        
        print("[AppDelegate] Preparing to shared the session...")
        
        let loginSession = URLSession.shared
        // var successMessage: NSInteger = 1
        
        
        
        let loginSessionDataTask: URLSessionDataTask = loginSession.dataTask(with: requestData as URLRequest) { (retrievedData, response, error) in
            do {
                
                print("[AppDelegate] Sending token...")
                
                guard error == nil else { return }
                
                guard let responsedData = retrievedData else {
                    return
                }
                
                let loginDataFromJSON = try JSONSerialization.jsonObject(with: responsedData, options: []) as! NSDictionary
                
                //successMessage = (loginDataFromJSON.valueForKey("status")?.integerValue)!
                
                print("[SaifonVCController] Data retrieved is ",responsedData)
                print("[SaifonVCController] Check status is ", loginDataFromJSON.value(forKey: "status"))
                print("[SaifonVCController] Status message is ", loginDataFromJSON.value(forKey: "message"))
            
            }
            catch let error as NSError
            {
                print("[SaifonVCController] Error while retrieve login data ",error)
            }
        }
        
        loginSessionDataTask.resume()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        application.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID notification center: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
}
// [END ios_10_message_handling]
// [START ios_10_data_message_handling]
extension AppDelegate : MessagingDelegate {
    // Receive data message on iOS 10 devices while app is in the foreground.
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print(fcmToken)
    }
}











