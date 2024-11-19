import Foundation

protocol NewsPresentable {
  var id: Int { get }
  var title: String { get }
  var press: String { get }
  var date: String { get }
  var imageURL: URL? { get }
}
