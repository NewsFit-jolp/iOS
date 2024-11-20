import Foundation
import OSLog

final class DefaultInfoViewModel: ObservableObject {
  @Published var name: String = ""
  @Published var email: String = ""
  @Published var phoneNumber: String = ""
  
  func saveInfo() {
    // Save user info
    Task {
      let userInfo = await UserService.shared.fetchInformation()
      guard case .success(let userInfo) = userInfo else { return }
      
      _ = await UserService.shared.updateInformation(
        user: .init(
          name: name,
          email: userInfo.email,
          phone: phoneNumber,
          gender: userInfo.gender,
          birth: userInfo.birth
        )
      )
    }
  }
  func isValid() -> Bool {
    return !name.isEmpty && validateEmail() && validatePhoneNumber()
  }
  func fetchInformation() {
    // Fetch user information
    Task { [weak self] in
      let result = await UserService.shared.fetchInformation()
      switch result {
      case .success(let success):
        self?.name = success.nickname
        self?.email = success.email
        self?.phoneNumber = success.phone ?? ""
      case .failure(let failure):
        Logger().error("Failed to fetch user information: \(failure)")
      }
    }
  }
  private func validateEmail() -> Bool {
    // Validate email
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    
    return predicate.evaluate(with: email)
  }
  private func validatePhoneNumber() -> Bool {
    // Validate phone number
    let regex = "^\\d{3}-\\d{3,4}-\\d{4}$"
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    
    return predicate.evaluate(with: phoneNumber)
  }
}
