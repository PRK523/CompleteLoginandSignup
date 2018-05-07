//
//  SignInViewController.swift
//  CompleteLoginandSignup
//
//  Created by Pranoti Kulkarni on 4/28/18.
//  Copyright © 2018 Pranoti Kulkarni. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    
    @IBOutlet weak var emailAddress: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButton(_ sender: Any) {
        if emailAddress.text == "" || password.text == ""{
            displayAlert(title: "Missing Credentials", message: "Please provide valid credentials")
        }else{
            if let email = emailAddress.text{
                if let password = password.text {
                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                        if error !=  nil{
                            self.displayAlert(title: "Error", message: error!.localizedDescription)
                        } else {
                            print("Login successfull...")
                            self.performSegue(withIdentifier: "nextScreen", sender: nil)
                        }
                    })
                    
                }
            }
        }
    }
    
    @IBAction func registerNewAcctButton(_ sender: Any) {
        let registerView = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.present(registerView, animated: true, completion: nil)
    }
    
    
    @IBAction func forgotPassword(_ sender: Any) {
        let forgotPasswordAlert = UIAlertController(title: "Forgot password?", message: "Enter email address", preferredStyle: .alert)
        forgotPasswordAlert.addTextField { (textField) in
            textField.placeholder = "Enter email address"
        }
        forgotPasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        forgotPasswordAlert.addAction(UIAlertAction(title: "Reset Password", style: .default, handler: { (action) in
            let resetEmail = forgotPasswordAlert.textFields?.first?.text
            Auth.auth().sendPasswordReset(withEmail: resetEmail!, completion: { (error) in
                if error != nil{
                    self.displayAlert(title: "Reset Failure", message: error!.localizedDescription)
                }else {
                    self.displayAlert(title: "Reset Email sent successfully", message: "Please check your email for the reset link")
                }
            })
        }))
        //PRESENT ALERT
        self.present(forgotPasswordAlert, animated: true, completion: nil)
    }
    
    func displayAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
