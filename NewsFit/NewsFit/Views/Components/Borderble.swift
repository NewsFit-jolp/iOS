//
//  Borderble.swift
//  NewsFit
//
//  Created by User on 7/9/24.
//

import UIKit

@propertyWrapper
class Borderble<T: UIView>: UIView {
    
    private var title: NFLabel = {
        let lb = NFLabel()
        lb.setColor(with: .grayDark)
        lb.isHidden = true
        lb.backgroundColor = .backgroundWhite
        lb.setMargin(about: 8)
        return lb
    }()
    
    var wrappedValue: T
    
    var projectedValue: Borderble<T> {
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
        wrappedValue.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        wrappedValue.layer.borderColor = UIColor.borderGray.cgColor
        wrappedValue.layer.borderWidth = 2
        wrappedValue.layer.cornerRadius = 10
        
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.left.equalTo(wrappedValue.snp.left).offset(10)
            make.top.equalTo(wrappedValue.snp.top).offset(-10)
            
        }
    }
    
    func setTitle(with text: String) {
        title.setText(text, with: .body)
        title.isHidden = text.isEmpty
    }
}
