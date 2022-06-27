//
//  HomeTravelViewController.swift
//  TravelApp
//
//  Created by Edoardo Benissimo on 27/06/22.
//

import UIKit

enum HomeTravelItem: Hashable {
    case plan(Plan)
    case explore(Destination)
    case info(Info)
    case main(Destination)
}
class HomeTravelViewController: UIViewController {
    var collectionView: UICollectionView!
    typealias DataSource = UICollectionViewDiffableDataSource<Section, HomeTravelItem>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, HomeTravelItem>
    var dataSource: DataSource?
    var sections: [Section] = Section.allCases
    
    enum Section: Int, CaseIterable {
        case plan
        case main
        case info
        case explore
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.createDataSource()
        self.applySnapshot()
    }
    
    private func setUI() {
        self.view.backgroundColor = .black
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setCollectionViewLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .black
        collectionView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        view.addSubview(collectionView)
        collectionView.register(BigDestinationCell.self, forCellWithReuseIdentifier: BigDestinationCell.reuseIdentifier)
        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: InfoCell.reuseIdentifier)
        collectionView.register(PlanTravelCell.self, forCellWithReuseIdentifier: PlanTravelCell.reuseIdentifier)
        collectionView.register(ExploreCell.self, forCellWithReuseIdentifier: ExploreCell.reuseIdentifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
    }
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, HomeTravelItem>(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
                case .explore(let destination):
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BigDestinationCell.reuseIdentifier, for: indexPath) as? BigDestinationCell else {
                        fatalError("Unable to dequeue")
                    }
                    cell.configCell(with: destination)
                    return cell
                case .info(let info):
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCell.reuseIdentifier, for: indexPath) as? InfoCell else {
                        fatalError("Unable to dequeue")
                    }
                    cell.configCell(with: info)
                    return cell
                case .plan(let plan):
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlanTravelCell.reuseIdentifier, for: indexPath) as? PlanTravelCell else {
                        fatalError("Unable to dequeue")
                    }
                    cell.configCell(with: plan)
                    return cell
                case .main(let destination):
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCell.reuseIdentifier, for: indexPath) as? ExploreCell else {
                        fatalError("Unable to dequeue")
                    }
                    cell.configCell(with: destination)
                    return cell
            }
        }
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let self = self, let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader else {
                return nil
            }
            switch self.sections[indexPath.section] {
                case .explore:
                    sectionHeader.configHeader(title: "Recommended Destinations")
                case .info:
                    sectionHeader.configHeader(title: "Info")
                case .plan:
                    sectionHeader.configHeader(title: "Plan a trip", fontSize: 34)
                case .main:
                    sectionHeader.configHeader(title: "Explore", CTA: "Explore All")
            }
            return sectionHeader
        }
    }
    func applySnapshot() {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections(Section.allCases)
        let explore: [HomeTravelItem] = [
            Destination(destinationName: "Roma", destinationImage: "roma"),
            Destination(destinationName: "Catania", destinationImage: "catania"),
            Destination(destinationName: "Parma", destinationImage: "parma"),
            Destination(destinationName: "Bologna", destinationImage: "bologna"),
            Destination(destinationName: "Firenze", destinationImage: "firenze"),
        ].map { .explore($0) }
        snapshot.appendItems(explore, toSection: .explore)
        let info: [HomeTravelItem] = [
            Info(title: "Lorem Ipsum", subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", emoticon: "✈️")
        ].map { .info($0) }
        snapshot.appendItems(info, toSection: .info)
        let plan: [HomeTravelItem] = [
            Plan(steps: [PlanSteps(emoticon: "✈️", title: "Flights"), PlanSteps(emoticon: "🏨", title: "Hotels"), PlanSteps(emoticon: "🚗", title: "Car Hire")])
        ].map { .plan($0) }
        snapshot.appendItems(plan, toSection: .plan)
        let mainSection: [HomeTravelItem] = [
            Destination(destinationName: "Catania", destinationImage: "catania"),
            Destination(destinationName: "Parma", destinationImage: "parma"),
            Destination(destinationName: "Roma", destinationImage: "roma")
        ].map { .main($0) }
        snapshot.appendItems(mainSection, toSection: .main)
        dataSource?.apply(snapshot)
    }
    private func setCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch self.sections[sectionIndex] {
                case .explore:
                    return self.createExploreLayout()
                case .plan:
                    return self.createPlanLayout()
                case .info:
                    return self.createInfoLayout()
                case .main:
                    return self.createMainLayout(environment: layoutEnvironment)
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 24
        layout.configuration = config
        return layout
    }
    func createExploreLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.50), heightDimension: .fractionalHeight(0.80))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 7, bottom: 0, trailing: 7)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        return layoutSection
    }
    func createPlanLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 0, bottom: 0, trailing: 0)
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        return layoutSection
    }
    func createInfoLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(94))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        return layoutSection
    }
    func createMainLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let estimatedFocusedItemWidth = Self.estimatedFocusedItemWidth(for: environment.container.contentSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(estimatedFocusedItemWidth), heightDimension: .absolute(256))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [layoutItem])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.visibleItemsInvalidationHandler = { items, offset, environment in
            for item in items {
                guard item.representedElementCategory == .cell else {
                    continue
                }
                let scale = Self.scale(for: environment.container.contentSize, itemFrame: item.frame, contentOffset: offset)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        let layoutSectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [layoutSectionHeader]
        return section
    }
    private class func scale(for containerSize: CGSize, itemFrame: CGRect, contentOffset: CGPoint) -> CGFloat {
        let maximumScale: CGFloat = 1
        let unfocusedItemScale = Self.estimatedUnfocusedItemWidth(for: containerSize) / Self.estimatedFocusedItemWidth(for: containerSize)
        let containerHorizontalCenter = containerSize.width / 2
        let distanceFromCenter = abs(itemFrame.midX - contentOffset.x - containerHorizontalCenter)
        return max(maximumScale - distanceFromCenter / containerSize.width, unfocusedItemScale)
    }
    private class func estimatedUnfocusedItemWidth(for containerSize: CGSize) -> CGFloat {
        let visibleUnfocusedItemInset = 8.0
        return Self.estimatedFocusedItemWidth(for: containerSize) - visibleUnfocusedItemInset * 2
    }
    private class func estimatedFocusedItemWidth(for containerSize: CGSize) -> CGFloat {
        let focusedItemHorizontalInset = 14.0
        return containerSize.width - focusedItemHorizontalInset * 2
    }
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
}

