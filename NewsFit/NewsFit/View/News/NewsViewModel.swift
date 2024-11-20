import Foundation

fileprivate typealias ViewModel = NewsPresentable & PressImagePresentable

final class NewsViewModels: ObservableObject {
  //MARK: - Type
  typealias ViewModel = NewsPresentable & PressImagePresentable
  
  //MARK: - Property
  @Published
  private var viewModels: [ViewModel] = []
  private var useCase: NewsUseCaseType
  var count: Int { viewModels.count }
  
  //MARK: - Initializer
  init(useCase: NewsUseCaseType) {
    self.useCase = useCase
  }
  
  //MARK: - Method
  func viewModel(at index: Int) -> ViewModel {
    viewModels[index]
  }
  func fetch(category: String, currentNewsID: Int?, size: Int, isClear: Bool = false) {
    Task {
      guard let result = await useCase.fetchNewsList(category: category, currentNewsID: currentNewsID, size: size) else { return }
      if isClear {
        viewModels = result.map{ NewsViewModel(news: $0) }
      } else {
        viewModels.append(contentsOf: result.map{ NewsViewModel(news: $0) })
      }
    }
  }
}

struct NewsViewModel: ViewModel {
  let id: Int
  let title: String
  let press: String
  var date: String {
    let formatStyle = Date.RelativeFormatStyle(presentation: .numeric, locale: .init(identifier: "ko_KR"))
    return formatStyle.format(createdDate)
  }
  var imageURL: URL?
  var pressImageURL: URL?
  private let createdDate: Date
  
  init(news: News) {
    let imageURL = news.thumbnail != nil ? URL(string: news.thumbnail!) : nil
    self.init(
      id: news.articleID,
      title: news.title,
      press: news.press,
      imageURL: imageURL,
      pressImageURL: nil,
      createdDate: news.publishedDate
    )
  }
  init(id: Int, title: String, press: String, imageURL: URL? = nil, pressImageURL: URL? = nil, createdDate: Date) {
    self.id = id
    self.title = title
    self.press = press
    self.imageURL = imageURL
    self.pressImageURL = pressImageURL
    self.createdDate = createdDate
  }
}
