//
//  ProductCell.swift
//  Billing
//
//  Created by kou yamamoto on 2021/05/26.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!

    func configure(product: Product) {
        productNameLabel.text = product.product.localizedTitle
        productDescriptionLabel.text = product.product.localizedDescription
        productPriceLabel.text = product.price
    }
}
