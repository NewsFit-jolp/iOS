//
//  NFLabel.swift
//  NewsFit
//
//  Created by User on 6/18/24.
//

import UIKit
import SnapKit


enum NFLabelFont {
    case button
    case smallButton
    case title
    case subTitle
    case body
    
    var font: UIFont {
        switch self {
        case .button:
            return .NF.button_default
        case .smallButton:
            return .NF.button_small
        case .title:
            return .NF.title_large
        case .subTitle:
            return .NF.title_middle
        case .body:
            return .NF.text_default
        }
    }
}

enum NFLabelColor {
    case dark
    case gray
    case white
    
    var color: UIColor {
        switch self {
        case .dark:
                .textDark
        case .gray:
                .textGray
        case .white:
                .textWhite
        }
    }
}

final class NFLabel: UIView {
    private var label = UILabel()
    private var font: NFLabelFont = .body
    private var textColor: NFLabelColor = .dark
    private var isAddedSubView: Bool = false
    private var isUnderLined: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(font: NFLabelFont) {
        // setting label
        label.font = font.font
        
        if !isAddedSubView {
            label.textColor = textColor.color
            label.textAlignment = .left
            // add subview
            addSubview(label)
            label.snp.makeConstraints { make in
                make.top.left.bottom.right.equalToSuperview()
            }
            isAddedSubView = true
        }
    }
    
    func setText(_ text: String, with font: NFLabelFont) {
        label.text = text
        setup(font: font)
    }
    
    func setColor(with color: NFLabelColor) {
        label.textColor = color.color
    }
    
    func setUnderLine(to set: Bool) {
        isUnderLined = set
        let text = label.text ?? label.attributedText?.string ?? ""
        if isUnderLined { // 기본글자 -> 속성 글자
            let attributeText = NSAttributedString(
                string: text,
                attributes: [
                    .font: self.font.font,
                    .foregroundColor: textColor.color,
                    .underlineStyle: NSUnderlineStyle.single.rawValue
                ])
            label.attributedText = attributeText
        } else { // 속성 글자 -> 기본글자
            label.text = text
            label.font = self.font.font
            label.textColor = textColor.color
        }
    }
    
}
