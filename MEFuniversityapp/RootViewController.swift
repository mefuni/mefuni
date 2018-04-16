//
//  RootViewController.swift
//  mefsocial
//
//  Created by Gökberk Yamak on 24.08.2015.
//  Copyright (c) 2015 Gökberk Yamak. All rights reserved.
//

import UIKit


class RootViewController: SlideViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peakAmountQ()
        
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

    func peakAmountQ()
    {
        peakAmount = 80
        
        
        leftViewController = storyboard?.instantiateViewControllerWithIdentifier("LeftMenuVC") as! LeftMenuViewController
        
        centerViewController = storyboard?.instantiateViewControllerWithIdentifier("HomeVC") as! HomeViewController
}