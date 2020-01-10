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
    @IBOutlet weak var countryLabel: UILabel!
    
    var city: City?
    
    func configureCell(for city: City){
        cityLabel.text = city.name
        countryLabel.text = city.country
    }
}
