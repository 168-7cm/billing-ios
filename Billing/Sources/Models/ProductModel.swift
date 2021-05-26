//
//  ProductModel.swift
//  Billing
//
//  Created by kou yamamoto on 2021/05/25.
//

import Foundation

protocol ProductModelType {
    func fetchProduct()
}

final class ProductModel: ProductModelType {

    func fetchProduct() {
        StoreKitManager.shared.getProducts { [weak self] result in
            switch result {
            case .success(let product):
                print(product)
            case .failure(let error):
                print(error)
            }
        }
    }
}
