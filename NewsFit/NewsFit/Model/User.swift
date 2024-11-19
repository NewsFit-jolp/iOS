import Foundation

struct User: Decodable {
  var nickname: String
  var email: String
  var profileImage: String?
  var phone: String?
  var birth: Date?
  var gender: String?
}

struct UserPostDTO: Encodable {
  var name: String
  var email: String
  var phone: String
  var gender: String
  var birth: Date
}
