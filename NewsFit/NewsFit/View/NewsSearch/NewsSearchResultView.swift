import SwiftUI

struct NewsSearchResultView: View {
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        Text("\"검색어\"에 대한 뉴스")
          .font(.title.bold())
          .padding(.leading)
        VStack {
          ForEach(0..<10) { index in
            VStack(alignment: .leading) {
              NewsCell(viewModel: NewsViewModel(news: .init(id: 10, title: "hisdfsdfsdfdsfsffssdfsdfdsfsddfsdfdfsdfdsfsdfdsdfdsfsdfdsfsdfsddsf", content: "cc", createdAt: .now, press: "고양이뉴스!", category: "IT", comments: [])))
                .padding()
              Divider()
            }
          }
        }
        .padding()
        .background(Color.nfBackgroundAccent.opacity(0.3))
        .modifier(NFBorderModifier())
      }
      .padding(.top)
      .padding(.bottom, 110)
    }
  }
}


#Preview {
  NewsSearchResultView()
}
