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
    let vc = NewsFitHomeNavigationController(rootViewController: NewsFitHomeViewController())
    window?.rootViewController = vc
    window?.makeKeyAndVisible()
  }
}
