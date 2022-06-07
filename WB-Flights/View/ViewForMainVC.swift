//
//  ViewForMainVC.swift
//  WB-Flights
//
//  Created by Мария Филиппова on 07.06.2022.
//

import UIKit

// MARK: Протокол, чтоб делегировать VC переход на второй экран

protocol ViewForMainVCDelegate: AnyObject {
    func didTapRow(flight: Data, searchToken: String)
}

// MARK: Создаем кастомное вью для воторого экрана

class ViewForMainVC: UIView {
    
    weak var delegate: ViewForMainVCDelegate?
    
    // MARK: Перменная для хранения перелетов с API
    
    var flights = [Data]() { // устанавливаем наблюдатель, чтоб при заполнение массива сразу пропадал индикатор и обновлялась таблица
        didSet {
            indicator.stopAnimating()
            indicator.isHidden = true
            tableView.reloadData()
        }
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellForMainVC.self, forCellReuseIdentifier: "DefaultCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: Индикатор работает пока загружается контент интерфейса
    
    private lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Устанавливаем констрейнты для VC и запускаем индикатор загрузки
    
    private func setUp() {
        
        indicator.startAnimating()
        
        self.addSubview(tableView)
        self.addSubview(indicator)
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: self.topAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
        
        NSLayoutConstraint.activate([indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
    }
}

// MARK: Расширения для работы с протоколами таблицы и делегатом ячейки

extension ViewForMainVC: UITableViewDelegate, UITableViewDataSource, CellForMainVCDelegate {
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath) as! CellForMainVC
        cell.selectionStyle = .none
        cell.delegate = self
        
        // Запоняем ячейку в соответсвие с перелетом из массива flights
        
        cell.startCity.text = flights[indexPath.row].startCity ?? ""
        cell.startCityCode.text = flights[indexPath.row].startCityCode ?? ""
        cell.startCityDate.text = flights[indexPath.row].startDateString
        
        cell.endCity.text = flights[indexPath.row].endCity ?? ""
        cell.endCityCode.text = flights[indexPath.row].endCityCode ?? ""
        cell.endCityDate.text = flights[indexPath.row].endDateString
        
        cell.price.text = String(flights[indexPath.row].price ?? 0)
        cell.searchToken = flights[indexPath.row].searchToken ?? ""
        
        // Проверяем состояние кнопки по токен ключу в словаре, где они храняться, и устанвливаем соответсвующие изображение
     
        if likeState[cell.searchToken] ?? false {
            cell.like.image = UIImage(systemName: "heart.fill")
        } else {
            cell.like.image = UIImage(systemName: "heart")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        flights.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    // с помощью созданого нами протокола делегируем переход при тапе MainVC
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CellForMainVC
        delegate?.didTapRow(flight: flights[indexPath.row], searchToken: cell.searchToken)
    }
    
    func changeLikeState(cell: CellForMainVC) {
        
        // узнаем индекс текущей ячейки
        guard let index = tableView.indexPath(for: cell)?.row else { return }
        
        // узнаем indexPath текущей ячейки
        let indexRow = IndexPath(row: index, section: 0)
        
        // при тапе мы поменяли значение переменной wasTappedLike, поэтому новое значение передаем в массив, где хранятся все значения
        likeState[cell.searchToken] = cell.wasTappedLike
        
        // обновляем ячейку
        tableView.reloadRows(at: [indexRow], with: .none)
    
    }
}
