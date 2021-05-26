////
////  ProductViewController.swift
////  Billing
////
////  Created by kou yamamoto on 2021/05/06.
////
//
//import StoreKit
//import UIKit
//
//final class ProductsViewController: UIViewController {
//
//    private var models = [SKProduct]()
//
//   
//
//    override func viewDidLoad() {
//        SKPaymentQueue.default().add(self)
//        setupTableView()
//        fetchProducts()
//    }
//
//    private func setupTableView() {
//        tableview.delegate = self
//        tableview.dataSource = self
//    }
//
//    enum Product: String, CaseIterable {
//        case removeAds = "com.myapp.removeAds"
//        case getGems = "com.myapp.gem"
//        case unlockEverything = "com.myapp.everything"
//    }
//
//    private func fetchProducts() {
//        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap({ $0.rawValue })))
//        request.delegate = self
//        request.start()
//    }
//}
//
//extension ProductsViewController: SKPaymentTransactionObserver {
//
//    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//        transactions.forEach ({
//            switch $0.transactionState {
//            case .purchasing:
//                print("purchasing")
//            case .purchased:
//                print("purchased")
//                SKPaymentQueue.default().finishTransaction($0)
//            case .failed:
//                print("failed")
//                SKPaymentQueue.default().finishTransaction($0)
//            case .restored:
//                print("restored")
//            case .deferred:
//                print("deferred")
//            @unknown default:
//                break
//            }
//        })
//    }
//}
//
//extension ProductsViewController: SKProductsRequestDelegate {
//
//    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        DispatchQueue.main.async {
//            self.models = response.products
//            self.tableview.reloadData()
//        }
//    }
//}
//
//extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return models.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let product = models[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "\(product.localizedTitle):\(product.localizedDescription) - \(product.priceLocale.currencySymbol)\(product.price)"
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableview.deselectRow(at: indexPath, animated: true)
//        let payment = SKPayment(product: models[indexPath.row])
//        SKPaymentQueue.default().add(payment)
//    }
//}
