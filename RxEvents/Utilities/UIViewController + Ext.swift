//
//  UIViewController + Ext.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentSafariVC(with path: String) {
        guard let url = URL(string: path) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = UIColor.main
        present(safariVC, animated: true)
    }
    
    func presentAlert(message: String = "", title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
