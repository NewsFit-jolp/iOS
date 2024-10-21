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
    if section == 1 {
      return dummyHeadLineViewModel.count
    } else if section == 2 {
      return dummyHeadLineViewModel.count
    } else {
      return 10
    }
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
        HeadLineNewsCell(viewModel: dummyHeadLineViewModel[indexPath.row])
      }.margins(.all, 0)
      return cell
    } else {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.newsCellReuseID, for: indexPath) as? UICollectionViewListCell else { return .init() }
      cell.contentConfiguration = UIHostingConfiguration {
        NewsCell(viewModel: dummyNewsViewModel[indexPath.row])
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

//MARK: - Dummy Data
private extension NewsFitHomeViewController {
  var dummyHeadLineViewModel: [HeadLineNewsViewModel] {[
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
  var dummyNewsViewModel: [NewsViewModel] {[
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
