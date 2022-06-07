//
//  MainVC.swift
//  WB-Flights
//
//  Created by Мария Филиппова on 07.06.2022.
//

import UIKit

// MARK: Главный экран приложения

class MainViewController: UIViewController {
    
    var networkManager = NetworkManager() // создаем экземпляр, чтоб запустить функцию получения данных с API
    
    lazy var viewForMainVC: ViewForMainVC = {
        let view = ViewForMainVC()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: При переходе со второго экрана мы можем поменять состояние кнопки Like поэтому обновляем таблицу
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewForMainVC.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        
        networkManager.closure = { currentFlights in
            self.viewForMainVC.flights = currentFlights
        }
        
        networkManager.featch()
        setUp()
        setUpNavigationBar()
    }
    
    // MARK: Устанавливаем констрейнты для VC
    
    private func setUp() {
        
        view.addSubview(viewForMainVC)

        NSLayoutConstraint.activate([viewForMainVC.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     viewForMainVC.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     viewForMainVC.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     viewForMainVC.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    // MARK: Делаем кастомный навигейшен бар
    
    private func setUpNavigationBar() {
        
        title = "Актуальные перелеты"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = #colorLiteral(red: 0.2872120142, green: 0.06529966742, blue: 0.4568527341, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

// MARK: Работаем с делегатом View для перехода на второй VC

extension MainViewController: ViewForMainVCDelegate {

    func didTapRow(flight: Data, searchToken: String) {
        
        let detailFlightVC = DetailFlightVC()
        detailFlightVC.currentFlight = flight
        detailFlightVC.viewForDetailFlightVC.searchToken = searchToken
        navigationController?.pushViewController(detailFlightVC, animated: true)
    }
}
