//
//  SplashViewController.swift
//  MEFuniversity
//
//

import UIKit
import Parse
import Firebase

class ViewController: SlideViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peakAmount = self.view.frame.size.width
        
        
        centerViewController = storyboard?.instantiateViewController(withIdentifier: "SplashVC") as! SplashViewController
        
        rightViewController = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! SignInViewController
        

        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    

