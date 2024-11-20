import Foundation

final class UserService {
  enum UserServiceError: Error {
    case invalidData
    case invalidJSON
    case invalidResponse
  }
  static let shared = UserService()
  var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .custom { decoder -> Date in
      let container = try decoder.singleValueContainer()
      let dateString = try container.decode(String.self)
      
      // 나노초를 포함한 날짜 포맷 시도
      let formatterWithNano = DateFormatter()
      formatterWithNano.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS+SS:SS"
      formatterWithNano.locale = Locale(identifier: "ko_KR")
      
      if let date = formatterWithNano.date(from: dateString) {
        return date
      }
      
      // 초 단위까지만 있는 경우
      let formatterWithoutNano = DateFormatter()
      formatterWithoutNano.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
      formatterWithoutNano.locale = Locale(identifier: "ko_KR")
      
      if let date = formatterWithoutNano.date(from: dateString) {
        return date
      }
      
      throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format: \(dateString)")
    }
    return decoder
  }
  
  private init() {}
  
  func fetchInformation() async -> Result<User, Error> {
    let baseURL = Bundle.baseURL
    let path = "/member/info"
    let token = Bundle.token
    
    let request = HTTPRequestBuilder(baseURL: baseURL, path: path, method: .get)
      .update(headers: ["Authorization": "Bearer \(token)",
                        "Content-Type": "application/json"])
      .build()
    
    guard let data = try? await HTTPServiceProvider().fetchData(for: request).get() else {
      return .failure(UserServiceError.invalidData)
    }
    
    guard let decoded = try? decoder.decode(NetworkResponseDTO<User>.self, from: data) else {
      return .failure(UserServiceError.invalidJSON)
    }
    
    return .success(decoded.result)
  }
  func fetchUserPress() async -> Result<[String], Error> {
    let baseURL = Bundle.baseURL
    let path = "/member/press"
    let token = Bundle.token
    
    let request = HTTPRequestBuilder(baseURL: baseURL, path: path, method: .get)
      .update(headers: ["Authorization": "Bearer \(token)",
                        "Content-Type": "application/json"])
      .build()
    
    guard let data = try? await HTTPServiceProvider().fetchData(for: request).get() else {
      return .failure(UserServiceError.invalidData)
    }
    
    guard let decoded = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
      return .failure(UserServiceError.invalidJSON)
    }
    
    guard let result = decoded["result"] as? [String: [String]] else {
      return .failure(UserServiceError.invalidJSON)
    }
    
    guard let preferredPress = result["preferredPress"] else {
      return .failure(UserServiceError.invalidJSON)
    }
    
    return .success(preferredPress)
  }
  func fetchUserTopics() async -> Result<[String], Error> {
    let baseURL = Bundle.baseURL
    let path = "/member/categories"
    let token = Bundle.token
    
    let request = HTTPRequestBuilder(baseURL: baseURL, path: path, method: .get)
      .update(headers: ["Authorization": "Bearer \(token)",
                        "Content-Type": "application/json"])
      .build()
    
    guard let data = try? await HTTPServiceProvider().fetchData(for: request).get() else {
      return .failure(UserServiceError.invalidData)
    }
    
    guard let decoded = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
      return .failure(UserServiceError.invalidJSON)
    }
    
    guard let result = decoded["result"] as? [String: [String]] else {
      return .failure(UserServiceError.invalidJSON)
    }
    
    guard let preferredTopics = result["preferredCategories"] else {
      return .failure(UserServiceError.invalidJSON)
    }
    
    return .success(preferredTopics)
  }
}
