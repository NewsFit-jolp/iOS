import SwiftUI

struct NewsFitSearchView: View {
  @State private var text: String = ""
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
  }
  @ViewBuilder
  private func categorizedNewsView() -> some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        ForEach(0..<10) { index in
          CategorizedNewsView()
            .frame(height: 200)
            .padding(.horizontal)
        }
      }
      .padding(.top)
    }
  }
}

#Preview {
  NewsFitSearchView()
}
