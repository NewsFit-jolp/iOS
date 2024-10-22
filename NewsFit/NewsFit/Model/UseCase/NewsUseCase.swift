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
    return (try? await repository.fetchNewsList().get()) ?? []
  }
}

struct NewsUseCaseDemo: NewsUseCaseType {
  func fetchNewsList() async -> [News] {
    return [
      News(id: 1, title: "\"최악의 기후재앙\"...브라질 남부 폭우에 사망.실종 220명 넘어서", content: "한겨레", createdAt: .now, press: "한겨레", category: "News", comments: [])
    ]
  }
}
