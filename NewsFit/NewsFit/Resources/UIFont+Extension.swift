import SwiftUI
public enum NanumGothicFontName {
  private static let familiy: String = "NanumGothic"
  static var regular: String {
    Self.familiy + ""
  }
  static var bold: String {
    Self.familiy + "Bold"
  }
  static var extraBold: String {
    Self.familiy + "ExtraBold"
  }
  static var light: String {
    Self.familiy + "Light"
  }
}
extension UIFont {
  enum NF {
    static var button_default: UIFont {
      let font = UIFont(name: NanumGothicFontName.bold, size: 16)!
      return UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
    }
    static var button_small: UIFont {
      let font = UIFont(name: NanumGothicFontName.bold, size: 14)!
      return UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
    }
    static var textField_default: UIFont {
      let font = UIFont(name: NanumGothicFontName.regular, size: 16)!
      return UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
    }
    static var title_large: UIFont {
      let font = UIFont(name: NanumGothicFontName.extraBold, size: 30)!
      return UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
    }
    static var title_middle: UIFont {
      let font = UIFont(name: NanumGothicFontName.bold, size: 20)!
      return UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
    }
    static var text_default: UIFont {
      let font = UIFont(name: NanumGothicFontName.regular, size: 16)!
      return UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
    }
  }
}

//extension Font {
//  enum NF {
//    static var button_default: Font {
//      return Font.custom(NanumGothicFontName.bold, size: 16, relativeTo: .headline)
//    }
//    static var button_small: Font {
//      let font = UIFont(name: NanumGothicFontName.bold, size: 14)!
//      return UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
//    }
//    static var textField_default: Font {
//      let font = UIFont(name: NanumGothicFontName.regular, size: 16)!
//      return UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
//    }
//    static var title_large: Font {
//      let font = UIFont(name: NanumGothicFontName.extraBold, size: 30)!
//      return UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
//    }
//    static var title_middle: Font {
//      let font = UIFont(name: NanumGothicFontName.bold, size: 20)!
//      return UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
//    }
//    static var text_default: Font {
//      let font = UIFont(name: NanumGothicFontName.regular, size: 16)!
//      return UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
//    }
//  }
//}
