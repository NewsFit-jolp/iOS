import Foundation

struct Comment: Identifiable, Hashable {
  let id: Int
  let content: String
  let author: String
  let createdAt: Date
}
