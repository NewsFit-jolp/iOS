protocol NewsUseCaseType {
  func fetchNewsList() async -> [News]
}

struct NewsUseCase: NewsUseCaseType {
  //MARK: - Properties
  private let repository: NewsRepositoryType
  
  //MARK: - Initializers
  init(repository: NewsRepositoryType) {
    self.repository = repository
  }
  
  //MARK: - Methods
  func fetchNewsList() async -> [News] {
    return (try? await repository.fetchNewsList(category: "", currentPage: 1, size: 10).get()) ?? []
  }
}

