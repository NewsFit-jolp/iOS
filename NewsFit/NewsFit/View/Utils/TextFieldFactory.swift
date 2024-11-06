import UIKit
import SnapKit

struct TextFieldFactory {
  func make(placeHolder: String) -> UITextField {
    let textField = UITextField()
    textField.placeholder = placeHolder
    textField.font = .NF.text_default
    textField.textColor = .label
    textField.layer.borderWidth = 2
    textField.layer.borderColor = UIColor.nfBorderDefault.cgColor
    textField.layer.cornerRadius = 10
    let padding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
    textField.leftView = padding
    textField.rightView = padding
    textField.leftViewMode = .always
    textField.rightViewMode = .always
    
    return textField
  }
}
