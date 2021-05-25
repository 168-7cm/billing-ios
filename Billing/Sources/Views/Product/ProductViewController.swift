//
//  ProductViewController.swift
//  Billing
//
//  Created by kou yamamoto on 2021/05/08.
//

import UIKit

protocol ProductView: ViewBase {

}

final class ProductViewController: ViewControllerBase {
    
    @IBOutlet private weak var productListTableView: UITableView!

    override func viewDidLoad() {
        productListTableView.delegate = self
        productListTableView.dataSource = self
    }
}

extension ProductViewController: ProductView {

}

extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "aa"
        return cell
    }
}
