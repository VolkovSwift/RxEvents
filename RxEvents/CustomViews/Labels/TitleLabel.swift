//
//  TitleLabel.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import UIKit

final class TitleLabel: UILabel {
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    convenience init() {
        self.init(frame: .zero)
        font = .systemFont(ofSize: 13, weight: .medium)
    }

    //MARK: - Private Methods
    
    private func configure() {
        textColor = UIColor.main
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
