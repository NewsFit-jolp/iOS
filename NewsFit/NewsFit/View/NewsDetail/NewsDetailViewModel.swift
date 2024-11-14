import Foundation
import OSLog

final class NewsDetailViewModel: ObservableObject {
  @Published var newsDetail: NewsDetail?
  @Published var selectedAt: Int = 0
  @Published var isPresented: Bool = false
  @Published var commentText: String = ""
  
  init(newsID: Int) {
    fetchNewsDetail(fromID: newsID)
  }
  init() {
    newsDetail = NewsDetail(
      title: "고양이님이 츄르를 주문하셔... 고양이가 츄르를 주문하셔...",
      content: "고양이님이 츄르를 집사에게 주문하여 화제가 되었습니다. 기존에는 고양이님이 무전으로 취식하셨다면, 이번에는 정당한 방식으로 돈을 내고 주문을 하였습니다. 아아... 은혜로워라... 떠오르는 두 논당자 자꾸 가슴이 시려서 잊혀지길바랬어 꿈이라면 이제 깨어났으면 제발 정말네가 나의 운명인걸까.. 넌 falling you!",
      images: ["https://imgnews.pstatic.net/image/421/2024/11/13/0007903230_001_20241113074308886.jpg?type=w800"],
      press: "루루루",
      category: "이게맞아?",
      articleSource: "https://www.naver.com",
      comment: [
        .init(id: 1, content: "LOVE", author: "턱시도", createdAt: .distantFuture),
        .init(id: 2, content: "응 아니야", author: "고양딱", createdAt: .now),
        .init(id: 3, content: "ㅉㅉㅉ", author: "딱 너다야", createdAt: .now + 100),
        .init(id: 4, content: "역시 고양이가 짱이야", author: "엄준식", createdAt: .now + 10),
      ],
      likeCount: 100,
      likedArticle: true
    )
  }
  func fetchNewsDetail(fromID id: Int) {
    Task {
      let result = await NewsRepository().fetchNewsDetail(id: id)
      switch result {
      case .success(let newsDetail):
        Task { @MainActor in self.newsDetail = newsDetail }
      case .failure(let error):
        Logger().error("\(error.localizedDescription)")
      }
    }
  }
  func didTapLike() {
    
  }
  func didTapSendComment() {
    
  }
  func didTapEraseComment(at index: Int) {
    
  }
}
