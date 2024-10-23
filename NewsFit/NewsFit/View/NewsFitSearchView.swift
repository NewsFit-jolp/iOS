import SwiftUI

struct NewsFitSearchView: View {
  @State private var text = ""
  var body: some View {
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
      }
      ScrollView(.horizontal) {
        HStack {
          ForEach(0..<10) { index in
            NewsCategoryCell(viewModel: .init(value: "\(index)"))
          }
        }
      }
    }
    .padding()
  }
}

fileprivate struct CategorizedNewsView: View {
  var body: some View {
    VStack(alignment: .leading) {
      Text("[어떤] 카테고리 최신 뉴스")
        .font(.title3.bold())
      Spacer(minLength: 20)
      TabView {
        ForEach(0..<10) { index in
          displayNews()
        }
      }
      .background(
        Gradient(
          colors: [
            .black.opacity(0.3),
            .black.opacity(1)
          ]
        )
      )
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .tabViewStyle(.page(indexDisplayMode: .always))
    }
  }
  
  init() {
    UIPageControl.appearance().currentPageIndicatorTintColor = .nfPurple
    UIPageControl.appearance().pageIndicatorTintColor = .white
    UIPageControl.appearance().isUserInteractionEnabled = false
  }
  
  @ViewBuilder
  private func displayNews() -> some View {
    VStack(alignment: .leading) {
      Text("'AI 지각생' 애플의 반격…'괴물 칩' 아이패드에 서버용 칩 개발까지")
        .lineLimit(2)
        .padding(.bottom, 15)
      HStack {
        Text("시사저널")
        Text("·")
        Text("3시간전")
        Spacer()
      }
      Spacer()
    }
    .font(.body.bold())
    .padding()
    .background {
      Image(.newsFitLogo)
        .resizable()
        .scaledToFill()
    }
    .foregroundStyle(.white)
    .clipped()
  }
}

#Preview {
  NewsFitSearchView()
}
