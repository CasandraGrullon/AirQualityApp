//
//  City.swift
//  AirQualityApp
//
//  Created by casandra grullon on 1/9/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

struct CityResults: Codable {
    let results: [City]
}
struct City: Codable {
    let country: String
    let name: String
}
