//
//  WeatherVC.swift
//  Saifon
//
//  Created by Hainizam on 03/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {

    //MARK: - IBOUTLET
    @IBOutlet weak var collectionView: UICollectionView!
    //@IBOutlet weak var circleBlueImage: UIImageView!
    @IBOutlet weak var rotateImageIndicator: UIImageView!
    @IBOutlet weak var tempNameLabel: UILabel!
    @IBOutlet weak var tempValueLabel: UILabel!
    @IBOutlet weak var humiNameLabel: UILabel!
    @IBOutlet weak var humiValueLabel: UILabel!
    @IBOutlet weak var windNameLabel: UILabel!
    @IBOutlet weak var windValueLabel: UILabel!
    
    var weatherList = [Weather]()
    var loadingSpinner: LoadingSpinner!
    
    //MARK: - Variables for setting up loading spinner.
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempNameLabel.text = ""
        tempValueLabel.text = ""
        humiNameLabel.text = ""
        humiValueLabel.text = ""
        windNameLabel.text = ""
        windValueLabel.text = ""
        
        loadingSpinner = LoadingSpinner.init(view: view, isNavBar: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.initLargeTitles()
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshed(_:)))
        
        self.tabBarController?.navigationController?.navigationBar.tintColor = .white
        self.tabBarController?.navigationItem.rightBarButtonItem = refreshButton
        
        if(Libraries().CheckInternetConnection(self) == true)
        {
            if weatherList.count <= 0 {
                loadingSpinner.setLoadingScreen()
                self.populateData()
            }
        } else {
            Alert().showAlert(self, title: "Amaran!", message: "Tiada talian rangkaian")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    func updateSaifonCompas(_ weatherList: [Weather]) -> [Weather]{
        
        var tempWeatherList = [Weather]()
        
        for i in 0..<weatherList.count {
            
            print(i)
            
            if weatherList[i].sensorId == "TC"{
                self.tempNameLabel.text = "Kota Belud"
                self.tempValueLabel.text = "\(weatherList[i].value!) \(weatherList[i].unit!)"
                print(weatherList[i].sensorId!)
            } else if weatherList[i].sensorId == "HUM"{
                self.humiNameLabel.text = weatherList[i].description
                self.humiValueLabel.text = "\(weatherList[i].value!) \(weatherList[i].unit!)"
                print(weatherList[i].sensorId!)
            } else if weatherList[i].sensorId == "ANE"{
                self.windNameLabel.text = weatherList[i].description
                self.windValueLabel.text = "\(weatherList[i].value!) \(weatherList[i].unit!)"
                print(weatherList[i].sensorId!)
            } else if weatherList[i].sensorId == "WV"{
                
                let degree = getDirectionVal(weatherList[i].value!)
                print(degree)
                
                var rotateImage = UIImage(named: "compass2.png")!
                rotateImage = rotateImage.imageRotatedByDegrees(degree, flip: false)
                rotateImageIndicator.image = rotateImage
                print(weatherList[i].sensorId!)
            } else {
                
                print(weatherList[i].sensorId!)
                tempWeatherList.append(weatherList[i])
            }
        }
        print("\(tempWeatherList.count)")
        
        return tempWeatherList
    }
    
    func getDirectionVal(_ windDirection: String) -> CGFloat {
        
        switch windDirection {
            case "N":
                return 0.0;
            case "NNE":
                return 22.5;
            case "NE":
                return 45.0;
            case "ENE":
                return 67.5;
            case "E":
                return 90.0;
            case "ESE":
                return 112.5;
            case "SE":
                return 135.0;
            case "SSE":
                return 157.5;
            case "S":
                return 180.0;
            case "SSW":
                return 202.5;
            case "SW":
                return 225;
            case "WSW":
                return 247.5;
            case "W":
                return 270.0;
            case "WNW":
                return 292.5;
            case "NW":
                return 315;
            case "NNW":
                return 337.5;
            default:
                return 360.0;
        }
    }
    
    fileprivate func populateData() {
        
        let request = WeatherRequest()
        
        let priority = DispatchQoS.QoSClass.background
        DispatchQueue.global(qos: priority).async {
            
            request.weatherRequest(self, completion: { (response) in
                
                DispatchQueue.main.async {
                    
                    guard let responseData = response else {
                        Alert().showAlert(self, title: "Amaran!", message: "Gagal untuk mendapatkan maklumat.")
                        return
                    }
                    
                    self.weatherList = responseData
                    self.weatherList = self.updateSaifonCompas(self.weatherList)
                    self.loadingSpinner.removeLoadingScreen()
                    self.collectionView.reloadData()
                }
            })
        }
    }
    
    func refreshed(_ sender: UIRefreshControl) {
        
        if(Libraries().CheckInternetConnection(self) == true)
        {
            loadingSpinner.setLoadingScreen()
            self.populateData()
        } else {
            
            Alert().showAlert(self, title: "Amaran!", message: "Tiada talian rangkaian")
        }
    }
}

extension WeatherVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weathercell", for: indexPath) as! WeatherCell
        
        cell.weather = weatherList[indexPath.row]
        
        return cell
    }
}

extension WeatherVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight: CGFloat = 110.0
        let cellWidth: CGFloat = self.view.bounds.width/2 - 4
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}






























