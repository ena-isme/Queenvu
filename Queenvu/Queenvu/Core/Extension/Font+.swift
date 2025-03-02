//
//  Font+.swift
//  Queenvu
//
//  Created by 신지원 on 3/2/25.
//

import UIKit

extension UIFont {
    static func normal(size: CGFloat) -> UIFont {
        return UIFont(name: "PFStardust", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "PFStardustBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    static func extraBold(size: CGFloat) -> UIFont {
        return UIFont(name: "PFStardustExtraBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }
}
