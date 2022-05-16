//
//  LogInViewController.swift
//  makeUp Product
//
//  Created by Jaydip on 05/05/22.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
//        navigationController?.isNavigationBarHidden = true
    }
    @IBAction func createAccountButton(_ sender: Any) {
        let register = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        navigationController?.pushViewController(register, animated: true)
    }
    @IBAction func loginButton(_ sender: Any) {
        if usernameTextField.text == "" && passwordTextField.text == ""{
            showAlert(title: "Ooops!", message: "please enter username and password")
            
        }
        if usernameTextField.text == ""{
            showAlert(title: "Error", message: "Please enter username")
        }
        if passwordTextField.text == ""{
            showAlert(title: "Password", message: "Please enter password")
        }
        else{
            let next = self.storyboard? .instantiateViewController(withIdentifier: "ViewController") as! HomeViewController
            navigationController?.pushViewController(next, animated: true)
        }
    }
    func showAlert(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
       
    }
}
