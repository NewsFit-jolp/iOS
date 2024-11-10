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
    
    var title = NSAttributedString(string: "  네이버 로그인", attributes: [.foregroundColor : UIColor.white, .font : UIFont.NF.button_default])
    button.setImage(.naverLogo, for: .normal)
    button.setAttributedTitle(title, for: .normal)
    
    button.backgroundColor = #colorLiteral(red: 0, green: 0.8046368361, blue: 0.4275280833, alpha: 1)
    button.snp.makeConstraints { make in
      make.height.equalTo(56)
      make.width.equalTo(331)
    }
    
    return button
  }()
  private let kakaoTalkLoginButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 8
    
    var title = NSAttributedString(string: "  카카오 로그인", attributes: [.foregroundColor : UIColor.black.withAlphaComponent(0.85), .font : UIFont.NF.button_default])
    button.setImage(.kakaoLogo, for: .normal)
    button.setAttributedTitle(title, for: .normal)
    
    button.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.8980392157, blue: 0, alpha: 1)
    button.snp.makeConstraints { make in
      make.height.equalTo(56)
      make.width.equalTo(331)
    }
    
    return button
  }()
  private let googleLoginButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 8
    
    var title = NSAttributedString(string: "  구글 계정으로 로그인", attributes: [.foregroundColor : UIColor.black, .font : UIFont.NF.button_default])
    button.setImage(.googleLogo, for: .normal)
    button.setAttributedTitle(title, for: .normal)
    
    button.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    button.snp.makeConstraints { make in
      make.height.equalTo(56)
      make.width.equalTo(331)
    }
    
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureHirachy()
    configureAction()
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
  private func configureAction() {
    let naverLoginAction = UIAction { _ in
      
    }
  }
}
