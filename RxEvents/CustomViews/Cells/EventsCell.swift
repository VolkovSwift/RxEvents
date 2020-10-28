//
//  EventsCell.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import UIKit

final class EventsCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let reuseID = "EventsCell"
            
    weak var delegate: CellActionsDelegate?
    var object: EventObject?
    
    //MARK: - Private Properties
    
    private var titleLabel = TitleLabel()
    private var subtitleLabel = SubtitleLabel()
    private var favoriteButton = UIButton()
    
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureFavoriteButton()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    
    //MARK: - Methods
    
    func configure(object: EventObject, delegate: CellActionsDelegate) {
        let date = DateFormatter.Formatter.date(from: object.event.startTime) ?? Date()
        let convertedStartTime = DateFormatter.StringFormatter.string(from: date)
        
        self.object = object
        self.delegate = delegate
        titleLabel.text = object.event.title
        subtitleLabel.text = convertedStartTime
        favoriteButton.setImage(object.image, for: .normal)
        favoriteButton.tintColor = UIColor.main
    }
    
    //MARK: - Private Methods
    
    private func configureFavoriteButton() {
        let padding: CGFloat = 16
        let buttonSize: CGFloat = 25
        
        favoriteButton.addTarget(self, action: #selector(favoriteButtonWasPressed), for: .touchUpInside)
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            favoriteButton.widthAnchor.constraint(equalToConstant: buttonSize),
            favoriteButton.heightAnchor.constraint(equalToConstant: buttonSize),
            favoriteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
    }
    
    private func configureStackView() {
        let padding: CGFloat = 8
        
        let labelsStackView = VerticalStackView(arrangedSubviews: [titleLabel, subtitleLabel], spacing: 10)
        labelsStackView.distribution = .fillEqually
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelsStackView)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            labelsStackView.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -padding),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
    
    //MARK: - Actions
    
    @objc func favoriteButtonWasPressed() {
        guard let object = object else {
            return
        }
        delegate?.favoriteButtonWasPressed(event: object.event)
    }

}

