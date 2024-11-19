import Foundation

enum HTTPMethod: String {
  case get
  case post
  case put
  case delete
  case patch
}

struct HTTPRequestBuilder {
  // MARK: - Property
  let scheme: String
  let baseURL: String
  let path: String
  let method: HTTPMethod
  let parameters: [String: String]?
  let headers: [String: String]?
  let body: Data?
  
  // MARK: - Initializer
  init(
    baseURL: String,
    path: String,
    method: HTTPMethod
  ) {
    self.scheme = "https"
    self.baseURL = baseURL
    self.path = path
    self.method = method
    self.parameters = nil
    self.headers = nil
    self.body = nil
  }
  private init(
    scheme: String = "https",
    baseURL: String,
    path: String,
    method: HTTPMethod,
    parameters: [String : String]? = nil,
    headers: [String : String]? = nil,
    body: Data? = nil
  ) {
    self.scheme = scheme
    self.baseURL = baseURL
    self.path = path
    self.method = method
    self.parameters = parameters
    self.headers = headers
    self.body = body
  }
  
  // MARK: - Method
  func build() -> URLRequest {
    var components: URLComponents = URLComponents()
    let queryItems: [URLQueryItem]? = parameters?.map(URLQueryItem.init)
    
    components.host = baseURL
    components.scheme = scheme
    components.path.append(path)
    components.queryItems = queryItems
    
    guard let url = components.url else { return .init(url: .init(filePath: "")) }
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.allHTTPHeaderFields = headers
    request.httpBody = body
    
    return request
  }
  func update(scheme: String) -> Self {
    return .init(scheme: scheme, baseURL: baseURL, path: path, method: method, parameters: parameters, headers: headers, body: body)
  }
  func update(baseURL: String) -> Self {
    return .init(scheme: scheme, baseURL: baseURL, path: path, method: method, parameters: parameters, headers: headers, body: body)
  }
  func update(path: String) -> Self {
    return .init(scheme: scheme, baseURL: baseURL, path: path, method: method, parameters: parameters, headers: headers, body: body)
  }
  func update(method: HTTPMethod) -> Self {
    return .init(scheme: scheme, baseURL: baseURL, path: path, method: method, parameters: parameters, headers: headers, body: body)
  }
  func update(parameters: [String: String]?) -> Self {
    return .init(scheme: scheme, baseURL: baseURL, path: path, method: method, parameters: parameters, headers: headers, body: body)
  }
  func update(headers: [String: String]?) -> Self {
    return .init(scheme: scheme, baseURL: baseURL, path: path, method: method, parameters: parameters, headers: headers, body: body)
  }
  func update(body: Data?) -> Self {
    return .init(scheme: scheme, baseURL: baseURL, path: path, method: method, parameters: parameters, headers: headers, body: body)
  }
}
