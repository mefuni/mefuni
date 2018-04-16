import Foundation
import Firebase

class SignInViewController: UIViewController {



	@IBOutlet weak var _mail: UITextField!
	@IBOutlet weak var _password: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()
		NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
	}

	@objc func keyboardWillShow(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
			if self.view.frame.origin.y == 0{
				self.view.frame.origin.y -= keyboardSize.height
			}
		}
	}

	@objc func keyboardWillHide(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
			if self.view.frame.origin.y != 0{
				self.view.frame.origin.y += keyboardSize.height
			}
		}
	}


	override var preferredStatusBarStyle : UIStatusBarStyle {
		return UIStatusBarStyle.lightContent
	}


	@IBAction func signin(_ sender: Any) {
		Auth.auth().signIn(withEmail: "can@can.com", password: "1234567") { (user, error) in
				if let error = error {
					print(error.localizedDescription)
//					let alert = UIAlertView(title: "Login", message: "E-mail or password is not correct.", delegate: nil, cancelButtonTitle: "OK")
//					alert.show()
//					return
				return
				}
				else {
					self.performSegue(withIdentifier: "loginSegue", sender: nil)
				}
			}
		}
	}



//@IBAction func signin(_ sender: Any) {
//	if _mail.text == "" {
//		let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
//
//		let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//		alertController.addAction(defaultAction)
//
//		present(alertController, animated: true, completion: nil)
//
//	} else {
//		Auth.auth().signIn(withEmail: "can@can.com", password: "1234567") { (user, error) in
//			if let error = error {
//				print(error.localizedDescription)
//				//					let alert = UIAlertView(title: "Login", message: "E-mail or password is not correct.", delegate: nil, cancelButtonTitle: "OK")
//				//					alert.show()
//				//					return
//				return
//			}
//			else {
//				self.performSegue(withIdentifier: "loginSegue", sender: nil)
//			}
//		}
//	}
//}

