import Foundation
import OSLog

final class NewsDetailViewModel: ObservableObject {
  @Published var newsDetail: NewsDetail?
  @Published var selectedAt: Int = 0
  
  init(newsID: Int) {
    Task {
      let result = await NewsRepository().fetchNewsDetail(id: newsID)
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
