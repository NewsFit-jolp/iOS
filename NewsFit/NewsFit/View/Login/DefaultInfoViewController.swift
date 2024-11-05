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
  private let nameTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "이름"
    textField.font = .NF.text_default
    textField.textColor = .label
    textField.layer.borderWidth = 2
    textField.layer.borderColor = UIColor.nfBorderDefault.cgColor
    textField.layer.cornerRadius = 10
    
    return textField
  }()
  private let emailTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "newfit@example.com"
    textField.font = .NF.text_default
    textField.textColor = .label
    textField.layer.borderWidth = 2
    textField.layer.borderColor = UIColor.nfBorderDefault.cgColor
    textField.layer.cornerRadius = 10
    
    let subTitleLabel: UILabel = {
      let label = UILabel()
      label.text = "이메일"
      label.font = .NF.text_default
      label.textColor = .nfBorderDefault
      label.backgroundColor = .systemBackground
      return label
    }()
    
    textField.addSubview(subTitleLabel)
    subTitleLabel.snp.makeConstraints { make in
      make.centerY.equalTo(textField.snp.top)
      make.leading.equalToSuperview().offset(10)
    }
    
    return textField
  }()
  private let phoneTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "010-0000-0000"
    textField.font = .NF.text_default
    textField.textColor = .label
    textField.layer.borderWidth = 2
    textField.layer.borderColor = UIColor.nfBorderDefault.cgColor
    textField.layer.cornerRadius = 10
    
    let subTitleLabel: UILabel = {
      let label = UILabel()
      label.text = "휴대폰"
      label.font = .NF.text_default
      label.textColor = .nfBorderDefault
      label.backgroundColor = .systemBackground
      return label
    }()
    
    textField.addSubview(subTitleLabel)
    subTitleLabel.snp.makeConstraints { make in
      make.centerY.equalTo(textField.snp.top)
      make.leading.equalToSuperview().offset(10)
    }
    
    return textField
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
  }
  
  private func configureHirachy() {
    view.addSubview(titleView)
    titleView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(36)
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
}
