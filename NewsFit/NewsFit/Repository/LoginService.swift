import Foundation

final class LoginService {
  static let shared = LoginService()
  
  private init() {}
 
  func loginWithNaverOAuthURL() -> URL {
    // Login with Naver OAuth
    let clientID = Bundle.NAVER_OAUTH_CLIENT_ID
    let url = URL(string: "https://nid.naver.com/oauth2.0/authorize?client_id=\(clientID)&response_type=code&redirect_uri=NewsFit://login&state=state")!
    
    return url
  }
  func loginWithKaKaoOAuth() -> URL {
    // Login with Kakao OAuth
    let clientID = Bundle.KAKAO_OAUTH_CLIENT_ID
    let url = URL(string: "https://kauth.kakao.com/oauth/authorize?client_id=\(clientID)&redirect_uri=NewsFit://login&response_type=code")!
    
    return url
  }
  func loginWithGoogleOAuth() -> URL {
    // Login with Google OAuth
    let clientID = Bundle.GOOGLE_OAUTH_CLIENT_ID
    let url = URL(string: "https://accounts.google.com/o/oauth2/v2/auth?client_id=\(clientID)&redirect_uri=NewsFit://login&response_type=code&scope=email profile")!
    
    return url
  }
  
  func requestloginWithNaver(with code: String) async throws {
    let baseURL = Bundle.baseURL
    let path = "/member/oauth/naver"
    let request = HTTPRequestBuilder(baseURL: baseURL, path: path, method: .get)
      .update(parameters: ["code": code, "state": "state"])
      .build()
    
    let data = try await HTTPServiceProvider().fetchData(for: request).get()
    
    let decoded = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    let result = decoded["result"] as! [String: String]
    
    
    let accessToken = result["accessToken"]!
    await KeyChainManager.shared.addToken(type: .accessToken, value: accessToken)
    
    if let refreshToken = result["refreshToken"] {
      await KeyChainManager.shared.addToken(type: .refreshToken, value: refreshToken)
    }
  }
  func requestloginWithKakao(with code: String) async throws {
    let baseURL = Bundle.baseURL
    let path = "/member/oauth/kakao"
    let request = HTTPRequestBuilder(baseURL: baseURL, path: path, method: .get)
      .update(parameters: ["code": code, "redirect_uri": "NewsFit://login"])
      .build()
    
    let data = try await HTTPServiceProvider().fetchData(for: request).get()
    
    let decoded = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    let result = decoded["result"] as! [String: String]
    
    
    let accessToken = result["accessToken"]!
    await KeyChainManager.shared.addToken(type: .accessToken, value: accessToken)
    
    if let refreshToken = result["refreshToken"] {
      await KeyChainManager.shared.addToken(type: .refreshToken, value: refreshToken)
    }
  }
  func requestloginWithGoogle(with code: String) async throws {
    let baseURL = Bundle.baseURL
    let path = "/member/oauth/google"
    let request = HTTPRequestBuilder(baseURL: baseURL, path: path, method: .get)
      .update(parameters: ["code": code, "scope": "email profile", "redirect_uri": "NewsFit://login"])
      .build()
    
    let data = try await HTTPServiceProvider().fetchData(for: request).get()
    
    let decoded = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    let result = decoded["result"] as! [String: String]
    
    let accessToken = result["accessToken"]!
    await KeyChainManager.shared.addToken(type: .accessToken, value: accessToken)
    
    if let refreshToken = result["refreshToken"] {
      await KeyChainManager.shared.addToken(type: .refreshToken, value: refreshToken)
    }
  }
}


