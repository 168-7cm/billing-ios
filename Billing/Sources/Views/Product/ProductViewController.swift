//
//  ProductViewController.swift
//  Billing
//
//  Created by kou yamamoto on 2021/05/08.
//

import UIKit
import Rswift

protocol ProductView: ViewBase {
    func updateProduct()

}

final class ProductViewController: ViewControllerBase {
    
    @IBOutlet private weak var productListTableView: UITableView!

    typealias Dependency = Dependencies
    struct Dependencies {
        let presenter: ProductPresenterType
    }

    private var presenter: ProductPresenterType?

    override func viewDidLoad() {
        productListTableView.delegate = self
        productListTableView.dataSource = self
        productListTableView.rowHeight = UITableView.automaticDimension
        self.presenter?.fetchProduct()
    }
}

extension ProductViewController: ProductView {

    func updateProduct() {
        self.productListTableView.reloadData()
    }
}

extension ProductViewController: ViewControllerInstantiable {

    static func instansiate() -> ProductViewController {
        return R.storyboard.product.product()!
    }

    func inject(with dependency: Dependencies) {
        self.presenter = dependency.presenter
    }
}

extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfProducts ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductCell
        guard let product = self.presenter?.product(forRow: indexPath.row) else { return UITableViewCell() }
        cell.configure(product: product)
        return cell
    }
}
