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
              NewsCell(viewModel: NewsViewModel(news: News(articleID: -1, title: "", headLine: "", press: "", category: "", thumbnail: "", publishedDate: .now)))
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
