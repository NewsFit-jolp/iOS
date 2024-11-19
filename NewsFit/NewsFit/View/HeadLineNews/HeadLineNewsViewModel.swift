import Foundation

fileprivate typealias ViewModel = NewsPresentable & NewsDescriptionPresentable

final class HeadLineNewsViewModels: ObservableObject {
  //MARK: - Type
  typealias ViewModel = NewsPresentable & NewsDescriptionPresentable
  
  //MARK: - Properties
  @Published
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
  func fetch() {
    Task {
      guard let result = await useCase.fetchNewsList(category: "", currentNewsID: nil, size: 10) else { return }
      viewModels.append(contentsOf: result.map{ HeadLineNewsViewModel(news: $0) })
    }
  }
}

struct HeadLineNewsViewModel: ViewModel {
  //MARK: - Properties
  var id: Int
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
    let imageURL = news.thumbnail != nil ? URL(string: news.thumbnail!) : nil
    self.init(id: news.articleID, title: news.title, press: news.press, body: news.headLine ?? "", imageURL: imageURL, createdDate: news.publishedDate)
  }
  init(id: Int, title: String, press: String, body: String, imageURL: URL?, createdDate: Date) {
    self.id = id
    self.title = title
    self.press = press
    self.body = body
    self.imageURL = imageURL
    self.createdDate = createdDate
  }
}
