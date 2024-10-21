import UIKit

final class NewsFitHomeNavigationController: UINavigationController {
  //MARK: - Property
  let logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = .newsFitLogo
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
  }
  
  //MARK: - Helper
  private func configure() {
    navigationBar.addSubview(logoImageView)
    logoImageView.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.centerY.equalToSuperview()
      make.height.equalToSuperview().offset(-20)
    }
    
    let appearance = UINavigationBarAppearance()
    appearance.configureWithTransparentBackground()
    appearance.backgroundColor = .white
    
    navigationBar.standardAppearance = appearance
    navigationBar.scrollEdgeAppearance = appearance
  }
}
