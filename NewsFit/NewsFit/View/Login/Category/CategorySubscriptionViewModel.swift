import Foundation

final class CategorySubscriptionViewModel: ObservableObject {
  @Published
  var categories: [CategorySubscriptionCellViewModel] = [
    .init(icon: "🏛️", name: "정치"),
    .init(icon: "💰", name: "경제"),
    .init(icon: "👥", name: "사회"),
    .init(icon: "🏠", name: "생활/문화"),
    .init(icon: "🌏", name: "세계"),
    .init(icon: "💻", name: "기술/IT"),
    .init(icon: "🎤", name: "연예"),
    .init(icon: "⚽", name: "스포츠"),
  ]
  
  func saveCategories() {
    // Save selected topics
    Task {
      let selectedCategories = categories.filter { $0.isPressed }.map { $0.name }
      _ = await UserService.shared.updateCategories(categories: selectedCategories)
    }
  }
  func isValid() -> Bool {
    isSelectedMoreThanThree()
  }
  func fetchCategories() {
    Task {
      let selectedCategories = await UserService.shared.fetchUserCategories()
      guard case let .success(selectedCategories) = selectedCategories else { return }
      for category in selectedCategories {
        for index in 0..<categories.count {
          if categories[index].name == category {
            categories[index].isPressed = true
            break
          }
        }
      }
    }
  }
  private func isSelectedMoreThanThree() -> Bool {
    categories.filter { $0.isPressed }.count >= 3
  }
}


struct CategorySubscriptionCellViewModel {
  var isPressed: Bool = false
  let icon: String
  let name: String
}
