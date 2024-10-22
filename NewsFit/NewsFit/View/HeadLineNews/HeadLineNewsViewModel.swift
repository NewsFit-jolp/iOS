import Foundation

fileprivate typealias ViewModel = NewsPresentable & NewsDescriptionPresentable

struct HeadLineNewsViewModels {
  //MARK: - Type
  typealias ViewModel = NewsPresentable & NewsDescriptionPresentable
  
  //MARK: - Properties
  private var viewModels: [ViewModel] = []
  private var useCase: NewsUseCaseType
  var count: Int { viewModels.count }
  
  //MARK: - Initializers
  init(useCase: NewsUseCaseType) {
    self.useCase = useCase
  }
  
  //MARK: - Methods
  func viewModel(at index: Int) -> ViewModel {
    viewModels[index]
  }
}

struct HeadLineNewsViewModel: ViewModel {
  //MARK: - Properties
  let title: String
  let press: String
  var date: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd"
    return formatter.string(from: createdDate)
  }
  let body: String
  let imageURL: URL?
  private let createdDate: Date
  
  //MARK: - Initializers
  init(news: News) {
    self.init(title: news.title, press: news.press, body: news.content, imageURL: nil, createdDate: news.createdAt)
  }
  init(title: String, press: String, body: String, imageURL: URL?, createdDate: Date) {
    self.title = title
    self.press = press
    self.body = body
    self.imageURL = imageURL
    self.createdDate = createdDate
  }
}
