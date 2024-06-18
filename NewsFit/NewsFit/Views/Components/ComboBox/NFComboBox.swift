//
//  NFComboBox.swift
//  NewsFit
//
//  Created by User on 6/18/24.
//

import UIKit
import SnapKit

final class NFComboBox: UIView {
    private var comboTable: UITableView!
    private var ComboBoxListViewModel = ComboBoxListViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let tv = UITableView()
        tv.register(NFComboBoxCell.self, forCellReuseIdentifier: NFComboBoxCell.reuseId)
        
        addSubview(comboTable)
    }
}
