//
//  Measurements.swift
//  AirQualityApp
//
//  Created by casandra grullon on 1/9/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

struct AirQualityResults: Codable {
    let results: [AirQuality]
}
struct AirQuality: Codable {
    let location: String?
    let value: Double?
    let unit: String?
    let coordinates: Coordinates?
    let country: String?
    let city: String?
}
struct Coordinates: Codable {
    let latitude: Double?
    let longitude: Double?
}
