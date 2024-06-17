//
//  NFButton.swift
//  NewsFit
//
//  Created by User on 6/4/24.
//

import UIKit
import SnapKit

enum NFButtonStyle {
    case primary(isHalf: Bool)
    case warning(isHalf: Bool)
    case mark
    
    var backgroundColor: UIColor? {
        switch self {
        case .primary:
                .buttonDefault
        case .warning:
                .buttonCancel
        case .mark:
                nil
        }
    }
    
    var onClickColor: UIColor? {
        switch self {
        case .primary:
                .buttonDefaultClicked
        case .warning:
                .buttonCancelClicked
        case .mark:
            nil
        }
    }
    
    var onDiabledColor: UIColor? {
        switch self {
        case .primary:
                .buttonDefaultDisabled
        case .warning:
                .buttonCancelDisabled
        case .mark:
            nil
        }
    }
    
    var font: UIFont {
        switch self {
        case .primary:
                .NF.button_default
        case .warning:
                .NF.button_default
        case .mark:
                .NF.button_default
        }
    }
    
    var frame: CGRect {
        let width = switch self {
        case .primary(let isHalf):
             isHalf ? 160 : 331
        case .warning(let isHalf):
            isHalf ? 160 : 331
        case .mark:
            12
        }
        
        let height = switch self {
        case .primary:
            56
        case .warning:
            56
        case .mark:
            12
        }
        
        return .init(x: 0, y: 0, width: width, height: height)
    }
    
}

// MARK: - NewsFit Button
final class NFButton: UIView {
    
    private let button = UIButton(type: .custom)
    private var title = UIStackView()
    private var style: NFButtonStyle!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(with style: NFButtonStyle) {
        self.init(frame: style.frame)
        applyStyle(with: style)
    }
    
    // MARK: - Setup
    private func setup() {
        // Add view hireachy
        addSubview(title)
        title.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        addSubview(button)
        button.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
    }
    
    // 스타일 적용
    private func applyStyle(with style: NFButtonStyle) {
        // 스타일 설정
        self.style = style
        
        // 배경색 설정
        self.backgroundColor = style.backgroundColor
        
        // 글꼴 설정
        self.title.subviews.forEach { view in
            (view as? UILabel)?.font = style.font
        }
        
        // 클릭시 색 설정
        self.button.addTarget(self, action: #selector(self.onClick), for: .touchDown)
        self.button.addTarget(self, action: #selector(self.offClick), for: .touchCancel)
    }
    
    // 클릭시 색 설정
    @objc private func onClick() {
        self.backgroundColor = self.style.onClickColor
    }
    // 클릭 끝나면 색 설정
    @objc private func offClick() {
        self.backgroundColor = self.style.backgroundColor
    }
    
    func toggleEnabled() {
        self.button.isEnabled.toggle()
        self.backgroundColor = self.button.isEnabled ? style.backgroundColor : style.onDiabledColor
    }
    
    func addTarget(action: Selector) {
        self.button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    func setTitle(views: [UIView]) {
        views.forEach { view in
            self.title.addArrangedSubview(view)
        }
        self.title.axis = .horizontal
        self.title.spacing = 5
        self.title.alignment = .fill
        self.title.distribution = .equalSpacing
    }
}
