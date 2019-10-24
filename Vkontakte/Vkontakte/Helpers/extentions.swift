//
//  extentions.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 9/8/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit

extension UITableView {
    func update(deletions: [Int], insertions: [Int], modifications: [Int], section: Int = 0) {
        beginUpdates()
        deleteRows(at: deletions.map { IndexPath(row: $0, section: section) }, with: .automatic)
        insertRows(at: insertions.map { IndexPath(row: $0, section: section) }, with: .automatic)
        reloadRows(at: modifications.map { IndexPath(row: $0, section: section) }, with: .automatic)
        endUpdates()
    }
}




extension UIViewController {
    public func show(_ error: Error) {
        let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
}
