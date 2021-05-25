//
//  ProductPresenter.swift
//  Billing
//
//  Created by kou yamamoto on 2021/05/08.
//

import Foundation

protocol ProductPresenterType {

}

final class ProductPresenter {

    typealias Dependency = Dependencies
    struct Dependencies {
        let view: ProductView
    }

    private weak var view: ProductView?
}

extension ProductPresenter: PresenterInstantiable {
    
    func inject(with dependency: Dependencies) -> Self {
        self.view = dependency.view
        return self
    }
}
