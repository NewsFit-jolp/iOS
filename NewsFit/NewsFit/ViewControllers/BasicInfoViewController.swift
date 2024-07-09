//
//  BasicInfoViewController.swift
//  NewsFit
//
//  Created by User on 7/9/24.
//

import UIKit

final class BasicInfoViewController: UIViewController {
    //MARK: - Properties
    private let infoView = BasicInfoView()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        setup()
    }
    
    //MARK: - Helper
    private func setup() {
        self.view.backgroundColor = .backgroundWhite
        setConstraint()
    }
    
    private func setConstraint() {
        self.view.addSubview(infoView)
        infoView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(31)
            make.top.equalToSuperview().offset(36)
            
        }
    }
}
