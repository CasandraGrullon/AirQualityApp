//
//  Latest.swift
//  AirQualityApp
//
//  Created by casandra grullon on 1/9/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

struct LatestResults: Codable {
    let results: [Latest]
}
struct Latest: Codable {
    let location: String
    let city: String
    let country: String
    let distance: Double
    let measurements: [MeasurementDetails]
}
struct MeasurementDetails: Codable {
    let value: Int
    let lastUpdated: String
    let unit: String
    let coordinates: LatLong
}
struct LatLong: Codable {
    let latitude: Double
    let longitude: Double
}
