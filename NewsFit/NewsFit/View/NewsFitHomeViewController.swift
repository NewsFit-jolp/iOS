import SwiftUI
import SnapKit

final class NewsFitHomeViewController: UIViewController {
  //MARK: - Types
  enum Constant {
    static let categoryCellResuseID = "categoryCellResuseID"
    static let headLineCellReuseID = "headLineCellReuseID"
    static let newsCellReuseID = "newsCellReuseID"
    static let sectionHeaderReuseID = "sectionHeaderReuseID"
  }
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
    configureHirachy()
  }
  
  //MARK: - Helper
  private func setup() {
    
  }
  private func collectionViewLayout() -> UICollectionViewLayout {
    let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let itemSize = sectionIndex == 0 ?
      NSCollectionLayoutSize(widthDimension: .estimated(100),
                             heightDimension: .fractionalHeight(1.0)) :
      NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                             heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let groupWidth = sectionIndex == 0 ?
      NSCollectionLayoutDimension.estimated(100) :
      NSCollectionLayoutDimension.fractionalWidth(0.9)
      let groupHeight = sectionIndex == 0 ?
      NSCollectionLayoutDimension.estimated(50) :
      NSCollectionLayoutDimension.fractionalWidth(0.7)
      let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth,
                                             heightDimension: groupHeight)
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      
      let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(40))
      let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                               elementKind: UICollectionView.elementKindSectionHeader,
                                                               alignment: .top)
      if sectionIndex == 0 {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20)
        return section
      } else if sectionIndex == 1 {
        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [header]
        return section
      } else {
        let section = NSCollectionLayoutSection.list(
          using: UICollectionLayoutListConfiguration(appearance: .plain),
          layoutEnvironment: layoutEnvironment
        )
        section.boundarySupplementaryItems = [header]
        return section
      }
    }
    
    let configuration = UICollectionViewCompositionalLayoutConfiguration()
    configuration.interSectionSpacing = 20
    let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: configuration)
    return layout
  }
  private func configureHirachy() {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.dataSource = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constant.categoryCellResuseID)
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constant.headLineCellReuseID)
    collectionView.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: Constant.newsCellReuseID)
    collectionView.register(
      NewsFitHomeSectionHeaderView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: Constant.sectionHeaderReuseID
    )
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}

//MARK: - UICollectionViewDataSource
extension NewsFitHomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.section == 0 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.categoryCellResuseID, for: indexPath)
      cell.contentConfiguration = UIHostingConfiguration {
        NewsCategoryCell()
      }.margins(.all, 0)
      return cell
    } else if indexPath.section == 1 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.headLineCellReuseID, for: indexPath)
      cell.contentConfiguration = UIHostingConfiguration {
        HeadLineNewsCell()
      }.margins(.all, 0)
      return cell
    } else {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.newsCellReuseID, for: indexPath) as? UICollectionViewListCell else { return .init() }
      cell.contentConfiguration = UIHostingConfiguration {
        NewsCell()
      }.margins(.horizontal, 25)
        .margins(.vertical, 20)
      cell.separatorLayoutGuide.snp.makeConstraints { make in
        make.leading.equalTo(cell.contentView.snp.leading).offset(14)
        make.trailing.equalTo(cell.contentView.snp.trailing).offset(-14)
      }
      return cell
    }
  }
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                 withReuseIdentifier: Constant.sectionHeaderReuseID,
                                                                 for: indexPath)
    guard let header = header as? NewsFitHomeSectionHeaderView else { return .init() }
    header.setTitle("딩댕동 굿 모닝 딩댕동")
    return header
  }
}

final class NewsFitHomeSectionHeaderView: UICollectionReusableView {
  private let title: UILabel = {
    let lb = UILabel()
    lb.font = .preferredFont(forTextStyle: .title1)
    return lb
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    confifureUI()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    confifureUI()
  }
  func setTitle(_ text: String) {
    title.text = text
  }
  private func confifureUI() {
    addSubview(title)
    title.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
      make.verticalEdges.equalToSuperview()
    }
  }
}
