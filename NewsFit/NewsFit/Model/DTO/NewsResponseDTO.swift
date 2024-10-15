import Foundation

struct NewsResponseDTO: Decodable {
  let createdDate: Date
  let lastModifiedDate: Date
  let isDeleted: Bool
  let articleID: Int
  let title: String
  let content: String
  let press: String
  let category: String
  let comments: [CommentResponseDTO]
  
  enum CodingKeys: String, CodingKey {
    case createdDate
    case lastModifiedDate
    case isDeleted
    case articleID = "article_id"
    case title
    case content
    case press
    case category
    case comments
  }
}
