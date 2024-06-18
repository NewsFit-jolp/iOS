//
//  NFToggleButton.swift
//  NewsFit
//
//  Created by User on 6/18/24.
//

import UIKit
import SnapKit

final class NFToggleButton: UIView {
    private var onFalseView: UIView!
    private var onTrueView: UIView!
    private lazy var button: UIButton = {
        let btn: UIButton = .init(type: .custom)
        btn.backgroundColor = nil
        btn.addTarget(self, action: #selector(toggle), for: .touchUpInside)
        return btn
    }()
    
    private(set) var isActive: Bool! {
        didSet {
            onTrueView.isHidden = !isActive
            onFalseView.isHidden = isActive
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(onFalseView: UIView, onTrueView: UIView) {
        self.onFalseView = onFalseView
        self.onTrueView = onTrueView
        self.init(frame: .zero)
    }
    
    
    private func setup() {
        // add subview
        addSubview(onFalseView)
        addSubview(onTrueView)
        
        // add constraints
        onFalseView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        onTrueView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        
        // set button
        addSubview(button)
        button.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        
        // set hidden
        isActive = false
    }
    
    @objc func toggle() {
        self.isActive.toggle()
    }
}
