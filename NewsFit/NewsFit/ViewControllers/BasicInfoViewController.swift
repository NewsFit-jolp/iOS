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
    private let nextButton: NFButton = {
        let btn = NFButton(with: .primary(isHalf: false))
        let lb = NFLabel()
        lb.setText("계속", with: .button)
        lb.setColor(with: .white)
        btn.setTitle(views: [lb], spacing: 0)
        
        return btn
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        setup()
    }
    
    //MARK: - Helper
    private func setup() {
        self.view.backgroundColor = .backgroundWhite
        configureView()
    }
    
    private func configureView() {
        self.view.addSubview(infoView)
        infoView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(31)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(36)
        }
        
        self.view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-38)
        }
    }
}
