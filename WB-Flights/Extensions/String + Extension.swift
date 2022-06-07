//
//  String + Extension.swift
//  WB-Flights
//
//  Created by Мария Филиппова on 07.06.2022.
//

import Foundation
 
extension String {
  
    // MARK: Создаем функцию для форматирования даты в более удобный формвт отображкения
    
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}
