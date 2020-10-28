//
//  VerticalStackView.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import UIKit

class VerticalStackView: UIStackView {
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)

        arrangedSubviews.forEach { addArrangedSubview($0) }

        self.spacing = spacing
        axis = .vertical
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
