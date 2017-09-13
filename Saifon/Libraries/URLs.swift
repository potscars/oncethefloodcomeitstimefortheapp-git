//
//  URLs.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 03/11/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class URLs: NSObject {

    static func kSAIFON_API_URL() -> String { return "http://saifon.my/api" }
    
    static func kSAIFON_TOKEN_URL() -> String { return "\(kSAIFON_API_URL())/mobile" }
    static func kSAIFON_LANDING_PAGE_URL() -> String { return "\(kSAIFON_API_URL())/landing-page" }
    static func kSAIFON_WATER_LEVEL_DATA_URL(_ amount:String) -> String { return "\(kSAIFON_API_URL())/water-level-data?amount=\(amount)" }
    static func kSAIFON_WATER_GRAPH_URL(_ location_id: String) -> String { return "\(kSAIFON_API_URL())/water-level-data-bylocation?location_id=\(location_id)" }
    static func kSAIFON_LATEST_SENSOR() -> String { return "\(kSAIFON_API_URL())/libelium/latest-data" }
}
