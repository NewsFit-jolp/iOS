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

protocol Focusable {
  var isFocused: Bool { get }
}

typealias HeadLineNewsPresentable = NewsPresentable & NewsDescriptionPresentable & Focusable

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
  var isFocused: Bool
  private let createdDate: Date
  
  init(title: String, press: String, body: String, imageURL: URL?, isFocused: Bool, createdDate: Date) {
    self.title = title
    self.press = press
    self.body = body
    self.imageURL = imageURL
    self.isFocused = isFocused
    self.createdDate = createdDate
  }
}
