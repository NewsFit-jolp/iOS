import Foundation

final class AdditionalInfoViewModel: ObservableObject {
  @Published var genderIndex: Int = 0
  @Published var birthDay: String = ""
  var genderString: String {
    return genderIndex == 0 ? "MALE" : "FEMALE"
  }
  
  func saveInfo() {
    // Save additional info
    Task {
      let userInfo = await UserService.shared.fetchInformation()
      guard case .success(let userInfo) = userInfo else { return }
      
      _ = await UserService.shared.updateInformation(
        user: .init(
          name: userInfo.nickname,
          email: userInfo.email,
          phone: userInfo.phone ?? "",
          gender: genderString,
          birth: birthDay
        )
      )
    }
  }
  func isValid() -> Bool {
    return validateBirthDay()
  }
  func fetchUserInfo() {
    Task {
      let userInfo = await UserService.shared.fetchInformation()
      guard case .success(let userInfo) = userInfo else { return }
      genderIndex = userInfo.gender?.lowercased() == "male" ? 0 : 1
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy/MM/dd"
      birthDay = formatter.string(from: userInfo.birth ?? Date())
    }
  }
  private func validateBirthDay() -> Bool {
    // Validate birth day
    // Format: yyyy/MM/dd (e.g. 1990/01/01)
    // constraint: MM should be between 01 and 12, dd should be between 01 and 31
    let regex = #"^\d{4}/(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])$"# // yyyy/MM/dd
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    
    return predicate.evaluate(with: birthDay)
  }
}
