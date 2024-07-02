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
    
    case kakaoLogin(isSmall: Bool)
    case naverLogin(isSmall: Bool)
    case appleLogin(isSmall: Bool)
    
    var backgroundColor: UIColor? {
        switch self {
        case .primary:
                .buttonDefault
        case .warning:
                .buttonCancel
        case .mark:
                nil
        case .kakaoLogin(let isSmall):
            isSmall ? .backgroundWhite : .kakaoLoginBackground
        case .naverLogin(let isSmall):
            isSmall ? .backgroundWhite : .naverLoginBackground
        case .appleLogin(let isSmall):
            isSmall ? .backgroundWhite : .appleLoginBackground
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
        case .kakaoLogin:
            nil
        case .naverLogin:
            nil
        case .appleLogin:
            nil
        }
    }
    
    var onDisabledColor: UIColor? {
        switch self {
        case .primary:
                .buttonDefaultDisabled
        case .warning:
                .buttonCancelDisabled
        case .mark:
            nil
        case .kakaoLogin:
            nil
        case .naverLogin:
            nil
        case .appleLogin:
            nil
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
        case .kakaoLogin(let isSmall):
            isSmall ? 105 : 331
        case .naverLogin(let isSmall):
            isSmall ? 105 : 331
        case .appleLogin(let isSmall):
            isSmall ? 105 : 331
        }
        
        let height = switch self {
        case .primary:
            56
        case .warning:
            56
        case .mark:
            12
        case .kakaoLogin:
            56
        case .naverLogin:
            56
        case .appleLogin:
            56
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
        button.layer.cornerRadius = 8
    }
    
    // 스타일 적용
    private func applyStyle(with style: NFButtonStyle) {
        // 스타일 설정
        self.style = style
        
        // 배경색 설정
        self.backgroundColor = style.backgroundColor
        
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
        self.backgroundColor = self.button.isEnabled ? style.backgroundColor : style.onDisabledColor
    }
    
    func addTarget(action: Selector) {
        self.button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    func setTitle(views: [UIView], spacing: CGFloat) {
        views.forEach { view in
            self.title.addArrangedSubview(view)
        }
        self.title.axis = .horizontal
        self.title.spacing = spacing
        self.title.alignment = .fill
        self.title.distribution = .equalSpacing
    }
}
