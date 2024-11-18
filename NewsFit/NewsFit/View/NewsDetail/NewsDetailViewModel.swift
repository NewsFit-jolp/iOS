import Foundation
import OSLog

final class NewsDetailViewModel: ObservableObject {
  var newsID: Int = 0 {
    didSet {
      fetchNewsDetail(fromID: newsID)
    }
  }
  @Published var newsDetail: NewsDetail?
  @Published var selectedAt: Int = 0
  @Published var isPresented: Bool = false
  @Published var commentText: String = ""
  
  init() {
    newsDetail = NewsDetail(
      title: "고양이님이 츄르를 주문하셔... 고양이가 츄르를 주문하셔...",
      content: "고양이님이 츄르를 집사에게 주문하여 화제가 되었습니다. 기존에는 고양이님이 무전으로 취식하셨다면, 이번에는 정당한 방식으로 돈을 내고 주문을 하였습니다. 아아... 은혜로워라... 떠오르는 두 논당자 자꾸 가슴이 시려서 잊혀지길바랬어 꿈이라면 이제 깨어났으면 제발 정말네가 나의 운명인걸까.. 넌 falling you!",
      images: ["https://imgnews.pstatic.net/image/421/2024/11/13/0007903230_001_20241113074308886.jpg?type=w800"],
      press: "루루루",
      category: "이게맞아?",
      articleSource: "https://www.naver.com",
      comment: [
        .init(id: 1, content: "EEEE", author: "EFJEI", createdAt: .now + 10, isDeletable: false)
      ],
      likeCount: 100,
      likedArticle: true
    )
  }
  private func fetchNewsDetail(fromID id: Int) {
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
    Task {
      let result = await NewsRepository().postComment(id: newsID, content: commentText)
      switch result {
      case .success(let comment):
        Task { @MainActor in
          self.newsDetail?.comment.insert(comment, at: 0)
          self.commentText = ""
        }
      case .failure(let error):
        Logger().error("\(error.localizedDescription)")
      }
    }
  }
  func didTapEraseComment(at index: Int) {
    guard let newsDetail else { return }
    guard let comment = newsDetail.comment.filter { $0.id == index }.first else { return }
    guard comment.isDeletable else { return }
    Task {
      let result = await NewsRepository().deleteComment(newsID: newsID, commentID: comment.id)
      switch result {
      case .success:
        Task { @MainActor in self.newsDetail?.comment.remove(at: index) }
      case .failure(let error):
        Logger().error("\(error.localizedDescription)")
      }
    }
  }
}
