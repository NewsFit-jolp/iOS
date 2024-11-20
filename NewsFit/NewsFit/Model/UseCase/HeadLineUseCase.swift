import Foundation
import OSLog

protocol HeadLineUseCaseType {
  func fetchHeadLine() async -> [News]?
  func fetchNewsDetail(id: Int) async -> NewsDetail?
}

struct HeadLineUseCase: HeadLineUseCaseType {
  //MARK: - Property
  private let repository: NewsRepositoryType
  
  //MARK: - Initializer
  init(repository: NewsRepositoryType) {
    self.repository = repository
  }
  
  //MARK: - Method
  func fetchHeadLine() async -> [News]? {
    let result = await repository.fetchHeadLineList()
    switch result {
    case .success(let news):
      return news
    case .failure(let error):
      Logger().error("\(error.localizedDescription)")
      return nil
    }
  }
  func fetchNewsDetail(id: Int) async -> NewsDetail? {
    let result = await repository.fetchNewsDetail(id: id)
    switch result {
    case .success(let newsDetail):
      return newsDetail
    case .failure(let error):
      Logger().error("\(error.localizedDescription)")
      return nil
    }
  }
}

