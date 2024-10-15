import Foundation

struct News: Identifiable {
  let id: Int
  let title: String
  let content: String
  let createdAt: Date
  let press: String
  let category: String
  let comments: [Comment]
}
