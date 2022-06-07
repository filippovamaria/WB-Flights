//
//  NetworkManager.swift
//  WB-Flights
//
//  Created by Мария Филиппова on 07.06.2022.
//

import UIKit

// MARK: Работаем с API

struct NetworkManager {
    
    var closure: (([Data]) -> Void)?
    
    func featch() {
        let urlString = "https://travel.wildberries.ru/statistics/v1/cheap"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async{
                guard let data = data else { return }
                guard let currentFlights = self.parseJson(withData: data) else { return }
                self.closure?(currentFlights)
                for flight in currentFlights {
                    guard let searchToken = flight.searchToken else { return }
                    likeState[searchToken] = false
                }
            }
        }
        
        task.resume()
    }
    
    func parseJson(withData data: Foundation.Data) -> [Data]? {
        let decoder = JSONDecoder()

        do {
            let currentFlightsData = try decoder.decode(Model.CurrentFlights.self, from: data)
            return currentFlightsData.data ?? nil
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
