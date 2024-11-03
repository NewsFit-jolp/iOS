import UIKit
import SnapKit

final class LoginViewController: UIViewController {
  
  //MARK: - Property
  private let appIconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(resource: .newsfitAppIcon)
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  private let logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(resource: .newsFitLogo)
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  private let naverLoginButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 8
    
    var configuration = UIButton.Configuration.plain()
    configuration.image = UIImage(resource: .naverLogo)
    configuration.imagePadding = 10
    var title = AttributedString("네이버 로그인")
    title.foregroundColor = .white
    title.font = .NF.button_default
    configuration.attributedTitle = title
    configuration.background.backgroundColor = #colorLiteral(red: 0, green: 0.8046368361, blue: 0.4275280833, alpha: 1)
    button.configuration = configuration
    
    button.snp.makeConstraints { make in
      make.height.equalTo(56)
      make.width.equalTo(331)
    }
    
    return button
  }()
  private let kakaoTalkLoginButton: UIButton = {
    var configuration = UIButton.Configuration.plain()
    configuration.image = UIImage(resource: .kakaoLogo)
    configuration.imagePadding = 10
    var title = AttributedString("카카오톡 로그인")
    title.foregroundColor = .black.opacity(0.85)
    title.font = .NF.button_default
    configuration.attributedTitle = title
    
    configuration.background.backgroundColor = #colorLiteral(red: 0.9983025193, green: 0.9065476656, blue: 0, alpha: 1)
    
    
    let button = UIButton(configuration: configuration)
    button.layer.cornerRadius = 8
    button.snp.makeConstraints { make in
      make.height.equalTo(56)
      make.width.equalTo(331)
    }
    
    return button
  }()
  private let googleLoginButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 8
    
    var configuration = UIButton.Configuration.plain()
    configuration.image = UIImage(resource: .googleLogo)
    configuration.imagePadding = 10
    var title = AttributedString("구글 계정으로 로그인")
    title.foregroundColor = .black
    title.font = .NF.button_default
    configuration.attributedTitle = title
    configuration.background.backgroundColor = .lightGray
    button.configuration = configuration
    
    button.snp.makeConstraints { make in
      make.height.equalTo(56)
      make.width.equalTo(331)
    }
    
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureHirachy()
  }
  
  private func configureHirachy() {
    let logoStackView = UIStackView(arrangedSubviews: [appIconImageView, logoImageView])
    logoStackView.axis = .vertical
    logoStackView.distribution = .fillProportionally
    logoStackView.alignment = .center
    logoStackView.spacing = 15
    
    view.addSubview(logoStackView)
    logoStackView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(100)
      make.trailing.equalToSuperview().offset(-100)
      make.top.equalToSuperview().offset(130)
    }
    
    let loginButtonStackView = UIStackView(arrangedSubviews: [naverLoginButton, kakaoTalkLoginButton, googleLoginButton])
    loginButtonStackView.axis = .vertical
    loginButtonStackView.alignment = .center
    loginButtonStackView.distribution = .fillEqually
    loginButtonStackView.spacing = 15
    
    view.addSubview(loginButtonStackView)
    loginButtonStackView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(logoStackView.snp.bottom).offset(100)
    }
  }
}
