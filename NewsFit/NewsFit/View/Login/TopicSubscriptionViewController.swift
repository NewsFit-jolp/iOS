import UIKit

final class TopicSubscriptionViewController: UIViewController {
  private var viewModels: [TopicSubscriptionCellViewModel] = [
    .init(icon: "🏛️", name: "정치"),
    .init(icon: "💰", name: "경제"),
    .init(icon: "👥", name: "사회"),
    .init(icon: "🏠", name: "생활/문화"),
    .init(icon: "🌏", name: "세계"),
    .init(icon: "💻", name: "기술/IT"),
    .init(icon: "🎤", name: "연예"),
    .init(icon: "⚽", name: "스포츠"),
  ]
  
  private let titleView: UILabel = {
    let label = UILabel()
    label.text = "관심있는 뉴스 주제를\n선택해주세요."
    label.numberOfLines = 0
    label.font = .NF.title_large
    label.textColor = .label
    
    return label
  }()
  private let constraintLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    let attributedText = NSAttributedString(
      string: "최소 3개 주제를 선택하세요.",
      attributes: [
        .foregroundColor: UIColor.label,
        .font: UIFont.NF.title_middle,
        .underlineStyle: NSUnderlineStyle.single.rawValue,
        .underlineColor: UIColor.label
      ]
    )
    label.attributedText = attributedText
    
    return label
  }()
  private let confirmButton: UIButton = ButtonFactory().make(
    title: "계속하기",
    textColor: .white,
    image: nil,
    backgroundColor: .nfButtonBackgroundBlackDisabled
  )
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    configureHirachy()
    configureTopicCollectionView()
    addAction()
  }
  private func configureHirachy() {
    view.addSubview(titleView)
    titleView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
      make.leading.equalToSuperview().offset(30)
      make.trailing.equalToSuperview().offset(-30)
    }
    
    view.addSubview(constraintLabel)
    constraintLabel.snp.makeConstraints { make in
      make.leading.equalTo(titleView.snp.leading)
      make.trailing.equalTo(titleView.snp.trailing)
      make.top.equalTo(titleView.snp.bottom).offset(20)
    }
    
    view.addSubview(confirmButton)
    confirmButton.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
      make.centerX.equalToSuperview()
    }
  }
  private func configureTopicCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 100, height: 100)
    layout.minimumInteritemSpacing = 10
    layout.minimumLineSpacing = 10
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(
      TopicSubscriptionCell.self,
      forCellWithReuseIdentifier: TopicSubscriptionCell.identifier
    )
    collectionView.delegate = self
    collectionView.dataSource = self
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.top.equalTo(constraintLabel.snp.bottom).offset(40)
      make.leading.equalTo(constraintLabel.snp.leading)
      make.trailing.equalTo(constraintLabel.snp.trailing)
      make.bottom.equalTo(confirmButton.snp.top).offset(-10)
    }
  }
  private func addAction() {
    let action = UIAction { [weak self] _ in
      guard let navigationController = self?.navigationController as? ProgressNavigationController else { return }
      navigationController.pushViewController(PressSubscriptionViewController(), animated: true)
      navigationController.setProgress(4/5)
    }
    confirmButton.addAction(action, for: .touchUpInside)
  }
}

extension TopicSubscriptionViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: TopicSubscriptionCell.identifier,
      for: indexPath
    ) as? TopicSubscriptionCell else { return UICollectionViewCell() }
    
    let viewModel = viewModels[indexPath.row]
    cell.configrueUI(cellModel: viewModel)
    
    return cell
  }
}

extension TopicSubscriptionViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModels[indexPath.row].isPressed.toggle()
    collectionView.reloadItems(at: [indexPath])
  }
}

fileprivate final class TopicSubscriptionCell: UICollectionViewCell {
  // MARK: - Property
  private let iconLabel: UILabel = {
    let label = UILabel()
    label.text = "🏛️"
    label.font = .systemFont(ofSize: 35, weight: .semibold)
    label.textColor = .label
    label.adjustsFontSizeToFitWidth = true
    label.setContentCompressionResistancePriority(.init(730), for: .vertical)
    
    return label
  }()
  private let topicLabel: UILabel = {
    let label = UILabel()
    label.text = "topic Title"
    label.font = .NF.text_bold
    label.textColor = .label
    
    return label
  }()
  
  // MARK: - LifeCycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Method
  func configrueUI(cellModel: TopicSubscriptionCellViewModel) {
    iconLabel.text = cellModel.icon
    topicLabel.text = cellModel.name
    backgroundColor = cellModel.isPressed ? .nfBackgroundAccent : .white
    layer.borderColor = cellModel.isPressed ? UIColor.nfBorderPurple.cgColor : UIColor.nfBorderDefault.cgColor
  }
  
  // MARK: - Helper
  private func setup() {
    layer.cornerRadius = 16
    layer.borderWidth = 2
    layer.borderColor = UIColor.nfBorderDefault.cgColor
    
    let stackView = UIStackView(arrangedSubviews: [iconLabel, topicLabel])
    stackView.axis = .vertical
    stackView.spacing = 16
    stackView.alignment = .center
    stackView.distribution = .fill
    addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(15)
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().offset(-15)
    }
  }
}

struct TopicSubscriptionCellViewModel {
  var isPressed: Bool = false
  let icon: String
  let name: String
}
