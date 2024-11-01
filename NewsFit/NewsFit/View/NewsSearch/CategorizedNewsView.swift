import SwiftUI

struct CategorizedNewsView: View {
  var body: some View {
    VStack(alignment: .leading) {
      Text("[어떤] 카테고리 최신 뉴스")
        .font(.NF.title_large)
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
    .font(.NF.text_default)
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
  CategorizedNewsView()
}
