//
//  NFTextField.swift
//  NewsFit
//
//  Created by 임정현 on 6/17/24.
//

import UIKit

// MARK: - NewsFit TextField
// 이 뷰는 사용자로부터 입력을 받을 수 있는 텍스트필드입니다.
final class NFTextField: UIView {
    private var textField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        // add textfield
        self.textField = setTextField()
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // set background color
        self.backgroundColor = .backgroundWhite
    }
    
    private func setTextField() -> UITextField {
        let tf: UITextField = .init()
        tf.font = .NF.textField_default
        tf.textColor = .textDark
        
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        
        tf.clearsOnBeginEditing = false
        
        return tf
    }
    
    func setPlaceHolder(with text: String) {
        textField.placeholder = text
    }
    
    func setMargin(top: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0) {
        textField.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(top)
            make.right.equalToSuperview().offset(-right)
            make.bottom.equalToSuperview().offset(-bottom)
            make.left.equalToSuperview().offset(left)
        }
    }
}

