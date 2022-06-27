//
//  PlanTravelCell.swift
//  TravelApp
//
//  Created by Edoardo Benissimo on 27/06/22.
//

import UIKit

class PlanTravelCell: UICollectionViewCell {
    static let reuseIdentifier = "PlanTravelCell"
    var stackView = UIStackView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 44
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    private func generateSubView(step: PlanSteps) -> UIView {
        let roundedView = UIView()
        let label = UILabel()
        let infoLabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = step.emoticon
        label.textAlignment = .center
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        roundedView.backgroundColor = .white.withAlphaComponent(0.3)
        roundedView.layer.cornerRadius = 40
        roundedView.clipsToBounds = true
        roundedView.addSubview(label)
        infoLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .semibold))
        infoLabel.textColor = .white
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        let stackView = UIStackView(arrangedSubviews: [roundedView, infoLabel])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        infoLabel.text = step.title
        infoLabel.textAlignment = .center
        stackView.setCustomSpacing(8, after: roundedView)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor),
            label.topAnchor.constraint(equalTo: roundedView.topAnchor),
            label.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor),
            roundedView.heightAnchor.constraint(equalToConstant: 80)
        ])
        return stackView
    }
    required init?(coder: NSCoder) {
        return nil
    }
    func configCell(with plan: Plan) {
        stackView.addArrangedSubview(generateSubView(step: plan.steps[0]))
        stackView.addArrangedSubview(generateSubView(step: plan.steps[1]))
        stackView.addArrangedSubview(generateSubView(step: plan.steps[2]))
    }
}

