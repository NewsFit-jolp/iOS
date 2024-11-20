import SwiftUI

struct NewsFitSearchView: View {
  @State private var text: String = ""
  @State private var categories: [String] = []
  private var newsUseCase: NewsUseCaseType = NewsUseCase(repository: NewsRepository())
  
  private var isSearchMode: Bool {
    !text.isEmpty
  }
  var body: some View {
    VStack(spacing: 0) {
      NewsSearchBar(text: $text)
      RecentlySearchedView()
      Divider()
      if isSearchMode {
        NewsSearchResultView()
      } else {
        categorizedNewsView()
      }
    }
    .onAppear {
      fetchCategories()
    }
  }
  @ViewBuilder
  private func categorizedNewsView() -> some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        ForEach(Array(zip(categories.indices, categories)), id: \.0) { index, category in
          CategorizedNewsView(category: category)
            .frame(height: 200)
            .padding(.horizontal)
        }
      }
      .padding(.top)
    }
  }
  private func fetchCategories() {
    Task {
      if case let .success(categories) = await UserService.shared.fetchUserCategories() {
        self.categories = categories
      }
    }
  }
}

#Preview {
  NewsFitSearchView()
}

//MARK: - MainTabViewControllerConfigurable
extension NewsFitSearchView: MainTabViewControllerConfigurable {
  func mainTabViewControllerTabBarTitle() -> String {
    return "검색"
  }
  func mainTabViewControllerTabBarImage() -> UIImage {
    return .nfNaviagtionSearch
  }
}
