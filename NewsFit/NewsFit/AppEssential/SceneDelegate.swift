//
//  SceneDelegate.swift
//  NewsFit
//
//  Created by User on 5/28/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  //MARK: - Properties
  var window: UIWindow?
  
  //MARK: - LifeCycle
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: scene)
    let vc = CustomNavigationController(rootViewController: NewsFitHomeViewController())
    window?.rootViewController = vc
    window?.makeKeyAndVisible()
  }
}

fileprivate final class CustomNavigationController: UINavigationController {
  let logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = .newsFitLogo
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
  }
  
  func configure() {
    navigationBar.addSubview(logoImageView)
    logoImageView.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.centerY.equalToSuperview()
      make.height.equalToSuperview().offset(-20)
    }
    
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = .white
    
    navigationBar.standardAppearance = appearance
    navigationBar.scrollEdgeAppearance = appearance
  }
}
