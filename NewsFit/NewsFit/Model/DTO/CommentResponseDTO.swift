import Foundation

struct CommentResponseDTO: Decodable {
  let commentId: Int
  let content: String
  let nickName: String
  let likeCount: Int
  let createdDate: Date
  let isMyComment: Bool
}
