//
//  StoreKitManager.swift
//  Billing
//
//  Created by kou yamamoto on 2021/05/08.
//

import Foundation
import StoreKit

typealias ProductResult = (Result<[SKProduct], Error>) -> ()

final class StoreKitManager: NSObject {

    static let shared = StoreKitManager()

    private let productIdentifiers: Set<String> = ["comsumable.item"]

    private var completion: ProductResult?

    func getProducts(_ completion: @escaping ProductResult) {
        self.completion = completion
        // AppStoreからproductIdentifiersに基づいたアイテム情報を取得
        let request = SKProductsRequest(productIdentifiers: productIdentifiers)
        request.delegate = self
        request.start()
    }

    func purchase(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        }
    }

    func addPaymentQueue() {
        SKPaymentQueue.default().add(self)
    }

    func removePaymentQueue() {
        SKPaymentQueue.default().remove(self)
    }
}

extension StoreKitManager: SKProductsRequestDelegate, SKRequestDelegate {

    // アプリが要求した製品情報を含むAppStoreの応答を受け入れます。
    // request -> AppStoreに送信された製品リクエスト。
    // response -> 製品リストに関する詳細情報。
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        completion?(.success(response.products))
    }

    // リクエストの実行に失敗したことをデリゲートに通知します。
    func request(_ request: SKRequest, didFailWithError error: Error) {
        completion?(.failure(error))
    }

    // 要求が完了したことをデリゲートに通知します。
    func requestDidFinish(_ request: SKRequest) {
        print("request did finish")
    }
}

extension StoreKitManager: SKPaymentTransactionObserver {

    // 1つ以上のトランザクションが更新されたことをオブザーバーに通知します。
    // queue -> トランザクションを更新した支払いキュー。
    // transactions -> 更新されたトランザクションの配列。
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

    }

    // トランザクションの復元中にエラーが発生したことをオブザーバーに通知します。
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("restoreCompletedTransactionsFailedWithError ", error)
    }

    // 支払いキューが復元されたトランザクションの送信を終了したことをオブザーバーに通知します。
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("transactions finished")
    }
}
