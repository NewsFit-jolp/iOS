import UIKit
import Combine

final class PressSubscriptionViewController: UIViewController {
  // MARK: - Property
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
      string: "최소 3개 언론사를 구독하세요.",
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
  
  private let viewModel = PressSubscriptionViewModel()
  private var cancellables: Set<AnyCancellable> = []
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    confirmButton.isEnabled = false
    
    configureHirachy()
    configurePressTableView()
    addAction()
    bind()
  }
  
  // MARK: - Helper
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
  private func configurePressTableView() {
    let tableView = UITableView()
    tableView.register(PressSubscriptionCell.self, forCellReuseIdentifier: PressSubscriptionCell.identifier)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.estimatedRowHeight = 50
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.top.equalTo(constraintLabel.snp.bottom).offset(40)
      make.leading.equalTo(constraintLabel.snp.leading)
      make.trailing.equalTo(constraintLabel.snp.trailing)
      make.bottom.equalTo(confirmButton.snp.top).offset(-10)
    }
  }
  private func addAction() {
    let action = UIAction { [weak self] _ in
      self?.viewModel.savePressList()
      guard let navigationController = self?.navigationController as? ProgressNavigationController else { return }
      navigationController.pushViewController(CompleteViewController(), animated: true)
      navigationController.setProgress(5/5)
    }
    confirmButton.addAction(action, for: .touchUpInside)
  }
  private func bind() {
    viewModel.objectWillChange
      .receive(on: DispatchQueue.main)
      .sink { [weak self] in
        guard let self = self else { return }
        self.constraintLabel.isHidden = self.viewModel.isValid()
        self.confirmButton.backgroundColor = self.viewModel.isValid()
          ? .nfButtonBackgroundBlack
          : .nfButtonBackgroundBlackDisabled
        self.confirmButton.isEnabled = self.viewModel.isValid()
      }
      .store(in: &cancellables)
  }
}

// MARK: - UITableViewDelegate
extension PressSubscriptionViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! PressSubscriptionCell
    UIView.animate(withDuration: 0.3) { [weak self] in
      cell.subscribeButton.isSelected.toggle()
      cell.subscribeButton.backgroundColor = cell.subscribeButton.isSelected ? .nfPurple : .clear
    }
    viewModel.pressList[indexPath.row].isSelected.toggle()
  }
}

// MARK: - UITableViewDataSource
extension PressSubscriptionViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.pressList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: PressSubscriptionCell.identifier, for: indexPath) as? PressSubscriptionCell else { return UITableViewCell() }
    
    let subscription = viewModel.pressList[indexPath.row]
    cell.configureUI(with: subscription)
    
    return cell
  }
}


// MARK: - PressSubscriptionCell
final class PressSubscriptionCell: UITableViewCell {
  // MARK: - Class Property
  static var identifier: String { String(describing: self) }
  
  // MARK: - Property
  private let pressLabel: UILabel = {
    let label = UILabel()
    label.text = "뉴스펭귄"
    label.font = .NF.text_bold
    label.textColor = .label
    
    return label
  }()
  let subscribeButton: UIButton = {
    let button = UIButton()
    let attributedText = NSAttributedString(
      string: "+구독",
      attributes: [
        .foregroundColor: UIColor.label,
        .font: UIFont.NF.button_small
      ]
    )
    button.setAttributedTitle(attributedText, for: .normal)
    
    let attributedTextSub = NSAttributedString(
      string: "구독중",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.NF.button_small
      ]
    )
    button.setAttributedTitle(attributedTextSub, for: .selected)
    
    button.backgroundColor = .clear
    
    button.layer.cornerRadius = 17
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.nfBorderDefault.cgColor
      
    return button
  }()
  
  // MARK: - Initializer
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configrueHirachy()
    configureLayout()
    addAction()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    configrueHirachy()
    configureLayout()
    addAction()
  }
  
  // MARK: - Helper
  func configureUI(with pressSubscription: PressSubscription) {
    pressLabel.text = pressSubscription.title
    subscribeButton.isSelected = pressSubscription.isSelected
  }
  private func configrueHirachy() {
    selectionStyle = .none
    addSubview(pressLabel)
    addSubview(subscribeButton)
  }
  private func configureLayout() {
    pressLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(20)
      make.centerY.equalToSuperview()
    }
    subscribeButton.snp.makeConstraints { make in
      make.height.equalTo(34)
      make.width.equalTo(72)
      make.trailing.equalToSuperview().offset(-20)
      make.centerY.equalToSuperview()
    }
  }
  private func addAction() {
    let action = UIAction { [weak self] _ in
      self?.subscribeButton.isSelected.toggle()
    }
    subscribeButton.addAction(action, for: .touchUpInside)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
  }
}
