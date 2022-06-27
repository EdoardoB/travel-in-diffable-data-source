//
//  SectionHeader.swift
//  TravelApp
//
//  Created by Edoardo Benissimo on 27/06/22.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeader"
    let sectionTitle = UILabel()
    let sectionCTA = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sectionTitle.textColor = .white
        self.sectionCTA.titleLabel?.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .semibold))
        self.sectionCTA.setTitleColor(.systemBlue, for: .normal)
        let stackView = UIStackView(arrangedSubviews: [sectionTitle, sectionCTA])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14)
        ])
    }
    required init?(coder: NSCoder) {
        return nil
    }
    func configHeader(title: String, CTA: String? = nil, fontSize: CGFloat = 24) {
        self.sectionTitle.text = title
        if CTA != nil {
            self.sectionCTA.setTitle(CTA!, for: .normal)
        } else {
            self.sectionCTA.isHidden = true
        }
        self.sectionTitle.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: fontSize, weight: .semibold))
    }
}

