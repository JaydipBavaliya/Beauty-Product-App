//
//  MainViewController.swift
//  makeUp Product
//
//  Created by Jaydip on 05/05/22.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var beautyProductLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        animation()
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.borderWidth = 2
        signUpButton.layer.borderColor = UIColor(red: 0.796, green: 0.412, blue: 0.463, alpha: 1).cgColor
    }
    func animation(){
        beautyProductLabel.text = ""

        var charIndex = 0.0
        let nameText = "B e a u t y   P r o d u c t"

        for letter in nameText{
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.beautyProductLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    @IBAction func logInButton(_ sender: UIButton) {
        print("Log in click")
        let logIn = self.storyboard? .instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
            navigationController?.pushViewController(logIn, animated: true)
    }
    @IBAction func signInButton(_ sender: Any) {
        print("Sign in click")
        let signIn = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        navigationController?.pushViewController(signIn, animated: true)
    }
}
