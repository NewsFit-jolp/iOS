import UIKit

struct ButtonFactory {
  func make(title: String, textColor: UIColor, image: UIImage?, backgroundColor: UIColor) -> UIButton {
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
    
    return button
  }
  func makeRadio(title: String) -> UIButton {
    let button = UIButton()
    
    let title = "        " + title
    let attributedTitle = NSAttributedString(
      string: title,
      attributes: [.foregroundColor : UIColor.black, .font : UIFont.NF.text_default]
    )
    button.setImage(.radioOff, for: .normal)
    button.setImage(.radioOn, for: .selected)
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.contentHorizontalAlignment = .left
    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 16)
    
    button.snp.makeConstraints { make in
      make.height.equalTo(60)
      make.width.equalTo(331)
    }
    
    return button
  }
}
