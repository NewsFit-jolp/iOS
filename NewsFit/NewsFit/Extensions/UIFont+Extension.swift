//
//  UIFont+Extension.swift
//  NewsFit
//
//  Created by 임정현 on 6/7/24.
//

import UIKit

extension UIFont {
    enum NF {
        static var button_default: UIFont {
            .init(name: NanumGothicFontName.bold, size: 16)!
        }
        static var button_small: UIFont {
            .init(name: NanumGothicFontName.bold, size: 14)!
        }
        
        static var textField_default: UIFont {
            .init(name: NanumGothicFontName.regular, size: 16)!
        }
        
        static var title_large: UIFont {
            .init(name: NanumGothicFontName.extraBold, size: 30)!
        }
        static var title_middle: UIFont {
            .init(name: NanumGothicFontName.bold, size: 20)!
        }
        
        static var text_default: UIFont {
            .init(name: NanumGothicFontName.regular, size: 16)!
        }
    }
}

