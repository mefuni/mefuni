//
//  AccessViewController.swift
//  MEFuniversity
//

import Foundation
import Firebase

class RegisterViewController: UIViewController {

	

	@IBOutlet weak var _name: UITextField!
	@IBOutlet weak var _mail: UITextField!
	@IBOutlet weak var _password: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()
		

	}

	override var preferredStatusBarStyle : UIStatusBarStyle {
		return UIStatusBarStyle.lightContent
	}

	
	@IBAction func signup(_ sender: Any) {
		if _name.text == "" {
			let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)

			let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
			alertController.addAction(defaultAction)

			present(alertController, animated: true, completion: nil)

		} else {
			Auth.auth().createUser(withEmail: _mail.text!, password: _password.text!){
				(user, error) in
				if let error = error {
					print(error.localizedDescription)
				}
				else if let user = user {
					UserDefaults.standard.set(true, forKey: "isLogin")
					UserDefaults.standard.synchronize()
					print("Sign Up Successfully. \(user.uid)")
					print(user)
				}
			}
		}	}
}
