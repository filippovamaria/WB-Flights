//
//  CurrentFlightData.swift
//  WB-Flights
//
//  Created by Мария Филиппова on 07.06.2022.
//

import UIKit

// MARK: Создвем словарь для хранения состояний кнопки Лайк по токену перелета
// только таким образом при переиспользование ячеек сохраняется текущее состояние

var likeState = [String:Bool]()

// MARK: Модель данный для заполнени интерфейса

struct Model {
    static let dateFormatter: DateFormatter = { // используем, чтоб преобразовать дату для первого экрана
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        df.locale = Locale(identifier: "ru_MD")
        return df
    }()
    
    static let dateFormatterForDetailVC: DateFormatter = { // используем, чтоб преобразовать дату для второго экрана
        let df = DateFormatter()
        df.dateFormat = "dd MMMM yyyy"
        df.locale = Locale(identifier: "ru_MD")
        return df
    }()

    struct CurrentFlights: Decodable {
            var data: [Data]?
        }
}

struct Data: Decodable {
    var startCity: String?
    var startCityCode: String?
    var endCity: String?
    var endCityCode: String?
    
    var startDate: String?
    var startDateString: String {
        guard let startDate = startDate else { return "" }
        return Model.dateFormatter.string(from: startDate.toDate() ?? Date())
    }
    var startDateStringForDetailVC: String {
        guard let startDate = startDate else { return "" }
        return Model.dateFormatterForDetailVC.string(from: startDate.toDate() ?? Date())
    }
    
    var endDate: String?
    var endDateString: String {
        guard let endDate = endDate else { return "" }
        return Model.dateFormatter.string(from: endDate.toDate() ?? Date())
    }
    var endDateStringForDetailVC: String {
        guard let endDate = endDate else { return "" }
        return Model.dateFormatterForDetailVC.string(from: endDate.toDate() ?? Date())
    }
    
    var price: Int?
    var searchToken: String?
}
