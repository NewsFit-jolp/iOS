import Foundation

protocol NewsRepositoryType {
  func fetchNewsList(with queryParameters: [String: String]?) async -> Result<[News], Error>
  func fetchRecommendNewsList(with queryParameters: [String: String]?) async -> Result<[News], Error>
  func fetchHeadLineList() async -> Result<[News], Error>
  func fetchNewsDetail(id: Int) async -> Result<NewsDetail, Error>
  func postComment(id: Int, content: String) async -> Result<Comment, Error>
  func deleteComment(newsID: Int, commentID: Int) async -> Result<Void, Error>
  func disLikeNews(id: Int) async -> Result<Void, Error>
  func likeNews(id: Int) async -> Result<Void, Error>
}

struct NewsRepository: NewsRepositoryType {
  enum RepositoryError: Error {
    case invalidData
    case invalidJSON
    case invalidResponse
  }
  
  //MARK: - Property
  var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .custom { decoder -> Date in
      let container = try decoder.singleValueContainer()
      let dateString = try container.decode(String.self)
      
      // 나노초를 포함한 날짜 포맷 시도
      let formatterWithNano = DateFormatter()
      formatterWithNano.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSS"
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
      
      // 분 단위까지만 있는 경우
      let formatterWithoutSecond = DateFormatter()
      formatterWithoutSecond.dateFormat = "yyyy-MM-dd'T'HH:mm"
      formatterWithoutSecond.locale = Locale(identifier: "ko_KR")
      
      if let date = formatterWithoutSecond.date(from: dateString) {
        return date
      }
      
      throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format: \(dateString)")
    }
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
    guard let data = try? await HTTPServiceProvider().fetchData(for: request).get() else {
      return .failure(RepositoryError.invalidData)
    }
    
    guard let decoded = try? decoder.decode(NetworkResponseDTO<[NewsResponseDTO]>.self, from: data) else {
      return .failure(RepositoryError.invalidJSON)
    }
    
    return .success(NewsMapper.map(decoded.result))
  }
  func fetchRecommendNewsList(with queryParameters: [String: String]?) async -> Result<[News], Error> {
    let baseURL = Bundle.baseURL
    let path = "/articles/recommend"
    let token = Bundle.token
    
    let request = HTTPRequestBuilder(baseURL: baseURL, path: path, method: .get)
      .update(parameters: queryParameters)
      .update(headers: ["Authorization": "Bearer \(token)"])
      .build()
    guard let data = try? await HTTPServiceProvider().fetchData(for: request).get() else {
      return .failure(RepositoryError.invalidData)
    }
    
    guard let decoded = try? decoder.decode(NetworkPagingResponseDTO<[NewsResponseDTO]>.self, from: data) else {
      return .failure(RepositoryError.invalidJSON)
    }
    
    return .success(NewsMapper.map(decoded.result))
  }
  func fetchHeadLineList() async -> Result<[News], Error> {
    let baseURL = Bundle.baseURL
    let path = "/articles/headLine"
    let token = Bundle.token
    
    let request = HTTPRequestBuilder(baseURL: baseURL, path: path, method: .get)
      .update(headers: ["Authorization": "Bearer \(token)"])
      .build()
    
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
  func postComment(id: Int, content: String) async -> Result<Comment, any Error> {
    guard !content.isEmpty else {
      return .failure(RepositoryError.invalidData)
    }
    
    let baseURL = Bundle.baseURL
    let path = "/articles/\(id)/comments"
    let token = Bundle.token
    
    let body = try? JSONSerialization.data(withJSONObject: ["comment": content])
    
    let request = HTTPRequestBuilder(baseURL: baseURL, path: path, method: .post)
      .update(headers: ["Authorization": "Bearer \(token)",
                        "Content-Type": "application/json"])
      .update(body: body)
      .build()
    
    guard let data = try? await HTTPServiceProvider().fetchData(for: request).get() else {
      return .failure(RepositoryError.invalidData)
    }
    
    guard let decoded = try? decoder.decode(NetworkResponseDTO<CommentResponseDTO>.self, from: data) else {
      return .failure(RepositoryError.invalidJSON)
    }
    
    return .success(CommentMapper.map(decoded.result))
  }
  func deleteComment(newsID: Int, commentID: Int) async -> Result<Void, Error> {
    let baseURL = Bundle.baseURL
    let path = "/articles/\(newsID)/comments/\(commentID)"
    let token = Bundle.token
    
    let request = HTTPRequestBuilder(baseURL: baseURL, path: path, method: .delete)
      .update(headers: ["Authorization": "Bearer \(token)"])
      .build()
    
    guard let _ = try? await HTTPServiceProvider().fetchData(for: request).get() else {
      return .failure(RepositoryError.invalidData)
    }
    
    return .success(())
  }
  func disLikeNews(id: Int) async -> Result<Void, Error> {
    let baseURL = Bundle.baseURL
    let path = "/articles/\(id)/likes"
    let token = Bundle.token
    
    let request = HTTPRequestBuilder(baseURL: baseURL, path: path, method: .delete)
      .update(headers: ["Authorization": "Bearer \(token)"])
      .build()
    
    guard let _ = try? await HTTPServiceProvider().fetchData(for: request).get() else {
      return .failure(RepositoryError.invalidData)
    }
    
    return .success(())
  }
  func likeNews(id: Int) async -> Result<Void, Error> {
    let baseURL = Bundle.baseURL
    let path = "/articles/\(id)/likes"
    let token = Bundle.token
    
    let request = HTTPRequestBuilder(baseURL: baseURL, path: path, method: .post)
      .update(headers: ["Authorization": "Bearer \(token)"])
      .build()
    
    guard let _ = try? await HTTPServiceProvider().fetchData(for: request).get() else {
      return .failure(RepositoryError.invalidData)
    }
    
    return .success(())
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
        comment: response.comment.map(CommentMapper.map),
        likeCount: response.likeCount,
        likedArticle: response.likedArticle
      )
    }
  }
}

enum CommentMapper {
  static func map(_ response: [CommentResponseDTO]) -> [Comment] {
    response.map { dto in
      Comment(id: dto.commentId, content: dto.content, author: dto.nickName, createdAt: dto.createdDate, isDeletable: dto.isMyComment)
    }
  }
  static func map(_ response: CommentResponseDTO) -> Comment {
    Comment(id: response.commentId, content: response.content, author: response.nickName, createdAt: response.createdDate, isDeletable: response.isMyComment)
  }
}
