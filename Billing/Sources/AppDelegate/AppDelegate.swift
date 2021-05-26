//
//  AppDelegate.swift
//  Billing
//
//  Created by kou yamamoto on 2021/05/06.
//

import Foundation
import UIKit
import StoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        StoreKitManager.shared.addPaymentQueue()

        let viewController = ProductViewController.instansiate()
        let presenter = ProductPresenter().inject(with: ProductPresenter.Dependency(view: viewController))
        viewController.inject(with: ProductViewController.Dependency(presenter: presenter))
        self.window?.rootViewController = viewController
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        StoreKitManager.shared.removePaymentQueue()
    }
}
