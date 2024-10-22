import Foundation

protocol NewsRepositoryType {
  func fetchNewsList() async -> Result<[News], Error>
}

struct NewsRepository: NewsRepositoryType {
  //MARK: - Properties
  
  
  //MARK: - Methods
  func fetchNewsList() async -> Result<[News], any Error> {
    //TODO: - 서비스로 연결
    let path = Bundle.main.path(forResource: "../NewsJsonDemo", ofType: "json") ?? ""
    let url = URL(filePath: path)
    let data = (try? Data(contentsOf: url)) ?? Data()
    guard
      let decoded = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    else { return .failure(NSError(domain: "fail", code: 1))}
    
    if let result = decoded["result"] as? [NewsResponseDTO] {
      return .success(NewsMapper.map(result))
    } else {
      return .failure(NSError(domain: "bye", code: 1))
    }
  }
}

enum NewsMapper {
  static func map(_ response: [NewsResponseDTO]) -> [News] {
    response.map { dto in
      News(id: dto.articleID, title: dto.title, content: dto.content, createdAt: dto.createdDate, press: dto.press, category: dto.category, comments: CommentMapper.map(dto.comments))
    }
  }
}

enum CommentMapper {
  static func map(_ response: [CommentResponseDTO]) -> [Comment] {
    response.map { dto in
      Comment(id: dto.commentId, content: dto.content, author: dto.nickName, createdAt: dto.createdDate)
    }
  }
}
