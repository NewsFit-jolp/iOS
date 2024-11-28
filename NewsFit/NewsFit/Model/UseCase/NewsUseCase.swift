import OSLog

protocol NewsUseCaseType {
  func fetchNewsList(category: String, currentNewsID: Int?, size: Int) async -> [News]?
  func fetchRecommnedNewsList(category: String, page: Int, pageSize: Int) async -> [News]?
  func fetchNewsDetail(id: Int) async -> NewsDetail?
}

struct NewsUseCase: NewsUseCaseType {
  //MARK: - Property
  private let repository: NewsRepositoryType
  
  //MARK: - Initializer
  init(repository: NewsRepositoryType) {
    self.repository = repository
  }
  
  //MARK: - Method
  func fetchNewsList(category: String, currentNewsID: Int?, size: Int) async -> [News]? {
    let parameters: [String: String] = [
      "category": category,
      "articleCursor": currentNewsID != nil ? String(currentNewsID!) : "",
      "size": String(size)
    ]
    
    let result = await repository.fetchNewsList(with: parameters)
    switch result {
    case .success(let news):
      return news
    case .failure(let error):
      Logger().error("\(error.localizedDescription)")
      return nil
    }
  }
  func fetchRecommnedNewsList(category: String = "allCategory", page: Int, pageSize: Int) async -> [News]? {
    let parameters: [String: String] = [
      "category": category,
      "page": String(page),
      "pageSize": String(pageSize)
    ]
    
    let result = await repository.fetchRecommendNewsList(with: parameters)
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

