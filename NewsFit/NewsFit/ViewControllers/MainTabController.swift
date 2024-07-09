//
//  MainTabController.swift
//  NewsFit
//
//  Created by User on 7/9/24.
//

import UIKit

final class MainTabController: UITabBarController {
    override func viewDidLoad() {
        self.tabBar.backgroundColor = .backgroundWhite
    }
    override func viewDidAppear(_ animated: Bool) {
        let vc = UINavigationController(rootViewController: LoginViewController())
        let appear = UINavigationBarAppearance()
        appear.backgroundColor = .backgroundWhite
        vc.navigationBar.standardAppearance = appear
        vc.navigationBar.scrollEdgeAppearance = appear
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
