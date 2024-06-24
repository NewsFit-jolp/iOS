//
//  ComboViewModel.swift
//  NewsFit
//
//  Created by User on 6/19/24.
//

import UIKit

/// 콤보박스를 위한 뷰모델입니다.
struct ComboBoxListViewModel {
    private var comboViewModels = [ComboViewModel]()
    private(set) var selectedIdx = 0
    
    var numberOfVMs: Int {
        return comboViewModels.count
    }
    
    func modelAt(_ idx: Int) -> ComboViewModel {
        return comboViewModels[idx]
    }
    
    mutating func addComboViewModel(_ vm: ComboViewModel) {
        comboViewModels.append(vm)
    }
    
    mutating func changeSelected(to idx: Int) {
        comboViewModels[selectedIdx].didSelected.toggle()
        selectedIdx = idx
        comboViewModels[selectedIdx].didSelected.toggle()
    }
}

/// 콤보박스 항목 하나를 위한 뷰모델입니다.
struct ComboViewModel {
    private let str: String = ""
    var didSelected: Bool = false
    
    var text: String {
        return str
    }
}
