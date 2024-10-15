import Foundation

struct CommentResponseDTO: Decodable {
  let commentId: Int
  let content: String
  let nickName: String
  let createdDate: Date
  let isDeleted: Bool
}
