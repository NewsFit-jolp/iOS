import Foundation

protocol NewsRepositoryType {
  func fetchNewsList(category: String, currentPage: Int, size: Int) async -> Result<[News], Error>
  func fetchSingleNews(id: Int) async -> Result<News, Error>
}

struct NewsRepository: NewsRepositoryType {
  enum RepositoryError: Error {
    case invalidData
    case invalidJSON
    case invalidResponse
  }
  //MARK: - Properties
  
  
  //MARK: - Methods
  func fetchNewsList(category: String, currentPage: Int, size: Int) async -> Result<[News], Error> {
    //TODO: - 서비스로 연결
    let baseURL = Bundle.baseURL
    let path = "/articles"
    let method: HTTPMethod = .get
    let token = Bundle.token
    let parameters: [String: String] = ["category": category, "currentPage": String(currentPage), "size": String(size)]
    
    let request = HTTPRequestBuilder(baseURL: baseURL, path: path, method: .get)
      .update(parameters: parameters)
      .update(headers: ["Authorization": "Bearer \(token)"])
      .build()
    
    guard let data = try? await HTTPServiceProvider().fetchData(for: request).get() else {
      return .failure(RepositoryError.invalidData)
    }
    
    guard let decoded = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
      return .failure(RepositoryError.invalidJSON)
    }
    
    if let result = decoded["result"] as? [NewsResponseDTO] {
      return .success(NewsMapper.map(result))
    } else {
      return .failure(NSError(domain: "bye", code: 1))
    }
  }
  func fetchSingleNews(id: Int, parameters: [String: String]) async -> Result<News, Error> {
    let baseURL = Bundle.baseURL
    let path = "id"
    let method: HTTPMethod = .get
    let token = Bundle.token
    let parameters: [String: String] = parameters
    
    let request = HTTPRequestBuilder(baseURL: baseURL, path: path, method: .get)
      .update(parameters: parameters)
      .update(headers: ["Authorization": "Bearer \(token)"])
      .build()
    
    guard let data = try? await HTTPServiceProvider().fetchData(for: request).get() else {
      return .failure(RepositoryError.invalidData)
    }
    
    guard let decoded = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
      return .failure(RepositoryError.invalidJSON)
    }
    
    if let result = decoded["result"] as? NewsDetailResponseDTO {
      return .success(NewsDetailMapper.map(result))
    } else {
      return .failure(NSError(domain: "bye", code: 1))
    }
  }
}

enum NewsMapper {
  static func map(_ response: [NewsResponseDTO]) -> [News] {
    response.map { dto in
      News(articleID: dto.articleID, title: dto.title, headLine: dto.headLine, press: dto.press, category: dto.category, thumbnail: dto.thumbnail, publishedDate: dto.publishedDate)
    }
  }
}

enum NewsDetailMapper {
  static func map(_ response: NewsDetailResponseDTO) -> NewsDetail {
    NewsDetail(title: response.title, content: response.content, images: response.images, press: response.press, category: response.category, comment: [], likeCount: response.likeCount, likedArticle: response.likedArticle)
  }
}

enum CommentMapper {
  static func map(_ response: [CommentResponseDTO]) -> [Comment] {
    response.map { dto in
      Comment(id: dto.commentId, content: dto.content, author: dto.nickName, createdAt: dto.createdDate)
    }
  }
}
