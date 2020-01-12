//
//  CityCell.swift
//  AirQualityApp
//
//  Created by casandra grullon on 1/9/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    var city: AirQuality?
    
    func configureCell(for city: AirQuality){
        cityLabel.text = city.city
        locationLabel.text = city.location
        countryLabel.text = city.country
    }
}
