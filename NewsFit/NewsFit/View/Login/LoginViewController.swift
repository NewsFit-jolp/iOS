import UIKit
import SnapKit
import AuthenticationServices

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
  private let naverLoginButton: UIButton = ButtonFactory().make(
    title: "네이버 로그인",
    textColor: .white,
    image: .naverLogo,
    backgroundColor: #colorLiteral(red: 0, green: 0.8046368361, blue: 0.4275280833, alpha: 1)
  )
  private let kakaoTalkLoginButton: UIButton = ButtonFactory().make(
    title: "카카오 로그인",
    textColor: .black.withAlphaComponent(0.85),
    image: .kakaoLogo,
    backgroundColor: #colorLiteral(red: 0.9960784314, green: 0.8980392157, blue: 0, alpha: 1)
  )
  private let googleLoginButton: UIButton = ButtonFactory().make(
    title: "구글 계정으로 로그인",
    textColor: .black,
    image: .googleLogo,
    backgroundColor: #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
  )
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureHirachy()
    configureButtonAction()
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
  private func configureButtonAction() {
    naverLoginButton.addAction(UIAction { [weak self] _ in
      guard let self else { return }
      let url = LoginService.shared.loginWithNaverOAuthURL()
      let session = ASWebAuthenticationSession(url: url, callbackURLScheme: "NewsFit") { [weak self] callbackURL, error in
        guard let code = callbackURL?.absoluteString.components(separatedBy: "code=").last else { return }
        Task {
          try await LoginService.shared.requestloginWithNaver(with: code)
          self?.presentRegister()
        }
      }
      session.presentationContextProvider = self
      session.start()
    }, for: .touchUpInside)
    kakaoTalkLoginButton.addAction(UIAction { [weak self] _ in
      guard let self else { return }
      let url = LoginService.shared.loginWithKaKaoOAuth()
      let session = ASWebAuthenticationSession(url: url, callbackURLScheme: "NewsFit") { [weak self] callbackURL, error in
        guard let code = callbackURL?.absoluteString.components(separatedBy: "code=").last else { return }
        Task {
          try await LoginService.shared.requestloginWithKakao(with: code)
          self?.presentRegister()
        }
      }
      session.presentationContextProvider = self
      session.start()
    }, for: .touchUpInside)
    googleLoginButton.addAction(UIAction { [weak self] _ in
      guard let self else { return }
      let url = LoginService.shared.loginWithGoogleOAuth()
      let session = ASWebAuthenticationSession(url: url, callbackURLScheme: "NewsFit") { [weak self] callbackURL, error in
        guard let code = callbackURL?.absoluteString.components(separatedBy: "code=").last else { return }
        Task {
          try await LoginService.shared.requestloginWithGoogle(with: code)
          self?.presentRegister()
        }
      }
      session.presentationContextProvider = self
      session.start()
    }, for: .touchUpInside)
  }
  private func presentRegister() {
    let vc = ProgressNavigationController(rootViewController: DefaultInfoViewController())
    vc.modalPresentationStyle = .fullScreen
    vc.setProgress(1/5)
    present(vc, animated: true)
  }
}

extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
  func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
    return view.window ?? ASPresentationAnchor()
  }
}

// MARK: - ProgressNavBar
final class ProgressNavigationController: UINavigationController {
  // MARK: - Property
  private let progressBar = {
    let progressBar = UIProgressView()
    progressBar.progressTintColor = .nfGreen
    progressBar.trackTintColor = .nfBorderDefault
    progressBar.progress = 0.0
    progressBar.layer.cornerRadius = 6
    
    return progressBar
  }()
  private let backButton = {
    let button = UIButton()
    button.setImage(UIImage(resource: .nfBackButton), for: .normal)
    
    return button
  }()
  var customSafeAreaInsets: UIEdgeInsets = .zero
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    configureHirachy()
    configureLayout()
    configureAction()
    configureSafeArea()
  }
  
  // MARK: - Helper
  func setProgress(_ progress: Float) {
    progressBar.setProgress(progress, animated: true)
  }
  private func setup() {
    navigationBar.isHidden = true
  }
  private func configureHirachy() {
    view.addSubview(progressBar)
    view.addSubview(backButton)
  }
  private func configureLayout() {
    progressBar.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
      make.centerX.equalToSuperview()
      make.width.equalTo(220)
      make.height.equalTo(12)
    }
    backButton.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
      make.leading.equalToSuperview().offset(15)
    }
  }
  private func configureAction() {
    let backAction = UIAction { [weak self] _ in
      self?.progressBar.setProgress((self?.progressBar.progress ?? 0) - 1/5, animated: true)
      self?.popViewController(animated: true)
    }
    backButton.addAction(backAction, for: .touchUpInside)
  }
  private func configureSafeArea() {
    let safeArea = view.safeAreaLayoutGuide.layoutFrame
    customSafeAreaInsets = .init(top: safeArea.height + 100, left: 0, bottom: 0, right: 0)
  }
}

extension ProgressNavigationController {
  func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    viewController.additionalSafeAreaInsets = customSafeAreaInsets
  }
}
