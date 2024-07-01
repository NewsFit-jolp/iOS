//
//  UIColor+Extension.swift
//  NewsFit
//
//  Created by 임정현 on 6/7/24.
//

import UIKit

// MARK: - About Custom colors
extension UIColor {
    enum NF {
        static var background_white: UIColor {
            .init(named: "background_white")!
        }
        static var background_gray: UIColor {
            .init(named: "background_gray")!
        }
        static var button_cancel_clicked: UIColor {
            .init(named: "button-cancel-clicked")!
        }
        static var button_cancel_disabled: UIColor {
            .init(named: "button-cancel-disabled")!
        }
        static var button_cancel: UIColor {
            .init(named: "button-cancel")!
        }
        static var button_default_clicked: UIColor {
            .init(named: "button-default-clicked")!
        }
        static var button_default_disabled: UIColor {
            .init(named: "button-default-disabled")!
        }
        static var button_default: UIColor {
            .init(named: "button-default")!
        }
        static var green: UIColor {
            .init(named: "green")!
        }
        static var text_dark: UIColor {
            .init(named: "text_dark")!
        }
        static var text_gray: UIColor {
            .init(named: "text_gray")!
        }
        static var text_white: UIColor {
            .init(named: "text_white")!
        }
        static var border_gray: UIColor {
            .init(named: "border_gray")!
        }
    }
}

//MARK: - UIColors for LoginView
extension UIColor.NF {
    static var naver_login_background: UIColor {
        return .init(named: "naver_login_background")!
    }
    static var kakao_login_background: UIColor {
        return .init(named: "kakao_login_background")!
    }
    static var apple_login_background: UIColor {
        return .init(named: "apple_login_background")!
    }
}
