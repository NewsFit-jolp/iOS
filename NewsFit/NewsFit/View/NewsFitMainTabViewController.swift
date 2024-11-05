import SwiftUI

protocol MainTabViewControllerConfigurable {
  func mainTabViewControllerTabBarTitle() -> String
  func mainTabViewControllerTabBarImage() -> UIImage
}

final class NewsFitMainTabViewController: UIViewController {
  typealias ViewController = UIViewController & MainTabViewControllerConfigurable
  //MARK: - Property
  private var viewControllers: [ViewController] = []
  private var previousIndex: Int = 0
  private var selectedIndex: Int = 0 {
    willSet {
      previousIndex = selectedIndex
    }
    didSet {
      updateCurrentViewController()
    }
  }
  private var tabButtons: [UIButton] = []
  private let tabBar: UIView = {
    let tabBar = UIView()
    tabBar.backgroundColor = .systemBackground
    tabBar.layer.cornerRadius = 32
    tabBar.layer.shadowColor = UIColor.black.cgColor
    tabBar.layer.shadowOpacity = 0.15
    tabBar.layer.shadowRadius = 4
    tabBar.layer.shadowOffset = .init(width: -2, height: 4)
    return tabBar
  }()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTabBar()
  }
  
  //MARK: - Method
  func setViewControllers(_ viewControllers: [ViewController]) {
    self.viewControllers = viewControllers
    configureTabBarItems()
    updateCurrentViewController()
  }
  
  //MARK: - Helper
  private func configureTabBar() {
    view.addSubview(tabBar)
    tabBar.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(45)
      make.trailing.equalToSuperview().offset(-45)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(10)
      make.height.equalTo(64)
    }
  }
  private func configureTabBarItems() {
    let buttons = viewControllers.enumerated().map { index, viewController in
      let tabButton = UIButton()
      
      let action = UIAction { [weak self] _ in
        guard self?.selectedIndex != index else { return }
        self?.selectedIndex = index
      }
      tabButton.addAction(action, for: .touchUpInside)
      
      var configuration = UIButton.Configuration.plain()
      configuration.title = viewController.mainTabViewControllerTabBarTitle()
      configuration.attributedTitle?.foregroundColor = .gray
      configuration.attributedTitle?.font = .NF.text_nav
      configuration.image = viewController.mainTabViewControllerTabBarImage()
      configuration.imagePlacement = .top
      configuration.imagePadding = 7
      configuration.buttonSize = .medium
      configuration.background.backgroundColor = .clear
      tabButton.configurationUpdateHandler = { button in
        switch button.state {
        case .selected:
          let titleColor = UIColor.black
          let imageColor = UIColor.nfGreen
          configuration.attributedTitle?.foregroundColor = titleColor
          configuration.image = configuration.image?.withTintColor(imageColor)
        default:
          let titleColor = UIColor.gray
          let imageColor = UIColor.gray
          configuration.attributedTitle?.foregroundColor = titleColor
          configuration.image = configuration.image?.withTintColor(imageColor)
        }
        button.configuration = configuration
      }
      return tabButton
    }
    
    let stackView = UIStackView(arrangedSubviews: buttons)
    tabBar.addSubview(stackView)
    stackView.alignment = .center
    stackView.distribution = .fillEqually
    stackView.spacing = 0
    stackView.axis = .horizontal
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    tabButtons = buttons
  }
  private func updateCurrentViewController() {
    hideViewController()
    showViewController()
    tabButtons[previousIndex].isSelected = false
    tabButtons[selectedIndex].isSelected = true
  }
  private func hideViewController() {
      let previousVC = viewControllers[previousIndex]
      previousVC.willMove(toParent: nil)
      previousVC.view.removeFromSuperview()
      previousVC.removeFromParent()
      
  }
  private func showViewController() {
    let selectedVC = viewControllers[selectedIndex]
    self.addChild(selectedVC)
    view.insertSubview(selectedVC.view, belowSubview: tabBar)
    selectedVC.view.frame = view.bounds
    selectedVC.didMove(toParent: self)
  }
}
