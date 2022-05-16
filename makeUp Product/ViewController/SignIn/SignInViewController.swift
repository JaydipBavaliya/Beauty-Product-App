//
//  SignInViewController.swift
//  makeUp Product
//
//  Created by Jaydip on 05/05/22.
//

import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func signInButton(_ sender: Any) {
        let register = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! HomeViewController
        navigationController?.pushViewController(register, animated: true)
    }
}
