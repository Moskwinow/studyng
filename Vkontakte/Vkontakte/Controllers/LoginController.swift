//
//  ViewController.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 8/19/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var loginButn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
    }
    
    func animate() {
        self.loginButn.transform = CGAffineTransform(translationX: 0,
                                                     y: self.view.bounds.height * 0.2)
        UIView.animate(withDuration: 1,
                       delay: 0.1,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 7,
                       options: .curveEaseOut,
                       animations: {
                        
                        self.loginButn.transform = .identity
        },
                       completion: nil)
    }
    
}

