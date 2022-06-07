//
//  DetailFlightVC.swift
//  WB-Flights
//
//  Created by Мария Филиппова on 07.06.2022.
//

import UIKit

// MARK: Второй экран приложения

class DetailFlightVC: UIViewController {
    
    var currentFlight: Data? // перелет, который открываем детально
    
    lazy var viewForDetailFlightVC: ViewForDetailFlightVC = {
        let view = ViewForDetailFlightVC()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        
        setUp()
        setUpBackButton()
    }

    // MARK: Устанавливаем констрейнты и заполняем данные
    
    private func setUp() {
        
        viewForDetailFlightVC.startCityDeparture.text = currentFlight?.startCity ?? ""
        viewForDetailFlightVC.startCityArrival.text = currentFlight?.startCity ?? ""
        viewForDetailFlightVC.startCityCodeDeparture.text = currentFlight?.startCityCode ?? ""
        viewForDetailFlightVC.startCityCodeArrival.text = currentFlight?.startCityCode ?? ""
        viewForDetailFlightVC.startCityDate.text = currentFlight?.startDateStringForDetailVC ?? ""
        
        viewForDetailFlightVC.endCityDepature.text = currentFlight?.endCity ?? ""
        viewForDetailFlightVC.endCityArrival.text = currentFlight?.endCity ?? ""
        viewForDetailFlightVC.endCityCodeDepature.text = currentFlight?.endCityCode ?? ""
        viewForDetailFlightVC.endCityCodeArrival.text = currentFlight?.endCityCode ?? ""
        viewForDetailFlightVC.endCityDate.text = currentFlight?.endDateStringForDetailVC ?? ""
        
        viewForDetailFlightVC.price.text = String(currentFlight?.price ?? 0)
        
        guard let searchToken = viewForDetailFlightVC.searchToken else { return }
        
        viewForDetailFlightVC.like.image = likeState[searchToken] ?? false ?
        UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        
        view.addSubview(viewForDetailFlightVC)
        
        NSLayoutConstraint.activate([viewForDetailFlightVC.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     viewForDetailFlightVC.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     viewForDetailFlightVC.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     viewForDetailFlightVC.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    // MARK: Меняем кнопку возврата
    
    private func setUpBackButton() {
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
