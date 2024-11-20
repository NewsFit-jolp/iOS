//
//  NewsFitMyPageViewController.swift
//  NewsFit
//
//  Created by user on 11/20/24.
//

import UIKit

final class NewsFitMyPageViewController: UIViewController {
  private let titleView: UILabel = {
    let label = UILabel()
    label.text = "내정보"
    label.numberOfLines = 0
    label.font = .NF.title_large
    label.textColor = .label
    
    return label
  }()
  
  private var tableView: UITableView?
  private let titles: [String] = ["회원정보 수정", "추가정보 수정", "선호 주제 변경", "뉴스 구독 관리", "로그아웃", "회원탈퇴"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    configureHirachy()
    configureTableView()
  }
  
  private func configureHirachy() {
    view.addSubview(titleView)
    titleView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
      make.leading.equalToSuperview().offset(30)
      make.trailing.equalToSuperview().offset(-30)
    }
    
  }
  private func configureTableView() {
    let tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    self.tableView = tableView
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.top.equalTo(titleView.snp.bottom).offset(30)
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }
}

extension NewsFitMyPageViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.isSelected = false
    switch indexPath.row {
    case 0:
      let vc = DefaultInfoViewController()
      vc.setButtonComplete()
      present(vc, animated: true)
    case 1:
      let vc = AdditionalInfoViewController()
      vc.setButtonComplete()
      present(vc, animated: true)
    case 2:
      let vc = CategorySubscriptionViewController()
      vc.setButtonComplete()
      present(vc, animated: true)
    case 3:
      let vc = PressSubscriptionViewController()
      vc.setButtonComplete()
      present(vc, animated: true)
    case 4:
      let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        self?.present(vc, animated: true)
      }))
      alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
      present(alert, animated: true)
    default:
      break
    }
  }
}

extension NewsFitMyPageViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    titles.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    var configuration = cell.defaultContentConfiguration()
    configuration.text = titles[indexPath.row]
    configuration.textProperties.font = .NF.text_bold
    cell.contentConfiguration = configuration
    
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    72
  }
}

extension NewsFitMyPageViewController: MainTabViewControllerConfigurable {
  func mainTabViewControllerTabBarTitle() -> String {
    "마이"
  }
  
  func mainTabViewControllerTabBarImage() -> UIImage {
    .nfNaviagtionAccount
  }
}
