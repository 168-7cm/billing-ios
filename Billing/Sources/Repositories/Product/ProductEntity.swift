//
//  ProductEntity.swift
//  Billing
//
//  Created by kou yamamoto on 2021/05/08.
//

import Foundation

struct Product: Identifiable {
    var id: String
    var title: String
    var price: String
}

extension Product {

    static let allProduct: [Product] = [
        .apple,
        .peach,
        .kiwi,
        .mango
    ]

    static let apple = Product(id: "apple", title: "りんご", price: "100")
    static let peach = Product(id: "peach", title: "桃", price: "500")
    static let kiwi = Product(id: "kiwi", title: "キウイ", price: "1000")
    static let mango = Product(id: "mango", title: "マンゴー", price: "10000")
}
