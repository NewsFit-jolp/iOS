import UIKit

struct ButtonFactory {
  func make(title: String, textColor: UIColor, image: UIImage?, backgroundColor: UIColor, action: UIAction? = nil) -> UIButton {
    let button = UIButton()
    button.layer.cornerRadius = 8
    
    let title = image != nil ? "  " + title : title
    let attributedTitle = NSAttributedString(
      string: title,
      attributes: [.foregroundColor : textColor, .font : UIFont.NF.button_default]
    )
    button.setImage(image, for: .normal)
    button.setAttributedTitle(attributedTitle, for: .normal)
    
    button.backgroundColor = backgroundColor
    button.snp.makeConstraints { make in
      make.height.equalTo(56)
      make.width.equalTo(331)
    }
    
    if let action {
      button.addAction(action, for: .touchUpInside)
    }
    
    return button
  }
}
