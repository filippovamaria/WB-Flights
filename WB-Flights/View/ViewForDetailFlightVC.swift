//
//  ViewForDetailFlightVC.swift
//  WB-Flights
//
//  Created by Мария Филиппова on 07.06.2022.
//

import UIKit

class ViewForDetailFlightVC: UIView {
    
    private let likeTap = UITapGestureRecognizer() // жест, чтоб можно было нажать на лайк
    var searchToken: String? // получаем токен перелета, с которой мы попадаем на экран
    
    private lazy var viewDeparture: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewArrival: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var startCityDeparture: UILabel = { // город отправления для первого вью
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var startCityArrival: UILabel = { // город отправления для второго вью
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var startCityCodeDeparture: UILabel = { // код города отправления для первого вью
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var startCityCodeArrival: UILabel = { // код города отправления для второго вью
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var startCityDate: UILabel = { // дата отправления
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var endCityDepature: UILabel = { // город прибытия для первого вью
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var endCityArrival: UILabel = { // город прибытия для второго вью
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var endCityCodeDepature: UILabel = { // код города прибытия для первого вью
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var endCityCodeArrival: UILabel = { // код города прибытия для второго вью
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var endCityDate: UILabel = { // дата возвращения
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var price: UILabel = { // цена
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceСurrency: UILabel = { // валюта, в которой указана цена
        let label = UILabel()
        label.text = "руб"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var like: UIImageView = { // кнопка нравится или нет перелет
        let like = UIImageView()
        like.image = UIImage(systemName: "heart")
        like.tintColor = #colorLiteral(red: 0.2107302547, green: 0.04717936367, blue: 0.3348342776, alpha: 1)
        like.isUserInteractionEnabled = true
        like.translatesAutoresizingMaskIntoConstraints = false
        return like
    }()
    
    private lazy var airplaneDepature: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "airplane.departure")
        imageView.tintColor = #colorLiteral(red: 0.2107302547, green: 0.04717936367, blue: 0.3348342776, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var airplaneArrival: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "airplane.arrival")
        imageView.tintColor = #colorLiteral(red: 0.2107302547, green: 0.04717936367, blue: 0.3348342776, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: Стэки для удобства заполнения экрана
    
    private lazy var startCityDepatureStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 1
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var startCityArrivalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 1
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var endCityDepatureStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 1
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var endCityArrivalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 1
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var priceStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemGray5
        
        setUp()
        setUpGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Устанавливаем констрейнты
    
    private func setUp() {
  
        self.addSubview(viewDeparture)
        self.addSubview(viewArrival)
        self.addSubview(priceStack)
        self.addSubview(startCityDepatureStack)
        self.addSubview(endCityDepatureStack)
        self.addSubview(startCityArrivalStack)
        self.addSubview(endCityArrivalStack)
        self.addSubview(like)
        self.addSubview(startCityDate)
        self.addSubview(endCityDate)
        self.addSubview(airplaneDepature)
        self.addSubview(airplaneArrival)
        
        priceStack.addArrangedSubview(price)
        priceStack.addArrangedSubview(priceСurrency)
        startCityDepatureStack.addArrangedSubview(startCityDeparture)
        startCityDepatureStack.addArrangedSubview(startCityCodeDeparture)
        endCityDepatureStack.addArrangedSubview(endCityDepature)
        endCityDepatureStack.addArrangedSubview(endCityCodeDepature)
        startCityArrivalStack.addArrangedSubview(startCityArrival)
        startCityArrivalStack.addArrangedSubview(startCityCodeArrival)
        endCityArrivalStack.addArrangedSubview(endCityArrival)
        endCityArrivalStack.addArrangedSubview(endCityCodeArrival)
        
        
        
        NSLayoutConstraint.activate([viewDeparture.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
                                     viewDeparture.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                                     viewDeparture.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                                     viewDeparture.heightAnchor.constraint(equalToConstant: 200)])
        
        NSLayoutConstraint.activate([viewArrival.topAnchor.constraint(equalTo: viewDeparture.bottomAnchor, constant: 30),
                                     viewArrival.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                                     viewArrival.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                                     viewArrival.heightAnchor.constraint(equalToConstant: 200)])
        
        NSLayoutConstraint.activate([priceStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
                                     priceStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)])
        
        NSLayoutConstraint.activate([startCityDepatureStack.topAnchor.constraint(equalTo: viewDeparture.topAnchor, constant: 30),
                                     startCityDepatureStack.leadingAnchor.constraint(equalTo: viewDeparture.leadingAnchor, constant: 20)])
        
        NSLayoutConstraint.activate([endCityDepatureStack.bottomAnchor.constraint(equalTo: viewDeparture.bottomAnchor, constant: -30),
                                     endCityDepatureStack.leadingAnchor.constraint(equalTo: viewDeparture.leadingAnchor, constant: 20)])
        
        NSLayoutConstraint.activate([endCityArrivalStack.topAnchor.constraint(equalTo: viewArrival.topAnchor, constant: 30),
                                     endCityArrivalStack.leadingAnchor.constraint(equalTo: viewArrival.leadingAnchor, constant: 20)])
        
        NSLayoutConstraint.activate([startCityArrivalStack.bottomAnchor.constraint(equalTo: viewArrival.bottomAnchor, constant: -30),
                                     startCityArrivalStack.leadingAnchor.constraint(equalTo: viewArrival.leadingAnchor, constant: 20)])
        
        NSLayoutConstraint.activate([like.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
                                     like.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                                     like.widthAnchor.constraint(equalToConstant: 45),
                                     like.heightAnchor.constraint(equalToConstant: 40)])
        
        NSLayoutConstraint.activate([startCityDate.topAnchor.constraint(equalTo: viewDeparture.topAnchor, constant: 30),
                                     startCityDate.trailingAnchor.constraint(equalTo: viewDeparture.trailingAnchor, constant: -20),
                                     startCityDate.widthAnchor.constraint(equalToConstant: 80)])
        
        NSLayoutConstraint.activate([endCityDate.topAnchor.constraint(equalTo: viewArrival.topAnchor, constant: 30),
                                     endCityDate.trailingAnchor.constraint(equalTo: viewArrival.trailingAnchor, constant: -20),
                                     endCityDate.widthAnchor.constraint(equalToConstant: 80)])
        
        NSLayoutConstraint.activate([airplaneDepature.bottomAnchor.constraint(equalTo: viewDeparture.bottomAnchor, constant: -30),
                                     airplaneDepature.trailingAnchor.constraint(equalTo: viewDeparture.trailingAnchor, constant: -20),
                                     airplaneDepature.widthAnchor.constraint(equalToConstant: 80),
                                     airplaneDepature.heightAnchor.constraint(equalToConstant: 50)])
        
        NSLayoutConstraint.activate([airplaneArrival.bottomAnchor.constraint(equalTo: viewArrival.bottomAnchor, constant: -30),
                                     airplaneArrival.trailingAnchor.constraint(equalTo: viewArrival.trailingAnchor, constant: -20),
                                     airplaneArrival.widthAnchor.constraint(equalToConstant: 80),
                                     airplaneArrival.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    // MARK: Устанавливаем жест, чтоб можно было менят состояние кнопки Like
    
    private func setUpGesture() {
        
        likeTap.addTarget(self, action: #selector(didTapLikeButton))
        like.addGestureRecognizer(likeTap)
    }
    
    @objc private func didTapLikeButton(_ gestureRecognizer: UITapGestureRecognizer) {
        
        guard likeTap === gestureRecognizer else { return }
        guard let searchToken = searchToken else { return }
        
        if likeState[searchToken] ?? false {
            likeState[searchToken] = false
            like.image = UIImage(systemName: "heart")
        } else {
            likeState[searchToken] = true
            like.image = UIImage(systemName: "heart.fill")
        }
    }
}

