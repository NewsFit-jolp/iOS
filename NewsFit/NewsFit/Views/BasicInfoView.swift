//
//  BasicInfoView.swift
//  NewsFit
//
//  Created by User on 7/9/24.
//

import UIKit


final class BasicInfoView: UIView {
    //MARK: - Properties
    private var titleLabel: NFLabel = {
       let lb = NFLabel()
        lb.setText("뉴스핏이 처음인가요?\n기본 정보를 알려주세요.", with: .title)
        lb.setColor(with: .dark)
        return lb
    }()
    
    @Borderble
    private var nameTextField: NFTextField = {
        let tf = NFTextField()
        tf.setPlaceHolder(with: "이름")
        tf.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        return tf
    }()
    
    @Borderble
    private var emailTextField: NFTextField = {
        let tf = NFTextField()
        tf.setPlaceHolder(with: "info@example.com")
        tf.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        return tf
    }()
    
    @Borderble
    private var phoneTextField: NFTextField = {
        let tf = NFTextField()
        tf.setPlaceHolder(with: "010-0000-0000")
        tf.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        return tf
    }()
    
    private var emailErrorMessageLabel: NFLabel = {
        let lb = NFLabel()
        lb.setColor(with: .red)
        lb.setText("이메일 형식이 올바르지 않습니다.", with: .body)
        return lb
    }()
    
    private var phoneErrorMessageLabel: NFLabel = {
        let lb = NFLabel()
        lb.setColor(with: .red)
        lb.setText("전화번호 형식이 올바르지 않습니다.", with: .body)
        return lb
    }()
    //MARK: - LifeCycle
    override func updateConstraints() {
        setup()
        super.updateConstraints()
    }
    
    //MARK: - Helper
    private func setup() {
        setConstraint()
        setTitles()
    }
    
    private func setConstraint() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
        }
        
        let infoStack = UIStackView(arrangedSubviews: [
            $nameTextField,
            $emailTextField,
            emailErrorMessageLabel,
            $phoneTextField,
            phoneErrorMessageLabel
        ])
        infoStack.axis = .vertical
        infoStack.spacing = 15
        infoStack.alignment = .fill
        infoStack.distribution = .fill
        addSubview(infoStack)
        infoStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    private func setTitles() {
        $emailTextField.setTitle(with: "이메일")
        $phoneTextField.setTitle(with: "전화번호")
    }
    
}
