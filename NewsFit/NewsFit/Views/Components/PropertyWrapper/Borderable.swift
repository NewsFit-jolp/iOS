//
//  Borderble.swift
//  NewsFit
//
//  Created by User on 7/9/24.
//

import UIKit

@propertyWrapper
class Borderable<T: UIView>: UIView {
    
    private var title: NFLabel = {
        let lb = NFLabel()
        lb.setColor(with: .grayDark)
        lb.isHidden = true
        lb.backgroundColor = .backgroundWhite
        lb.setMargin(width: 10)
        return lb
    }()
    
    var wrappedValue: T
    
    var projectedValue: Borderable<T> {
        self
    }
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        addSubview(wrappedValue)
        addSubview(title)
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview()
        }
        
        
        wrappedValue.layer.borderColor = UIColor.borderGray.cgColor
        wrappedValue.layer.borderWidth = 2
        wrappedValue.layer.cornerRadius = 10
        wrappedValue.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(-10)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    
    func setTitle(with text: String) {
        title.setText(text, with: .body)
        title.isHidden = text.isEmpty
    }
}
