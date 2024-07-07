//
//  NFComboBox.swift
//  NewsFit
//
//  Created by User on 6/18/24.
//

import UIKit
import SnapKit

/// 콤보박스입니다.
final class NFComboBox: UIView {
    private var comboTable: UITableView!
    private var comboBoxListViewModel = ComboBoxListViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        // setup - TableView
        let tv = UITableView()
        tv.register(NFComboBoxCell.self, forCellReuseIdentifier: NFComboBoxCell.reuseId)
        tv.dataSource = self
        tv.delegate = self
        
        tv.rowHeight = 35
        
        // add subview - TableView
        addSubview(comboTable)
    }
}

extension NFComboBox: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        comboBoxListViewModel.changeSelected(to: indexPath.row)
        tableView.reloadData()
    }
}


extension NFComboBox: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.comboBoxListViewModel.numberOfVMs
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NFComboBoxCell.reuseId, for: indexPath) as! NFComboBoxCell
        
        let comboBoxViewModel = self.comboBoxListViewModel.modelAt(indexPath.row)
        
        cell.configure(comboBoxViewModel)
        
        return cell
    }
    
    
}
