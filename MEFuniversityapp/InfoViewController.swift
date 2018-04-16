//
//  InfoViewController.swift
//  
//
//  
//
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let image:UIImage = UIImage(named: "meflogo")!
        let logo = UIImageView(image: image)
        logo.frame = CGRect(x: self.view.frame.size.width/2 - 165, y: 25.0, width: 400, height: 260)
        view.addSubview(logo)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
