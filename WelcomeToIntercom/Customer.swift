//
//  Customer.swift
//  WelcomeToIntercom
//
//  Created by Kızılay on 29.04.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

import Foundation
import UIKit
//"latitude": "52.986375", "user_id": 12, "name": "Christina McArdle", "longitude": "-6.043701"
struct Customer {
    let userId: Int
    var name: String
    var latitude: String
    var longitude: String
}

extension Customer: Decodable {
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case latitude
        case longitude
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userId = try container.decode(Int.self, forKey: .userId)
        name = try container.decode(String.self, forKey: .name)
        latitude = try container.decode(String.self, forKey: .latitude)
        longitude = try container.decode(String.self, forKey: .longitude)
    }
}
