import Foundation

fileprivate typealias ViewModel = NewsPresentable & PressImagePresentable

struct NewsViewModels {
  //MARK: - Type
  typealias ViewModel = NewsPresentable & PressImagePresentable
  
  //MARK: - Properties
  private var viewModels: [ViewModel]
  var count: Int { viewModels.count }
  
  //MARK: - Initializers
  init(viewModels: [ViewModel]) {
    self.viewModels = viewModels
  }
  
  //MARK: - Methods
  func viewModel(at index: Int) -> ViewModel {
    viewModels[index]
  }
}

struct NewsViewModel: ViewModel {
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
    self.init(title: news.title, press: news.press, imageURL: nil, pressImageURL: nil, createdDate: news.createdAt)
  }
  init(title: String, press: String, imageURL: URL? = nil, pressImageURL: URL? = nil, createdDate: Date) {
    self.title = title
    self.press = press
    self.imageURL = imageURL
    self.pressImageURL = pressImageURL
    self.createdDate = createdDate
  }
}
