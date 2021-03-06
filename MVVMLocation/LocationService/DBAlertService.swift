//
//  DBAlertService.swift
//  MVVMLocation
//
//  Created by Vinu Murugan on 06/03/21.
//

import Foundation
import UIKit

class DBAlertService {
    static func showAlert(WithMessage message:String, WithMessagType type:JWMessageType = .info,WithOkButtionCompletion completion:@escaping()->(Void)){
        let alert = UIAlertController(title: type.rawValue, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 1.0
        alert.view.layer.cornerRadius = 15
        let alertOkAction = UIAlertAction.init(title: "Ok", style: .default) { (alertAction) in
            completion()
        }
        alert.addAction(alertOkAction)
        DispatchQueue.main.async {
            getRootView().present(alert, animated: true) {

            }
        }
    }
    
    static func getRootView() -> UIViewController {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        return keyWindow?.rootViewController ?? UIViewController()
    }

}

enum JWMessageType:String {
    case info = "Info!"
    case error = "Error!"
    case sucsess = "Success!"
    case warning = "Warning!"
}
