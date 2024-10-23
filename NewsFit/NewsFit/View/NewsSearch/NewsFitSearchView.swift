import SwiftUI

struct NewsFitSearchView: View {
  @State private var text = ""
  var body: some View {
    VStack(spacing: 0) {
      searchBar()
      recentlySearched()
      Divider()
      ScrollView {
        VStack(alignment: .leading, spacing: 20) {
          ForEach(0..<10) { index in
            CategorizedNewsView()
              .frame(height: 200)
              .padding(.horizontal)
          }
        }
      }
      .padding(.top)
    }
  }
  
  @ViewBuilder
  private func searchBar() -> some View {
    HStack {
      TextField("키워드 / 언론사 / 카테고리로 검색", text: $text)
      Image(.nfSearchButton)
    }
    .padding(.horizontal)
    .padding(.vertical, 10)
    .modifier(NFBorderModifier())
    .padding(.horizontal)
  }
  @ViewBuilder
  private func recentlySearched() -> some View {
    VStack {
      HStack {
        Text("최근검색어")
          .font(.headline)
        Spacer()
        Button(action: {}) {
          Text("모두 지우기")
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
      }.padding(.bottom, 10)
      ScrollView(.horizontal) {
        HStack {
          ForEach(0..<10) { index in
            RecentlySerchedCell()
          }
        }
      }
      .scrollIndicators(.never)
    }
    .padding()
  }
}

fileprivate struct RecentlySerchedCell: View {
  var body: some View {
    HStack(alignment: .center) {
      Text("사라져버려")
      Spacer()
      Button(action: {}) {
        Image(.nfxButton)
      }
    }
    .padding(8)
    .modifier(NFBorderModifier())
    .padding(1)
  }
}

#Preview {
  NewsFitSearchView()
}
