//
//  SplashViewController.swift
//  MEFuniversity
//
//

import UIKit

class SplashViewController: VideoSplashViewController {
    var shimmeringView = FBShimmeringView()
    
    @IBOutlet weak var infoButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "test", ofType: "mp4")!)
        self.videoFrame = view.frame
        self.fillMode = .aspectFill
        self.alwaysRepeat = true
        self.startTime = 0.0
        self.duration = 38.0
        self.alpha = 0.8
        self.backgroundColor = UIColor.black
        self.contentURL = url
    
        
        let image:UIImage = UIImage(named: "meflogo")!
        let logo = UIImageView(image: image)
        logo.frame = CGRect(x: self.view.frame.size.width/2 - 165, y: 25.0, width: 400, height: 260)
        view.addSubview(logo)
        
        
        let text = UILabel(frame: CGRect(x: 0, y: self.view.frame.size.height - 130, width: self.view.frame.size.width, height: 100.0))
        text.font = UIFont(name: "Heiti TC", size: 22)
        text.textAlignment = NSTextAlignment.center
        text.textColor = UIColor.white
        text.text = "swipe to login"
        view.addSubview(text)
        
        self.shimmeringView = FBShimmeringView(frame: text.frame)
        self.view.addSubview(self.shimmeringView)
        self.shimmeringView.contentView = text
        self.shimmeringView.isShimmering = true
        self.shimmeringView.shimmeringBeginFadeDuration = 0.1
        self.shimmeringView.shimmeringOpacity = 0.2
        
        UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.fade)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        moviePlayer = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden : Bool {
        return true
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
