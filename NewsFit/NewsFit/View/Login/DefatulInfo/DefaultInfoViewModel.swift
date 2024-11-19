import Foundation

final class DefaultInfoViewModel: ObservableObject {
  @Published var name: String = ""
  @Published var email: String = ""
  @Published var phoneNumber: String = ""
  
  func saveInfo() {
    // Save user info
  }
  func isValid() -> Bool {
    return !name.isEmpty && validateEmail() && validatePhoneNumber()
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
