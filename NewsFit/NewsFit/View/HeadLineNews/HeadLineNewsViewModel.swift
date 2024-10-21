import Foundation

protocol NewsPresentable {
  var title: String { get }
  var press: String { get }
  var date: String { get }
  var imageURL: URL? { get }
}

protocol NewsDescriptionPresentable {
  var body: String { get }
}

protocol PressImagePresentable {
  var pressImageURL: URL? { get }
}

typealias HeadLineNewsPresentable = NewsPresentable & NewsDescriptionPresentable

struct HeadLineNewsViewModel: HeadLineNewsPresentable {
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
