//
//  ProductPresenter.swift
//  Billing
//
//  Created by kou yamamoto on 2021/05/08.
//

import Foundation

protocol ProductPresenterType {
    var numberOfProducts: Int { get }
    func product(forRow row: Int) -> Product?
    func didSelectedRow(at indexPath: IndexPath)
    func fetchProduct()
}

final class ProductPresenter {

    typealias Dependency = Dependencies
    struct Dependencies {
        let view: ProductView
    }

    private weak var view: ProductView?
    private var products = [Product]()
}

extension ProductPresenter: PresenterInstantiable {
    
    func inject(with dependency: Dependencies) -> Self {
        self.view = dependency.view
        return self
    }
}

extension ProductPresenter: ProductPresenterType {
    var numberOfProducts: Int {
        products.count
    }

    func product(forRow row: Int) -> Product? {
        guard row < products.count else { return nil }
        return products[row]
    }


    func didSelectedRow(at indexPath: IndexPath) {
        self.view?.showToast(message: "didselected\(indexPath)")
    }
    
    func fetchProduct() {
        StoreKitManager.shared.getProducts { [weak self] result in
            switch result {
            case .success(let products):
                let products = products.map { return Product(product: $0, id: $0.productIdentifier) }
                self?.products += products
                DispatchQueue.main.async { self?.view?.updateProduct() }
            case .failure(let error):
                DispatchQueue.main.async { self?.view?.showToast(message: error.localizedDescription) }
            }
        }
    }
}
