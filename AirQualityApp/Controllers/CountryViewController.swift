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
    
    var airMeasurements = [AirQuality](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var searchQuery = "" {
        didSet{
            loadAirMeasurements(for: searchQuery)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "cityCell")
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

extension CountryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airMeasurements.count
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
        return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let airDetailVC = storyboard?.instantiateViewController(identifier: "AirQualityDetails") as? AirQualityViewController else {
            fatalError("could not connect to detail vc")
        }
        let airQuality = airMeasurements[indexPath.row]
        airDetailVC.airQuality = airQuality
        navigationController?.pushViewController(airDetailVC, animated: true)
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
