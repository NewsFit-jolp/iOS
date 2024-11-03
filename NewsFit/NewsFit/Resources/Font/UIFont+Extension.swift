import SwiftUI
public enum NanumGothicFontName {
  private static let familiy: String = "NanumGothicOTF"
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
      return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }
    static var button_small: UIFont {
      let font = UIFont(name: NanumGothicFontName.bold, size: 14)!
      return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }
    static var textField_default: UIFont {
      let font = UIFont(name: NanumGothicFontName.regular, size: 16)!
      return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }
    static var title_large: UIFont {
      let font = UIFont(name: NanumGothicFontName.extraBold, size: 30)!
      return UIFontMetrics(forTextStyle: .title1).scaledFont(for: font)
    }
    static var title_middle: UIFont {
      let font = UIFont(name: NanumGothicFontName.bold, size: 20)!
      return UIFontMetrics(forTextStyle: .title2).scaledFont(for: font)
    }
    static var title_headline: UIFont {
      let font = UIFont(name: NanumGothicFontName.bold, size: 18)!
      return UIFontMetrics(forTextStyle: .title3).scaledFont(for: font)
    }
    static var text_headline: UIFont {
      let font = UIFont(name: NanumGothicFontName.bold, size: 12)!
      return UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: font)
    }
    static var text_sub: UIFont {
      let font = UIFont(name: NanumGothicFontName.regular, size: 12)!
      return UIFontMetrics(forTextStyle: .caption1).scaledFont(for: font)
    }
    static var text_default: UIFont {
      let font = UIFont(name: NanumGothicFontName.regular, size: 16)!
      return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }
    static var text_bold: UIFont {
      let font = UIFont(name: NanumGothicFontName.bold, size: 16)!
      return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }
    static var text_nav: UIFont {
      let font = UIFont(name: NanumGothicFontName.regular, size: 10)!
      return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }
  }
}

extension Font {
  enum NF {
    static var button_default: Font {
      return Font.custom(NanumGothicFontName.bold, size: 16, relativeTo: .body)
    }
    static var button_small: Font {
      return Font.custom(NanumGothicFontName.bold, size: 14, relativeTo: .body)
    }
    static var textField_default: Font {
      return Font.custom(NanumGothicFontName.regular, size: 16, relativeTo: .body)
    }
    static var title_large: Font {
      return Font.custom(NanumGothicFontName.extraBold, size: 30, relativeTo: .title)
    }
    static var title_middle: Font {
      return Font.custom(NanumGothicFontName.bold, size: 20, relativeTo: .title2)
    }
    static var title_headline: Font {
      return Font.custom(NanumGothicFontName.bold, size: 18, relativeTo: .title3)
    }
    static var text_headline: Font {
      return Font.custom(NanumGothicFontName.bold, size: 12, relativeTo: .subheadline)
    }
    static var text_sub: Font {
      return Font.custom(NanumGothicFontName.regular, size: 12, relativeTo: .caption)
    }
    static var text_default: Font {
      return Font.custom(NanumGothicFontName.regular, size: 16, relativeTo: .body)
    }
    static var text_bold: Font {
      return Font.custom(NanumGothicFontName.bold, size: 16, relativeTo: .body)
    }
    static var text_nav: Font {
      return Font.custom(NanumGothicFontName.regular, size: 10, relativeTo: .body)
    }
  }
}
