//
//  BigDestinationCell.swift
//  TravelApp
//
//  Created by Edoardo Benissimo on 27/06/22.
//

import UIKit

class BigDestinationCell: UICollectionViewCell {
    static let reuseIdentifier = "BigDestinationCell"
    var destinationImage = UIImageView()
    var destinationLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        destinationImage.layer.cornerRadius = 5
        destinationImage.clipsToBounds = true
        destinationImage.contentMode = .scaleAspectFill
        destinationLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .semibold))
        destinationLabel.textColor = .white
        let stackView = UIStackView(arrangedSubviews: [destinationImage, destinationLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            destinationImage.heightAnchor.constraint(equalToConstant: 200),
        ])
        stackView.setCustomSpacing(8, after: destinationImage)
    }
    required init?(coder: NSCoder) {
        return nil
    }
    func configCell(with destination: Destination) {
        destinationLabel.text = destination.destinationName
        destinationImage.image = UIImage(named: destination.destinationImage)
    }
}

