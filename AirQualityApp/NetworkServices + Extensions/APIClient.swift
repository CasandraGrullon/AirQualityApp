//
//  APIClient.swift
//  AirQualityApp
//
//  Created by casandra grullon on 1/9/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

struct AirQualityAPIClient {
    static func getCountries(completion: @escaping (Result<[Country], AppError>) -> () ){
        
        let endpointURL = "https://api.openaq.org/v1/countries"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let countryResults = try JSONDecoder().decode(CountryResults.self, from: data)
                    let country = countryResults.results
                    completion(.success(country))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    static func getCities(completion: @escaping (Result<[City], AppError>) -> () ) {
        
        let endpointURL = "https://api.openaq.org/v1/cities"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let cityResults = try JSONDecoder().decode(CityResults.self, from: data)
                    let city = cityResults.results
                    completion(.success(city))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    static func getMeasurements(completion: @escaping (Result<[AirQuality], AppError>) -> () ){
        
        let endpointURL = "https://api.openaq.org/v1/measurements"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let airQualityResults = try JSONDecoder().decode(AirQualityResults.self, from: data)
                    let airQuality = airQualityResults.results
                    completion(.success(airQuality))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    static func getLatestResults(completion: @escaping (Result<[Latest], AppError>) -> () ){
        
        let endpointURL = "https://api.openaq.org/v1/latest"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let latestResults = try JSONDecoder().decode(LatestResults.self, from: data)
                    let latest = latestResults.results
                    completion(.success(latest))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
