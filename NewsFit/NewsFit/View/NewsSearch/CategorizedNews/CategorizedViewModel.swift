import Foundation

struct CategorizedViewModel {
  var category: String
  var news: [News]
  var attributedCategory: AttributedString {
    var attributedString = AttributedString(category)
    attributedString.foregroundColor = .nfGreen
    
    return attributedString
  }
}
