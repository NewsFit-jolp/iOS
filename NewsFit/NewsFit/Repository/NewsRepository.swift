import Foundation

protocol NewsRepositoryType {
  func fetchNewsList(with queryParameters: [String: String]?) async -> Result<[News], Error>
  func fetchNewsDetail(id: Int) async -> Result<NewsDetail, Error>
}

struct NewsRepository: NewsRepositoryType {
  enum RepositoryError: Error {
    case invalidData
    case invalidJSON
    case invalidResponse
  }
  
  //MARK: - Property
  var decoder: JSONDecoder {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    formatter.locale = Locale(identifier: "ko_KR")
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(formatter)
    return decoder
  }
  
  //MARK: - Methods
  func fetchNewsList(with queryParameters: [String: String]?) async -> Result<[News], Error> {
    let baseURL = Bundle.baseURL
    let path = "/articles"
    let token = Bundle.token
    
    let request = HTTPRequestBuilder(baseURL: baseURL, path: path, method: .get)
      .update(parameters: queryParameters)
      .update(headers: ["Authorization": "Bearer \(token)"])
      .build()
    print(request)
    guard let data = try? await HTTPServiceProvider().fetchData(for: request).get() else {
      return .failure(RepositoryError.invalidData)
    }
    
    guard let decoded = try? decoder.decode(NetworkResponseDTO<[NewsResponseDTO]>.self, from: data) else {
      return .failure(RepositoryError.invalidJSON)
    }
    
    return .success(NewsMapper.map(decoded.result))
  }
  func fetchNewsDetail(id: Int) async -> Result<NewsDetail, Error> {
    let baseURL = Bundle.baseURL
    let path = "/articles/\(id)"
    let token = Bundle.token
    
    let request = HTTPRequestBuilder(baseURL: baseURL, path: path, method: .get)
      .update(headers: ["Authorization": "Bearer \(token)"])
      .build()
    
    guard let data = try? await HTTPServiceProvider().fetchData(for: request).get() else {
      return .failure(RepositoryError.invalidData)
    }
    
    guard let decoded = try? decoder.decode(NetworkResponseDTO<NewsDetailResponseDTO>.self, from: data) else {
      return .failure(RepositoryError.invalidJSON)
    }
    
    return .success(NewsDetailMapper.map(decoded.result))
  }
}

enum NewsMapper {
  static func map(_ response: [NewsResponseDTO]) -> [News] {
    response.map { dto in
      News(articleID: dto.articleId, title: dto.title, headLine: dto.headLine, press: dto.press, category: dto.category, thumbnail: dto.thumbnail, publishedDate: dto.publishDate)
    }
  }
}

enum NewsDetailMapper {
  static func map(_ response: NewsDetailResponseDTO) -> NewsDetail {
    NewsDetail(
      title: response.title,
      content: response.content,
      images: response.images,
      press: response.press,
      category: response.category,
      articleSource: response.articleSource,
      comment: [],
      likeCount: response.likeCount,
      likedArticle: response.likedArticle
    )
  }
}

enum CommentMapper {
  static func map(_ response: [CommentResponseDTO]) -> [Comment] {
    response.map { dto in
      Comment(id: dto.commentId, content: dto.content, author: dto.nickName, createdAt: dto.createdDate)
    }
  }
}
