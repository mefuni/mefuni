import UIKit

class ShuttleViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var tblShuttleFirst: UITableView!
    
    @IBOutlet weak var tblShuttleSecond: UITableView!
    
    @IBOutlet weak var lblSubToSchool: UILabel!
    
    @IBOutlet weak var lblSchoolToSub: UILabel!
    
    var minuteFirst = 0
    var timerFirst:Timer = Timer()
    
    var minuteSecond = 0
    var timerSecond:Timer = Timer()
    
    var shuttleItems:Array<ShuttleItem> = [ShuttleItem]()
    var shuttleItemsSec:Array<ShuttleItemSec> = [ShuttleItemSec]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        tblShuttleFirst.layer.borderColor = (UIColor(red: 0, green: 0, blue: 128.0 / 255.0, alpha: 1.0)).cgColor
        tblShuttleFirst.layer.borderWidth = 2.0
        
        
        
        
        tblShuttleSecond.layer.borderColor = (UIColor(red: 0, green: 0, blue: 128.0 / 255.0, alpha: 1.0)).cgColor
        tblShuttleSecond.layer.borderWidth = 2.0
        
        let filePath = Bundle.main.path(forResource: "ShuttleListFirst", ofType: "plist")
        
        let rawMenuItems = NSArray(contentsOfFile: filePath!)!
        
        for i in 0 ..< rawMenuItems.count
        {
            shuttleItems.append(ShuttleItem(time:rawMenuItems[i] as! String))
        }
        
        let filePathSec = Bundle.main.path(forResource: "ShuttleListSecond", ofType: "plist")
        
        let rawMenuItemsSec = NSArray(contentsOfFile: filePathSec!)!
        
        for i in 0 ..< rawMenuItems.count
        {
            shuttleItemsSec.append(ShuttleItemSec(time:rawMenuItemsSec[i] as! String))
        }
        
            UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.fade)
        
        
        loadSecond()
        
    }
    
    func loadSecond()
    {
        for temp in shuttleItems {
            
            if let minute = isLessThanTimeSpan(temp.time) {
                
                minuteFirst = minute
                break
            }
        }
        
        for temp in shuttleItemsSec {
            
            if let minute = isLessThanTimeSpan(temp.time) {
                
                minuteSecond = minute
                break
            }
        }
        if minuteFirst <= 45 && minuteFirst >= 0
        {
            lblSubToSchool.text = "In \(minuteFirst) min"
            lblSubToSchool.textColor = UIColor.green
        }
        
        else
        {
            lblSubToSchool.text = "There is no shuttle"
        }
        
        if minuteSecond <= 45 && minuteFirst >= 0
        {
            lblSchoolToSub.text = "In \(minuteSecond) min"
            lblSchoolToSub.textColor = UIColor.green
        }
            
        else
        {
            lblSchoolToSub.text = "There is no shuttle"
        }

        
        if (!timerFirst.isValid) {
            let aSelector : Selector = #selector(ShuttleViewController.updateTimeFirst)
            timerFirst = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: aSelector, userInfo: nil, repeats: true)
            
        }
        
        if (!timerSecond.isValid) {
            let aSelector : Selector = #selector(ShuttleViewController.updateTimeSecond)
            timerSecond = Timer.scheduledTimer(timeInterval: 60.00, target: self, selector: aSelector, userInfo: nil, repeats: true)
            
        }
        
    }
    
    
    func isLessThanTimeSpan(_ time:String) -> Int? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let nowDateString = dateFormatter.string(from: Date())
        
        dateFormatter.dateFormat = "yyy-MM-dd HH:mm:ss ZZZ"
        
        let shuttleDateString = "\(nowDateString) \(time):00 +0000"
        let shuttleDate = dateFormatter.date(from: shuttleDateString)
        
        let timeZone = TimeZone.autoupdatingCurrent
        let second = timeZone.secondsFromGMT(for: Date())
        let now = Date(timeInterval: TimeInterval(second), since: Date())
        
        if now.compare(shuttleDate!) == ComparisonResult.orderedAscending
        {
            let distanceBetweenDates = now.timeIntervalSince(shuttleDate!)
            let secondsInAnHour = -60
            return Int(distanceBetweenDates) / secondsInAnHour
            
        }
        
        return nil
    }
    
    
    func updateTimeFirst() {
        
        if minuteFirst > 0 {
            minuteFirst -= 1
        }
        else {
            timerFirst.invalidate()
            timerSecond.invalidate()
            loadSecond()
        }
        if minuteFirst <= 45 && minuteFirst >= 0
        {
            lblSubToSchool.text = "In \(minuteFirst) min"
            lblSubToSchool.textColor = UIColor.green
        }
            
        else
        {
            lblSubToSchool.text = "There is no shuttle."
            
            
        }
    }
    
    
    func updateTimeSecond() {
        
        if minuteSecond > 0 {
            minuteSecond -= 1
            
        }else {
            timerFirst.invalidate()
            timerSecond.invalidate()
            loadSecond()
        }
        
        if minuteSecond <= 45 && minuteSecond >= 0
        {
            lblSchoolToSub.text = "In \(minuteSecond) min"
            lblSchoolToSub.textColor = UIColor.green
        }
            
        else
        {
            lblSchoolToSub.text = "There is no shuttle"
        }
    }
    
    //MARK: TableView Delegate & Datasource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tblShuttleFirst
        {
            return shuttleItems.count
        }
            
        else
        {
            return shuttleItemsSec.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShuttleCell")! as UITableViewCell
        
        cell.textLabel?.textAlignment = NSTextAlignment.center
        cell.textLabel?.textColor = UIColor(red: 0, green: 0, blue: 128.0 / 255.0, alpha: 1.0)
        
        if tableView == tblShuttleFirst
        {
            cell.textLabel?.text = shuttleItems[indexPath.row].time
        }
            
        else
        {
            cell.textLabel?.text = shuttleItemsSec[indexPath.row].time
        }
        
        return cell
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
        override var preferredStatusBarStyle : UIStatusBarStyle {
            return UIStatusBarStyle.lightContent
        }
    
    
}
