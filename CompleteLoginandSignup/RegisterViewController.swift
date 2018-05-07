//
//  RegisterViewController.swift
//  CompleteLoginandSignup
//
//  Created by Pranoti Kulkarni on 5/1/18.
//  Copyright © 2018 Pranoti Kulkarni. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {
    
    let databaseRef = Database.database().reference()

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if emailAddress.text == "" || password.text == "" || firstName.text == "" || lastName.text == "" {
                displayAlert(title: "Wrong Credentials", message: "Please provide valid credentials")
            }
        if password.text != confirmPassword.text {
             displayAlert(title: "Password Mismatch", message: "Please provide valid password")
        }else{
            if let email = emailAddress.text{
                if let password = password.text {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                if error !=  nil{
                    self.displayAlert(title: "Error", message: error!.localizedDescription)
                } else {
                    print("Sign up success")
                    self.performSegue(withIdentifier: "loginScreen", sender: nil)
                    }
                guard let uid = user?.uid else{
                    return
                }
                guard let firstName = self.firstName.text else{
                    return
                }
                guard let lastName = self.lastName.text else{
                    return
                }
                self.databaseRef.child("users").child(uid).setValue(["email": email,"firstName" : firstName, "lastName": lastName])
                })
            }
        }
    }
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
