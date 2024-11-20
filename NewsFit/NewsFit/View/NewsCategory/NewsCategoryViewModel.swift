import Foundation

final class NewsCategoryViewModels: ObservableObject {
  //MARK: - Property
  @Published
  private var viewModels: [NewsCategoryViewModel] = []
  @Published
  private var selectedIndex: Int = 0
  var count: Int { viewModels.count }
  var selectedItem: NewsCategoryViewModel { viewModels[selectedIndex] }
  
  //MARK: - Initializer
  init() {
    viewModels = [ .init(value: "전체", isSelected: true) ]
  }
  init(viewModels: [NewsCategoryViewModel], selectedIndex: Int = 0) {
    self.viewModels = viewModels
    select(at: selectedIndex)
  }
  
  //MARK: - Method
  func fetch() {
    Task {
      let result = await UserService.shared.fetchUserCategories()
      guard case let .success(categories) = result else { return }
      categories.forEach { viewModels.append(.init(value: $0)) }
    }
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
