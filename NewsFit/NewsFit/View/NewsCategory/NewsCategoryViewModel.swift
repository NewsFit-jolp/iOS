import Foundation

final class NewsCategoryViewModels: ObservableObject {
  @Published
  private var viewModels: [NewsCategoryViewModel] = []
  private var selectedIndex: Int = 0
  var count: Int { viewModels.count }
  var selectedItem: NewsCategoryViewModel { viewModels[selectedIndex] }
  
  init(viewModels: [NewsCategoryViewModel], selectedIndex: Int = 0) {
    self.viewModels = viewModels
    select(at: selectedIndex)
  }
  
  func viewModel(at index: Int) -> NewsCategoryViewModel {
    viewModels[index]
  }
  func isSelected(at index: Int) -> Bool {
    viewModels[index].isSelected
  }
  func select(at index: Int) {
    viewModels[selectedIndex].isSelected = false
    selectedIndex = index
    viewModels[selectedIndex].isSelected = true
  }
}

struct NewsCategoryViewModel {
  let value: String
  var isSelected: Bool = false
}
