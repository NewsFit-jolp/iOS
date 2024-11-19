import Foundation

final class AdditionalInfoViewModel: ObservableObject {
  @Published var genderIndex: Int = 0
  @Published var birthDay: String = ""
  
  func saveInfo() {
    // Save additional info
  }
  func isValid() -> Bool {
    return validateBirthDay()
  }
  private func validateBirthDay() -> Bool {
    // Validate birth day
    // Format: yyyy/MM/dd
    let regex = "^\\d{4}/\\d{2}/\\d{2}$"
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    
    return predicate.evaluate(with: birthDay)
  }
}
