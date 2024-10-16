import SwiftUI
import SnapKit

final class NewsFitHomeViewController: UIViewController {
  //MARK: - Types
  enum Constant {
    static let headLineCellReuseId = "headLineCellReuseId"
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
    let sectionProvider = { (index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                             heightDimension: .absolute(230))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .groupPagingCentered
      section.interGroupSpacing = 0
      
      return section
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
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constant.headLineCellReuseId)
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
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.headLineCellReuseId, for: indexPath)
    cell.contentConfiguration = UIHostingConfiguration {
      HeadLineNewsCell()
        .background(Color.red)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    return cell
  }
}
