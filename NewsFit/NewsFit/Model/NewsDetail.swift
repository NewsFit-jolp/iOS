import Foundation

struct NewsDetail {
  let title: String
  let content: String
  let images: [String]
  let press: String
  let category: String
  let articleSource: String
  var comment: [Comment]
  var likeCount: Int
  var likedArticle: Bool
}
