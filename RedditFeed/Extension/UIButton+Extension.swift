//
//  UIButton + Extension.swift
//  RedditFeed
//
//  Created by Erickson Philip Rathina Pandi on 9/11/21.
//

import Foundation
import UIKit
extension UIButton {
    func ButtonWithTrailingImage(){
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        imageView?.contentMode = .center
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
    }
    
    func applyStyle(image:UIImage,title:String){
        let image = image.withRenderingMode(.alwaysTemplate)
        setImage(image, for: .normal)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 21)
        tintColor = .lightGray
    }
}
