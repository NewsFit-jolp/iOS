import Foundation

actor KeyChainManager {
  enum TokenType: String {
    case refreshToken = "RefreshToken"
    case accessToken = "AccessToken"
  }
  
  static let shared = KeyChainManager()
  
  private init() {}
    
  func addToken(type: TokenType, value: String) {
    guard let valueData = value.data(using: .utf8) else { return }
    
    let addQuery: [CFString: Any] = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: type.rawValue,
      kSecValueData: valueData
    ]

    let status = SecItemAdd(addQuery as CFDictionary, nil)
    if status == errSecDuplicateItem {
      update(type: type, token: value)
    }
  }
  
  func token(type: TokenType) -> String? {
    let searchQuery: [CFString: Any] = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: type.rawValue,
      kSecReturnAttributes: true,
      kSecReturnData: true
    ]
    
    var keyChainItem: CFTypeRef?
    let status = SecItemCopyMatching(searchQuery as CFDictionary, &keyChainItem)
    guard
      status == errSecSuccess,
      let item = keyChainItem as? [CFString: Any],
      let token = item[kSecValueData] as? Data
    else { return nil }
    
    return String(data: token, encoding: .utf8)
  }
  
  func update(type: TokenType, token: String) {
    guard let tokenData = token.data(using: .utf8) else { return }
    
    let searchQuery: [CFString: Any] = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: type.rawValue
    ]
      
    let updateQuery: [CFString: Any] = [
      kSecValueData: tokenData
    ]
    
    SecItemUpdate(searchQuery as CFDictionary, updateQuery as CFDictionary)
  }
  
  func remove(type: TokenType) {
    let searchQuery: [CFString: Any] = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: type.rawValue
    ]
    
    SecItemDelete(searchQuery as CFDictionary)
  }
}
