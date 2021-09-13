//
//  UItableView+Extension.swift
//  RedditFeed
//
//  Created by Erickson Philip Rathina Pandi on 9/13/21.
//

import Foundation
import UIKit
extension UITableView {
    func showSpinnerView() {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0),
                               width: self.bounds.width, height: CGFloat(44))
        
        self.tableFooterView = spinner
        self.tableFooterView?.isHidden = false
    }
    
    func hideSpinnerView() {
        self.tableFooterView = UIView()
        self.tableFooterView?.isHidden = true
    }
}
