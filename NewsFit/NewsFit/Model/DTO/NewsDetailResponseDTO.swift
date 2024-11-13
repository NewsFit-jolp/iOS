import Foundation

struct NewsDetailResponseDTO: Decodable {
  let title: String
  let content: String
  let images: [String]
  let press: String
  let category: String
  let articleSource: String
  let comment: [CommentResponseDTO]
  let likeCount: Int
  let likedArticle: Bool
}
