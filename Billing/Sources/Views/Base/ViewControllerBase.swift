//
//  ViewControllerBase.swift
//  Billing
//
//  Created by kou yamamoto on 2021/05/08.
//

import UIKit
import Toast

class ViewControllerBase: UIViewController {

}
extension ViewControllerBase: ViewBase {
    
    func showToast(message: String) {
        self.view.makeToast(message, duration: 2.0, position: .bottom)
    }
}
