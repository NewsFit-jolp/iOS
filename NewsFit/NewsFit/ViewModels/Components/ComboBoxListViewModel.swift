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
    var selectedIdx = 0
    
    var numberOfVMs: Int {
        return comboViewModels.count
    }
    
    func modelAt(_ idx: Int) -> ComboViewModel {
        return comboViewModels[idx]
    }
    
    mutating func addComboViewModel(_ vm: ComboViewModel) {
        comboViewModels.append(vm)
    }
}

/// 콤보박스 항목 하나를 위한 뷰모델입니다.
struct ComboViewModel {
    private let str: String = ""
    
    var text: String {
        return str
    }
}
