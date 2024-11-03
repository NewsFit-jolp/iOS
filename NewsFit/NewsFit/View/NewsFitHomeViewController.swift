import SwiftUI
import SnapKit
import Combine

final class NewsFitHomeViewController: UIViewController {
  //MARK: - Types
  enum Constant {
    static let categoryCellResuseID = "categoryCellResuseID"
    static let headLineCellReuseID = "headLineCellReuseID"
    static let newsCellReuseID = "newsCellReuseID"
    static let sectionHeaderReuseID = "sectionHeaderReuseID"
  }
  
  //MARK: - Properties
  private var headLineViewModels: HeadLineNewsViewModels =
  HeadLineNewsViewModels(useCase: NewsUseCase(repository: NewsRepository()))
  private var newsViewModels: NewsViewModels =
  NewsViewModels(useCase: NewsUseCase(repository: NewsRepository()))
  private var newsCategoryViewModels: NewsCategoryViewModels =
  NewsCategoryViewModels(viewModels: [.init(value: "전체"), .init(value: "IT"), .init(value: "경제"), .init(value: "생활/문화"), .init(value: "세계")])
  private let headerText: [String] = ["헤드라인 뉴스", "구독한 언론사의 최신 뉴스"]
  private var cancelable: [AnyCancellable] = []
  
  //MARK: - Views
  private let categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
  private let newsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
    newsViewModels.fetch(category: "", currentNewsID: nil, size: 10)
    headLineViewModels.fetch()
  }
  
  //MARK: - Helper
  private func setup() {
    configureBinding()
    configureLayout()
    registerReusableCells()
    configureHirachy()
    configureDataSource()
  }
  private func configureBinding() {
    
    newsCategoryViewModels.objectWillChange
      .receive(on: DispatchQueue.main)
      .sink { [weak self] in
        self?.categoryCollectionView.reloadData()
      }
      .store(in: &cancelable)
    headLineViewModels.objectWillChange
      .receive(on: DispatchQueue.main)
      .sink { [weak self] in
        self?.newsCollectionView.reloadData()
      }
      .store(in: &cancelable)
    newsViewModels.objectWillChange
      .receive(on: DispatchQueue.main)
      .sink { [weak self] in
        self?.newsCollectionView.reloadData()
      }
      .store(in: &cancelable)
  }
  private func categoryCollectionViewLayout() -> UICollectionViewLayout {
    let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                            heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let groupWidth = NSCollectionLayoutDimension.estimated(100)
      let groupHeight = NSCollectionLayoutDimension.estimated(50)
      let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth,
                                             heightDimension: groupHeight)
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuous
      section.interGroupSpacing = 8
      section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
      
      return section
    }
    
    let configuration = UICollectionViewCompositionalLayoutConfiguration()
    let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: configuration)
    return layout
  }
  private func newsCollectionViewLayout() -> UICollectionViewLayout {
    let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                             heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let groupWidth = NSCollectionLayoutDimension.fractionalWidth(0.9)
      let groupHeight = NSCollectionLayoutDimension.fractionalWidth(0.7)
      let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth,
                                             heightDimension: groupHeight)
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      
      let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(40))
      let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                               elementKind: UICollectionView.elementKindSectionHeader,
                                                               alignment: .top)
      
      if sectionIndex == 0 {
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
    categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
    newsCollectionView.translatesAutoresizingMaskIntoConstraints = false
    
    let wrapperView = UIView()
    wrapperView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(wrapperView)
    wrapperView.addSubview(categoryCollectionView)
    view.addSubview(newsCollectionView)
    wrapperView.snp.makeConstraints { make in
      make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
      make.height.equalTo(60)
    }
    categoryCollectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    newsCollectionView.snp.makeConstraints { make in
      make.top.equalTo(wrapperView.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
  private func configureLayout() {
    categoryCollectionView.collectionViewLayout = categoryCollectionViewLayout()
    categoryCollectionView.alwaysBounceVertical = false
    newsCollectionView.collectionViewLayout = newsCollectionViewLayout()
  }
  private func registerReusableCells() {
    // Category
    categoryCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constant.categoryCellResuseID)
    
    // News
    newsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constant.headLineCellReuseID)
    newsCollectionView.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: Constant.newsCellReuseID)
    newsCollectionView.register(
      NewsFitHomeSectionHeaderView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: Constant.sectionHeaderReuseID
    )
  }
  private func configureDataSource() {
    categoryCollectionView.dataSource = self
    categoryCollectionView.delegate = self
    newsCollectionView.dataSource = self
  }
}

//MARK: - UICollectionViewDataSource
extension NewsFitHomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == categoryCollectionView {
      return newsCategoryViewModels.count
    } else {
      return section == 0 ? headLineViewModels.count : newsViewModels.count
    }
  }
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return collectionView == categoryCollectionView ? 1 : 2
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == categoryCollectionView {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.categoryCellResuseID, for: indexPath)
      cell.contentConfiguration = UIHostingConfiguration {
        NewsCategoryCell(viewModel: newsCategoryViewModels.viewModel(at: indexPath.row))
      }.margins(.all, 0)
      return cell
    } else {
      if indexPath.section == 0 {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.headLineCellReuseID, for: indexPath)
        cell.contentConfiguration = UIHostingConfiguration {
          HeadLineNewsCell(viewModel: headLineViewModels.viewModel(at: indexPath.row))
        }.margins(.all, 0)
        return cell
      } else {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.newsCellReuseID, for: indexPath) as? UICollectionViewListCell else { return .init() }
        cell.contentConfiguration = UIHostingConfiguration {
          NewsCell(viewModel: newsViewModels.viewModel(at: indexPath.row))
        }.margins(.horizontal, 25)
          .margins(.vertical, 20)
        cell.separatorLayoutGuide.snp.makeConstraints { make in
          make.leading.equalTo(cell.contentView.snp.leading).offset(14)
          make.trailing.equalTo(cell.contentView.snp.trailing).offset(-14)
        }
        return cell
      }
    }
  }
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard collectionView == newsCollectionView else { return .init() }
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                 withReuseIdentifier: Constant.sectionHeaderReuseID,
                                                                 for: indexPath)
    guard let header = header as? NewsFitHomeSectionHeaderView else { return .init() }
    header.setTitle(headerText[indexPath.section])
    return header
  }
}

extension NewsFitHomeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if collectionView == categoryCollectionView {
      newsCategoryViewModels.select(at: indexPath.row)
    }
  }
}

//MARK: - SectionHeaderView
final class NewsFitHomeSectionHeaderView: UICollectionReusableView {
  private let title: UILabel = {
    let lb = UILabel()
    lb.font = .NF.title_large
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

