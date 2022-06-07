//
//  CellForMainVC.swift
//  WB-Flights
//
//  Created by Мария Филиппова on 07.06.2022.
//

import UIKit

// MARK: Протокол, чтоб делегировать View и была возможность найти индекс ячейки и потом по индексу состояние кнопки в массиве likeState

protocol CellForMainVCDelegate: AnyObject {
    func changeLikeState(cell: CellForMainVC)
}

//MARK: Кастомная ячейка

class CellForMainVC: UITableViewCell {
    
    weak var delegate: CellForMainVCDelegate?
    private let likeTap = UITapGestureRecognizer() // жест, чтоб можно было нажать на лайк
    var wasTappedLike = false // состояние кнопки Лайк по умолчанию
    var searchToken = ""
    
    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var startCity: UILabel = { // город отправления
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var startCityCode: UILabel = { // код города отправления
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var startCityDate: UILabel = { // дата отправления
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var endCity: UILabel = { // город прилета
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var endCityCode: UILabel = { // индекс города прилета
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var endCityDate: UILabel = { // дата прилета
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var price: UILabel = { // цена перелета
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var like: UIImageView = { // кнопка нравится или не нравится перелет
        let like = UIImageView()
        like.image = UIImage(systemName: "heart")
        like.tintColor = #colorLiteral(red: 0.2107302547, green: 0.04717936367, blue: 0.3348342776, alpha: 1)
        like.isUserInteractionEnabled = true
        like.translatesAutoresizingMaskIntoConstraints = false
        return like
    }()
    
    private lazy var arrowLeft: UIImageView = {
        let like = UIImageView()
        like.image = UIImage(named: "arrow-left")
        like.translatesAutoresizingMaskIntoConstraints = false
        return like
    }()
    
    private lazy var arrowRight: UIImageView = {
        let like = UIImageView()
        like.image = UIImage(named: "arrow-right")
        like.translatesAutoresizingMaskIntoConstraints = false
        return like
    }()
    
    // MARK: Стэки для удобства устоновления констрейнтов
    
    private lazy var dateStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 40
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var startCityStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var endCityStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .systemGray5
        
        setUp()
        setUpGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        startCity.text = nil
        startCityCode.text = nil
        startCityDate.text = nil
        endCity.text = nil
        endCityCode.text = nil
        endCityDate.text = nil
        price.text = nil
        like.image = nil
    }
    
    // MARK: Устанавливаем констрейнты для отоброжения контента внутри ячейки
    
    private func setUp() {
        
        contentView.addSubview(view)
        contentView.addSubview(arrowRight)
        contentView.addSubview(arrowLeft)
        contentView.addSubview(dateStack)
        contentView.addSubview(startCityStack)
        contentView.addSubview(endCityStack)
        contentView.addSubview(price)
        contentView.addSubview(like)
        
        dateStack.addArrangedSubview(startCityDate)
        dateStack.addArrangedSubview(endCityDate)
        startCityStack.addArrangedSubview(startCity)
        startCityStack.addArrangedSubview(startCityCode)
        endCityStack.addArrangedSubview(endCity)
        endCityStack.addArrangedSubview(endCityCode)

        NSLayoutConstraint.activate([view.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
                                     view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                                     view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                                     view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)])
                                     
        NSLayoutConstraint.activate([arrowRight.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -30),
                                     arrowRight.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -5),
                                     arrowRight.heightAnchor.constraint(equalToConstant: 10),
                                     arrowRight.widthAnchor.constraint(equalToConstant: 70)])
        
        NSLayoutConstraint.activate([arrowLeft.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -30),
                                     arrowLeft.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 5),
                                     arrowLeft.heightAnchor.constraint(equalToConstant: 10),
                                     arrowLeft.widthAnchor.constraint(equalToConstant: 70)])
        
        NSLayoutConstraint.activate([dateStack.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -30),
                                     dateStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                    ])
        
        NSLayoutConstraint.activate([startCityStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     startCityStack.trailingAnchor.constraint(equalTo: arrowRight.leadingAnchor, constant: -5),
                                     startCityStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)])
        
        NSLayoutConstraint.activate([endCityStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     endCityStack.leadingAnchor.constraint(equalTo: arrowRight.trailingAnchor, constant: 5),
                                     endCityStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)])
        
        NSLayoutConstraint.activate([price.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                                     price.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)])
        
        NSLayoutConstraint.activate([like.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                                     like.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                                     like.widthAnchor.constraint(equalToConstant: 25),
                                     like.heightAnchor.constraint(equalToConstant: 25)])
    }
    
    // MARK: Устанавливаем жест для изменения конпки Like
    
    private func setUpGesture() {
        
        likeTap.addTarget(self, action: #selector(didTapLikeButton))
        like.addGestureRecognizer(likeTap)
    }
    
    @objc private func didTapLikeButton(_ gestureRecognizer: UITapGestureRecognizer) {
        
        guard likeTap === gestureRecognizer else { return }
        
        wasTappedLike.toggle()
        delegate?.changeLikeState(cell: self)
    }
}

