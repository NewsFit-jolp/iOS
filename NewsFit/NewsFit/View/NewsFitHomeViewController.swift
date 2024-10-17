import SwiftUI
import SnapKit

final class NewsFitHomeViewController: UIViewController {
  //MARK: - Types
  enum Constant {
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
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let groupWidth = NSCollectionLayoutDimension.fractionalWidth(0.9)
      let groupHeight = NSCollectionLayoutDimension.fractionalWidth(0.7)
      let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth,
                                             heightDimension: groupHeight)
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      
      let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(40))
      let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                               elementKind: UICollectionView.elementKindSectionHeader,
                                                               alignment: .top)
      if sectionIndex == 0 {
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
    return 2
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let reuseID = indexPath.section == 0 ? Constant.headLineCellReuseID : Constant.newsCellReuseID
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath)
    if indexPath.section == 0 {
      cell.contentConfiguration = UIHostingConfiguration {
        HeadLineNewsCell()
      }.margins(.all, 0)
    } else if let cell = cell as? UICollectionViewListCell {
      cell.contentConfiguration = UIHostingConfiguration {
        NewsCell()
      }.margins(.horizontal, 25)
        .margins(.vertical, 20)
      cell.separatorLayoutGuide.snp.makeConstraints { make in
        make.leading.equalTo(cell.contentView.snp.leading).offset(14)
        make.trailing.equalTo(cell.contentView.snp.trailing).offset(-14)
      }
    }
    return cell
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
