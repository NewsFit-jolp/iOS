import Foundation

protocol NetworkService {
  func fetchData(for request: URLRequest) async -> Result<Data, Error>
}

struct HTTPServiceProvider: NetworkService {
  enum HTTPError: Error {
    case invalidResponse
    case requestFailed(statusCode: Int)
  }
  
  func fetchData(for request: URLRequest) async -> Result<Data, Error> {
    guard let (data, response) = try? await URLSession.shared.data(for: request) else {
      return .failure(HTTPError.invalidResponse)
    }
    
    guard let httpURLResponse = response as? HTTPURLResponse else {
      return .failure(HTTPError.invalidResponse)
    }
    
    guard 200..<300 ~= httpURLResponse.statusCode else {
      return .failure(HTTPError.requestFailed(statusCode: httpURLResponse.statusCode))
    }
    
    return .success(data)
  }
}
