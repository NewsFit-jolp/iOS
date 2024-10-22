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
  HeadLineNewsViewModels(useCase: NewsUseCaseDemo())
  private var newsViewModels: NewsViewModels =
  NewsViewModels(useCase: NewsUseCaseDemo())
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

//MARK: - Dummy Data
private extension NewsFitHomeViewController {
  static var dummyHeadLineViewModel: [HeadLineNewsViewModel] {[
    HeadLineNewsViewModel(
      title: "\"최악의 기후재앙\"...브라질 남부 폭우에 사망.실종 220명 넘어서",
      press: "한겨레",
      body: "부상자 361명, 15만5천명 대피",
      imageURL: nil,
      createdDate: .now
    ),
    HeadLineNewsViewModel(
      title: "고양딱지",
      press: "조선일보",
      body: "두두두",
      imageURL: nil,
      createdDate: .now
    ),
    HeadLineNewsViewModel(
      title: "\"지구온난화, 해수면 상승 가속\"...미국 동부 연안 위험 수준 도달",
      press: "동아일보",
      body: "전문가들, 해안지역 대규모 이주 필요성 경고",
      imageURL: nil,
      createdDate: .now
    ),
    HeadLineNewsViewModel(
      title: "인공지능, 미래 사회를 어떻게 변화시킬까?",
      press: "중앙일보",
      body: "전문가들, 기술 발전에 따른 윤리적 문제 논의 시작",
      imageURL: nil,
      createdDate: .now
    ),
    HeadLineNewsViewModel(
      title: "\"우주 탐사의 새 시대\"...NASA, 유인 화성 탐사 계획 발표",
      press: "한겨레",
      body: "2026년부터 본격적인 탐사 임무 시작 예정",
      imageURL: nil,
      createdDate: .now
    ),
    HeadLineNewsViewModel(
      title: "세계 경제 위기...각국 정부 대응 방안 모색",
      press: "연합뉴스",
      body: "각국 중앙은행, 금리 인하 및 경제 지원책 발표",
      imageURL: nil,
      createdDate: .now
    )
  ]}
  static var dummyNewsViewModel: [NewsViewModel] {[
    NewsViewModel(
      title: "\"최악의 기후재앙\"...브라질 남부 폭우에 사망.실종 220명 넘어서",
      press: "한겨레",
      imageURL: nil,
      createdDate: .init(timeIntervalSinceNow: -60*60)
    ),
    NewsViewModel(
      title: "전세계적 인플레이션 위기, 각국 대책 고심",
      press: "중앙일보",
      imageURL: nil,
      createdDate: .init(timeIntervalSinceNow: -2*60*60)
    ),
    NewsViewModel(
      title: "AI 기술 발전, 노동시장 변화 초래할까?",
      press: "조선일보",
      imageURL: nil,
      createdDate: .init(timeIntervalSinceNow: -3*60*60)
    ),
    NewsViewModel(
      title: "\"전기차 대중화\"...글로벌 자동차 업계, 친환경 차량 확대",
      press: "경향신문",
      imageURL: nil,
      createdDate: .init(timeIntervalSinceNow: -4*60*60)
    ),
    NewsViewModel(
      title: "우크라이나 사태 장기화...전 세계 경제적 여파 확대",
      press: "연합뉴스",
      imageURL: nil,
      createdDate: .init(timeIntervalSinceNow: -5*60*60)
    ),
    NewsViewModel(
      title: "\"온난화 심각\"...남극 빙하 녹는 속도 급격히 증가",
      press: "동아일보",
      imageURL: nil,
      createdDate: .init(timeIntervalSinceNow: -6*60*60)
    ),
    NewsViewModel(
      title: "유럽연합, 디지털 통화 도입 여부 논의 시작",
      press: "파이낸셜타임즈",
      imageURL: nil,
      createdDate: .init(timeIntervalSinceNow: -7*60*60)
    ),
    NewsViewModel(
      title: "한국 경제 성장률, 예상치 하회...원인과 대책은?",
      press: "매일경제",
      imageURL: nil,
      createdDate: .init(timeIntervalSinceNow: -8*60*60)
    ),
    NewsViewModel(
      title: "스페이스X, 민간 우주 관광 시대 본격화",
      press: "블룸버그",
      imageURL: nil,
      createdDate: .init(timeIntervalSinceNow: -9*60*60)
    ),
    NewsViewModel(
      title: "\"로봇 공학의 미래\"...신기술로 산업 혁신 예고",
      press: "서울경제",
      imageURL: nil,
      createdDate: .init(timeIntervalSinceNow: -10*60*60)
    )
    
  ]}
}
