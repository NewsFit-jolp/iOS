//
//  SceneDelegate.swift
//  NewsFit
//
//  Created by User on 5/28/24.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  //MARK: - Properties
  var window: UIWindow?
  
  //MARK: - LifeCycle
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: scene)
    let homeViewController = NewsFitHomeNavigationController(rootViewController: NewsFitHomeViewController())
    let searchViewController = UIHostingController(rootView: NewsFitSearchView())
    let myPageViewController = NewsFitMyPageViewController()
    let viewControllers: [UIViewController & MainTabViewControllerConfigurable]
    = [ homeViewController, searchViewController, myPageViewController ]
    
    let rootViewController = NewsFitMainTabViewController()
    rootViewController.setViewControllers(viewControllers)
    window?.rootViewController = rootViewController
//    window?.rootViewController = LoginViewController()
//    window?.rootViewController?.present(LoginViewController(), animated: true)
    window?.makeKeyAndVisible()
  }
}

//MARK: - MainTabViewControllerConfigurable
extension UIHostingController: MainTabViewControllerConfigurable where Content: MainTabViewControllerConfigurable {
  func mainTabViewControllerTabBarTitle() -> String {
    rootView.mainTabViewControllerTabBarTitle()
  }
  func mainTabViewControllerTabBarImage() -> UIImage {
    rootView.mainTabViewControllerTabBarImage()
  }
}
