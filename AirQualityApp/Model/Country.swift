//
//  Air.swift
//  AirQualityApp
//
//  Created by casandra grullon on 1/9/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

struct CountryResults: Codable {
    let results: [Country]
}
struct Country: Codable {
    let country: String
    let name: String
}
