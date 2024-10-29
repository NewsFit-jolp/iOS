import Foundation

struct NewsResponseDTO: Decodable {
  let articleID: Int
  let title: String
  let headLine: String?
  let press: String
  let category: String
  let thumbnail: String?
  let publishedDate: Date
}
