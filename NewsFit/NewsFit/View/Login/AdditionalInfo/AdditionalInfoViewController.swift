import UIKit
import Combine

final class AdditionalInfoViewController: UIViewController {
  private let titleView: UILabel = {
    let label = UILabel()
    label.text = "맞춤 뉴스 제공을 위한\n추가 정보를 알려주세요."
    label.numberOfLines = 0
    label.font = .NF.title_large
    label.textColor = .label
    return label
  }()
  private let genderCheckButtons: [UIButton] = [
    ButtonFactory().makeRadio(title: "남성"),
    ButtonFactory().makeRadio(title: "여성")
  ]
  private let yearTextField: UITextField = TextFieldFactory().make(
    placeHolder: "YYYY/MM/DD",
    keyboardType: .numberPad
  )
  private let confirmButton: UIButton = ButtonFactory().make(
    title: "계속하기",
    textColor: .white,
    image: nil,
    backgroundColor: .nfButtonBackgroundBlackDisabled
  )
  private var selectedGender: Int = 0 {
    didSet {
      guard oldValue != selectedGender else { return }
      genderCheckButtons[oldValue].isSelected = false
      genderCheckButtons[selectedGender].isSelected = true
    }
  }
  private var viewModel = AdditionalInfoViewModel()
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    confirmButton.isEnabled = false
    
    configureHirachy()
    addButtonAction()
    bind()
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  private func configureHirachy() {
    view.addSubview(titleView)
    titleView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
      make.leading.equalToSuperview().offset(30)
      make.trailing.equalToSuperview().offset(-30)
    }
    
    let checkStackView = UIStackView(arrangedSubviews: genderCheckButtons)
    checkStackView.axis = .vertical
    checkStackView.alignment = .fill
    checkStackView.distribution = .fillEqually
    checkStackView.layer.borderColor = UIColor.nfBorderDefault.cgColor
    checkStackView.layer.cornerRadius = 10
    checkStackView.layer.borderWidth = 2
    
    view.addSubview(checkStackView)
    checkStackView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(titleView.snp.bottom).offset(30)
    }
    
    view.addSubview(yearTextField)
    yearTextField.snp.makeConstraints { make in
      make.top.equalTo(checkStackView.snp.bottom).offset(30)
      make.leading.equalTo(checkStackView.snp.leading)
      make.trailing.equalTo(checkStackView.snp.trailing)
      make.height.equalTo(62)
    }
    
    view.addSubview(confirmButton)
    confirmButton.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
      make.centerX.equalToSuperview()
    }
    
    checkStackView.addSubTitleLabel(of: "성별")
    yearTextField.addSubTitleLabel(of: "생년월일")
  }
  private func addButtonAction() {
    genderCheckButtons[selectedGender].isSelected = true
    genderCheckButtons.enumerated().forEach { idx, button in
      let action = UIAction { [weak self] _ in
        self?.selectedGender = idx
        self?.viewModel.genderIndex = idx
      }
      button.addAction(action, for: .touchUpInside)
    }
    
    let birthAction = UIAction { [weak self] _ in
      guard let text = self?.yearTextField.text else { return }
      self?.viewModel.birthDay = text
    }
    yearTextField.addAction(birthAction, for: .editingChanged)
    
    let confirmAction = UIAction { [weak self] _ in
      self?.viewModel.saveInfo()
      guard let navigationController = self?.navigationController as? ProgressNavigationController else { return }
      navigationController.pushViewController(CategorySubscriptionViewController(), animated: true)
      navigationController.setProgress(3/5)
    }
    confirmButton.addAction(confirmAction, for: .touchUpInside)
  }
  private func bind() {
    viewModel.objectWillChange
      .receive(on: DispatchQueue.main)
      .sink { [weak self] in
        guard let self else { return }
        confirmButton.backgroundColor = viewModel.isValid()
        ? .nfButtonBackgroundBlack
        : .nfButtonBackgroundBlackDisabled
        confirmButton.isEnabled = viewModel.isValid()
      }
      .store(in: &cancellables)
  }
}
