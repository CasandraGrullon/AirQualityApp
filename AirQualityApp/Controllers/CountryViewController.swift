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
    
    var country: Country?
    
    var cities = [City](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var searchQuery = "" {
        didSet{
            loadCountries(for: searchQuery)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "cityCell")
    }

    func loadCountries(for search: String) {
        guard let countryName = country?.name else {
            return
        }
        if search == countryName {
            AirQualityAPIClient.getCountries { [weak self] (result) in
                switch result{
                case .failure(let appError):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Country App Error", message: "\(appError)")
                    }
                case .success(let country):
                    self?.country = country
                }
            }
        }
    }
    
    func loadCities(for code: String) {
        if code == country?.code {
            AirQualityAPIClient.getCities { [weak self] (result) in
                switch result{
                case .failure(let appError):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "City App Error", message: "\(appError)")
                    }
                case .success(let cities):
                    self?.cities = cities.filter{$0.country == code}
                }
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
        return cities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? CityCell else {
            fatalError("issue with cell")
        }
        let city = cities[indexPath.row]
        cell.configureCell(for: city, for: country?.name ?? "colombia")
        return cell
    }
}
extension CountryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}
