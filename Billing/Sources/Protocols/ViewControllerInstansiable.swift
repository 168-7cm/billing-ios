//
//  ViewControllerInstansiable.swift
//  Billing
//
//  Created by kou yamamoto on 2021/05/08.
//

import Foundation

// ViewControllerに依存性を設定するためのプロトコル
protocol ViewControllerInstantiable: AnyObject {
    static func instansiate() -> Self
    associatedtype Dependency
    func inject(with dependency: Dependency)
}
