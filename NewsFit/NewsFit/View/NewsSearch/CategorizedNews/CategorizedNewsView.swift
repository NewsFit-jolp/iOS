import SwiftUI
import CachedAsyncImage

struct CategorizedNewsView: View {
  @State var viewModel: CategorizedViewModel
  @State var newsDetailViewModel = NewsDetailViewModel.init()
  @State private var isPresented = false
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("\(viewModel.attributedCategory) 카테고리 최신 뉴스")
        .font(.NF.title_middle)
        .lineLimit(1)
      Spacer(minLength: 20)
      TabView {
        if viewModel.news.isEmpty {
          Text("뉴스가 없습니다")
        } else {
          ForEach(viewModel.news) { news in
            displayNews(with: news)
          }
        }
      }
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .tabViewStyle(.page(indexDisplayMode: .always))
    }
    .onAppear {
      fetchNews()
    }
  }
  
  init(category: String) {
    UIPageControl.appearance().currentPageIndicatorTintColor = .nfPurple
    UIPageControl.appearance().pageIndicatorTintColor = .white
    UIPageControl.appearance().isUserInteractionEnabled = false
    self.viewModel = .init(category: category, news: [])
  }
  
  @ViewBuilder
  private func displayNews(with news: News) -> some View {
    VStack(alignment: .leading) {
      Text(news.title)
        .lineLimit(2)
        .padding(.bottom, 15)
      HStack {
        Text(news.press)
        Text("·")
        Text(news.publishedDate)
        Spacer()
      }
      Spacer()
    }
    .font(.NF.text_default)
    .padding()
    .background(
      Gradient(
        colors: [
          .black.opacity(0.3),
          .black.opacity(1)
        ]
      )
    )
    .background {
      CachedAsyncImage(url: URL(string: news.thumbnail ?? "")) { phase in
        switch phase {
        case .success(let image):
          image
            .resizable()
        case .failure:
          Image(.nfxButton)
            .resizable()
        default:
          ProgressView()
        }
      }
      .scaledToFill()
    }
    .foregroundStyle(.white)
    .clipped()
    .onTapGesture {
      isPresented.toggle()
      print(isPresented, news)
      newsDetailViewModel.newsID = news.articleID
    }
    .fullScreenCover(isPresented: $isPresented) {
      NewsDetailSheet(viewModel: newsDetailViewModel)
    }
  }
  private func fetchNews() {
    Task {
      let usecase = NewsUseCase(repository: NewsRepository())
      let result = await usecase.fetchRecommnedNewsList(category: viewModel.category, page: 1, pageSize: 15)
      viewModel.news = result ?? []
    }
  }
}

#Preview {
  CategorizedNewsView(category: "정치")
}
