//
//  ViewController.swift
//  AirQualityApp
//
//  Created by casandra grullon on 1/9/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var country = [Country]()
    var city = [City]()
    
    var airMeasurements = [AirQuality](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var searchQuery = "" {
        didSet{
            country = country.filter{ ($0.name?.lowercased().contains(searchQuery.lowercased()) ?? false)}
            loadCity(for: country.first?.code ?? "")
            loadAirMeasurements(for: city.first?.name ?? "")
            //city = city.filter{$0.name.lowercased().contains(searchQuery)}
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCountry()
//        loadCity(for: "CN")
        //loadAirMeasurements(for: searchQuery)
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "cityCell")
    }
    
    func loadCountry() {
        AirQualityAPIClient.getCountries { [weak self] (result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "AppError", message: "\(appError)")
                }
            case .success(let country):
                self?.country = country
            }
        }
    }
    func loadCity(for countryCode: String){
        AirQualityAPIClient.getCities(for: countryCode) { [weak self] (result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "AppError", message: "\(appError)")
                }
            case .success(let city):
                self?.city = city
            }
        }
    }
    
    func loadAirMeasurements(for city: String) {
        AirQualityAPIClient.getMeasurements(for: city) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "App Error", message: "\(appError)")
                }
            case .success(let airMeasure):
                self?.airMeasurements = airMeasure
            }
        }
        
    }
    
}


extension CountryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchText
    }
}
extension CountryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? CityCell else {
            fatalError("issue with cell")
        }
        let city = airMeasurements[indexPath.row]
        cell.configureCell(for: city)
        return cell
    }
    
    
}
extension CountryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
