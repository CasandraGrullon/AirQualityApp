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
    var cities = [City](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var searchQuery = "" {
        didSet{
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCountry()
        loadCities(for: country.first?.code ?? "CN")
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "cityCell")
    }
    
    func loadCountry(){
        AirQualityAPIClient.getCountries { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "App Error", message: "\(appError)")
                }
            case .success(let country):
                self?.country = country
            }
        }
    }
    
    func loadCities(for country: String){
        AirQualityAPIClient.getCities(for: country) { [weak self] (result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "App Error", message: "\(appError)")
                }
            case .success(let city):
                self?.cities = city
            }
        }
    }
    
}


extension CountryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadCities(for: country.first?.code ?? "CN")
            return
        }
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
        let city = cities[indexPath.row]
        cell.configureCell(for: city)
        return cell
    }

    
}
extension CountryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
