//
//  Product.swift
//  Billing
//
//  Created by kou yamamoto on 2021/05/25.
//

import Foundation
import StoreKit

struct Product {
    let product: SKProduct
    let id: String
    var price: String { formatPrice(product: product) }

    func formatPrice(product: SKProduct) -> String {
        let formatter = NumberFormatter()
        formatter.formatterBehavior = .behavior10_4
        formatter.numberStyle = .currency
        formatter.locale = product.priceLocale
        return formatter.string(from: product.price)!
    }
}
