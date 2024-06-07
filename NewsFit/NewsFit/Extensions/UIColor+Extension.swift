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
            .init(named: "background1")!
        }
        static var background_gray: UIColor {
            .init(named: "background2")!
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
            .init(named: "text_dark1")!
        }
        static var text_gray: UIColor {
            .init(named: "text_dark2")!
        }
    }
}
