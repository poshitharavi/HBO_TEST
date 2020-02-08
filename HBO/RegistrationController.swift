//
//  RegistrationController.swift
//  HBO
//
//  Created by poshitha on 1/31/20.
//  Copyright © 2020 poshitha. All rights reserved.
//

import UIKit
import Firebase

class RegistrationController : UIViewController{
    
    //textboxes
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        databaseOperation()
        
    }
    
    func databaseOperation(){
        
        ref = Database.database().reference()
        
        //self.ref.child("df").child("articles") .setValue(["username": "testusername2"])
        
        self.ref.child("Users").childByAutoId().setValue(["FirstName":firstName.text!,"LastName":lastName.text!,"Email":email.text!,"Password":password.text!,"ZipCode":zipCode.text!])
        
        //create the user in authentication
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { authResult, error in
            
            if((error==nil)){
                
                self.showAlert(title: "Success", message: "User Registration Success !")
                //                let vc = UIStoryboard(name:"main",bundle: nil).instantiateViewController(withIdentifier: "login")
                //
                //                self.present(vc,animated: true,completion: nil)
                
            }
            else{
                
                self.showAlert(title: "Error", message: (error?.localizedDescription)!)
                
            }
            
        }
        
    }
    
    func showAlert(title:String,message:    String)  {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }

    
}


