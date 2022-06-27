//
//  ExploreCell.swift
//  TravelApp
//
//  Created by Edoardo Benissimo on 27/06/22.
//
import UIKit

class ExploreCell: UICollectionViewCell {
    static let reuseIdentifier = "ExploreCell"
    let backgroundImage = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundImage.layer.cornerRadius = 5
        backgroundImage.clipsToBounds = true
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        return nil
    }
    func configCell(with destination: Destination) {
        backgroundImage.image = UIImage(named: destination.destinationImage)
    }
}

