//
//  InfoCell.swift
//  TravelApp
//
//  Created by Edoardo Benissimo on 27/06/22.
//

import UIKit

class InfoCell: UICollectionViewCell {
    static let reuseIdentifier = "InfoCell"
    let containerView = UIView()
    let infoTitle = UILabel()
    let infoSubtitle = UILabel()
    let emoticon = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        containerView.backgroundColor = .white.withAlphaComponent(0.2)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        infoTitle.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .semibold))
        infoTitle.textColor = .white
        infoSubtitle.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 14, weight: .regular))
        infoSubtitle.textColor = .white
        infoSubtitle.numberOfLines = 0
        emoticon.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 18))
        emoticon.translatesAutoresizingMaskIntoConstraints = false
        let stackView = UIStackView(arrangedSubviews: [infoTitle, infoSubtitle])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(stackView)
        containerView.addSubview(emoticon)
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            emoticon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            emoticon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: emoticon.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -14),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14)
        ])
        stackView.setCustomSpacing(8, after: infoTitle)
    }
    required init?(coder: NSCoder) {
        return nil
    }
    func configCell(with info: Info) {
        infoTitle.text = info.title
        infoSubtitle.text = info.subtitle
        emoticon.text = info.emoticon
    }
}

