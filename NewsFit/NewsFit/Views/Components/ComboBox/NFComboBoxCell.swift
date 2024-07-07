//
//  NFComboBoxCell.swift
//  NewsFit
//
//  Created by User on 6/18/24.
//

import UIKit
import SnapKit

/// 콤보박스 셀을 의미합니다.
/// 셀 하나를 만들 때 만들고 나서 configure함수를 실행해야 합니다.
final class NFComboBoxCell: UITableViewCell {
    static let reuseId = "NFComboBoxCell"
    
    private let button: NFToggleButton = {
        let falseView = {
            let v = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
            v.layer.cornerRadius = 16/2
            v.layer.borderWidth = 1
            v.layer.borderColor = UIColor.textGray.cgColor
            v.clipsToBounds = true
            v.backgroundColor = nil
            return v
        }()
        let trueView = {
            let v = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
            let vIn = UIView()
            vIn.layer.cornerRadius = 16/2
            vIn.backgroundColor = .nFpurple
            v.addSubview(vIn)
            vIn.snp.makeConstraints { make in
                make.height.width.equalTo(8)
                make.centerX.centerY.equalToSuperview()
            }
            v.layer.cornerRadius = 8/2
            v.layer.borderWidth = 1
            v.layer.borderColor = UIColor.nFpurple.cgColor
            v.clipsToBounds = true
            v.backgroundColor = nil
            return v
        }()
        
        let b = NFToggleButton(onFalseView: falseView, onTrueView: trueView)
        
        
        return b
    }()
    
    private let label = NFLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(button)
        addSubview(label)
        
        button.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(button.snp.right).offset(12)
            make.right.equalToSuperview().offset(12)
        }
    }
    
    func configure(_ vm: ComboViewModel) {
        label.setText(vm.text, with: .body)
    }
    
}
