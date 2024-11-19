import UIKit

final class DefaultInfoViewController: UIViewController {
  private let titleView: UILabel = {
    let label = UILabel()
    label.text = "뉴스핏이 처음인가요?\n기본 정보를 알려주세요."
    label.numberOfLines = 0
    label.font = .NF.title_large
    label.textColor = .label
    return label
  }()
  private let nameTextField: UITextField = TextFieldFactory().make(
    placeHolder: "이름"
  )
  private let emailTextField: UITextField = TextFieldFactory().make(
    placeHolder: "newfit@example.com"
  )
  private let phoneTextField: UITextField = TextFieldFactory().make(
    placeHolder: "010-0000-0000",
    keyboardType: .numberPad
  )
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
    addSubtitles()
    addAction()
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
    
    let stackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, phoneTextField])
    stackView.axis = .vertical
    stackView.spacing = 15
    stackView.distribution = .fillEqually
    stackView.alignment = .fill
    
    view.addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.top.equalTo(titleView.snp.bottom).offset(36)
      make.leading.equalTo(titleView.snp.leading)
      make.trailing.equalTo(titleView.snp.trailing)
      make.height.equalTo(220)
    }
    
    view.addSubview(confirmButton)
    confirmButton.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
      make.centerX.equalToSuperview()
    }
  }
  private func addSubtitles() {
    emailTextField.addSubTitleLabel(of: "이메일")
    phoneTextField.addSubTitleLabel(of: "휴대폰")
  }
  private func addAction() {
    let action = UIAction { [weak self] _ in
      guard let navigationController = self?.navigationController as? ProgressNavigationController else { return }
      navigationController.pushViewController(AdditionalInfoViewController(), animated: true)
      navigationController.setProgress(2/5)
    }
    confirmButton.addAction(action, for: .touchUpInside)
  }
}
