//
//  NFLabel.swift
//  NewsFit
//
//  Created by User on 6/18/24.
//

import UIKit
import SnapKit

final class NFLabel: UIView {
    private var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        // setting label
        label = .init()
        label.font = .NF.text_default
        label.textColor = .textDark
        label.textAlignment = .left
        
        // add subview
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
    }
    
    func setText(with text: String) {
        label.text = text
    }
    
}
