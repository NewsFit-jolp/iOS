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
      title: "NULL",
      content: "NULL",
      images: ["https://imgnews.pstatic.net/image/421/2024/11/13/0007903230_001_20241113074308886.jpg?type=w800"],
      press: "루루루",
      category: "NULL",
      articleSource: "https://www.naver.com",
      comment: [
        .init(id: 1, content: "NULL", author: "NULL", createdAt: .now + 10, isDeletable: false)
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
    Task {
      let result = await (newsDetail?.likedArticle == true
                          ? NewsRepository().disLikeNews(id: newsID)
                          : NewsRepository().likeNews(id: newsID))
      switch result {
      case .success:
        Task { @MainActor in
          self.newsDetail?.likedArticle.toggle()
          self.newsDetail?.likeCount += newsDetail?.likedArticle == true ? 1 : -1
        }
      case .failure(let error):
        Logger().error("\(error.localizedDescription)")
      }
    }
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
  func didTapEraseComment(id: Int) {
    guard let newsDetail else { return }
    guard let (idx, comment) = newsDetail.comment.enumerated().filter({ $0.element.id == id }).first else { return }
    guard comment.isDeletable else { return }
    Task {
      let result = await NewsRepository().deleteComment(newsID: newsID, commentID: comment.id)
      switch result {
      case .success:
        Task { @MainActor in self.newsDetail?.comment.remove(at: idx) }
      case .failure(let error):
        Logger().error("\(error.localizedDescription)")
      }
    }
  }
}
