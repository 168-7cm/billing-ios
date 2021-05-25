//
//  StoreKitManager.swift
//  Billing
//
//  Created by kou yamamoto on 2021/05/08.
//

import Foundation
import StoreKit

final class StoreKitManager: NSObject {

    typealias ProductResult = (Result<[SKProduct], Error>) -> ()

    // シングルトン設計
    static let shared = StoreKitManager()

    // 構成ファイルせ作成した課金アイテムIDを設定する
    private let itemIdentifiers: Set<String> = [
        "storekit.testing.item1",
        "storekit.testing.item2",
        "storekit.testing.item3",
    ]

    private var completion: ProductResult?

    func getProducts(_ completion: @escaping ProductResult) {
        self.completion = completion
        let request = SKProductsRequest(productIdentifiers: itemIdentifiers)
        request.delegate = self
        request.start()
    }
}

extension StoreKitManager: SKProductsRequestDelegate, SKRequestDelegate {

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("didFailWithError ", error)
    }

    func requestDidFinish(_ request: SKRequest) {
        print("request did finish")
    }
}
