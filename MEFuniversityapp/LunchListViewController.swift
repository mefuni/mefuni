import UIKit
import Firebase

class LunchListViewController: UIViewController {

	var lunchs = [Lunch]()

	func yemeksepeti_handler(alert: UIAlertAction!){
		print("can")
		let urlStr = "itms://itunes.apple.com/tr/app/yemeksepeti/id373034841?mt=8"
		if #available(iOS 10.0, *) {
			UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)

		} else {
			UIApplication.shared.openURL(URL(string: urlStr)!)
		}

	}

	func get_date() -> String {
		let date = Date()
		let locale = Locale(identifier:"tr")

		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMMM yyyy"
		dateFormatter.locale = locale

		let weekdayFormatter = DateFormatter()
		weekdayFormatter.dateFormat = "EEEE"
		weekdayFormatter.locale = locale

		let currentDayString: String = dateFormatter.string(from: date)
		let currentWeekDayString: String = weekdayFormatter.string(from: date)
		let fullDate = "\(currentDayString)" + " " + "\(currentWeekDayString)"
		return fullDate
	}


	@IBAction func thumbs_up(_ sender: Any) {
	}
	@IBAction func thumbs_down(_ sender: Any) {
		let alertController = UIAlertController(title: "Yemeksepeti", message: "Yemeksepetinden siparis vermek ister misin?", preferredStyle: .alert)

		let reject = UIAlertAction(title: "Hayir", style: .cancel, handler: nil)
		let accept = UIAlertAction(title: "Evet", style: .default, handler: self.yemeksepeti_handler)
		alertController.addAction(accept)
		alertController.addAction(reject)

		present(alertController, animated: true, completion: nil)

	}



	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var date: UILabel!

	@IBAction func addClicked(_ sender: Any) {
		let alert = UIAlertController(title: "Yemek Ekle", message: "Bugunun yemekleri nedir?", preferredStyle: .alert)
		alert.addTextField {
			(textField) in
			textField.placeholder = "Tarih"
		}
		alert.addTextField {
			(textField) in
			textField.placeholder = "Ana Yemekler"
		}
		alert.addTextField {
			(textField) in
			textField.placeholder = "Corbalar"
		}
		alert.addTextField {
			(textField) in
			textField.placeholder = "Salatalar"
		}

		let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		let post = UIAlertAction(title: "Post", style: .default) {
			_ in
			guard let date = alert.textFields?[0].text else {return}
			guard let main_lunch = alert.textFields?[1].text else {return}
			guard let soups = alert.textFields?[2].text else {return}
			guard let salads = alert.textFields?[3].text else {return}
			print(main_lunch)
			print(soups)

			let dateString = String(describing: Date())

			let parameters = ["created_at": dateString,
							  "mainLunch": main_lunch,
							  "soups": soups,
							  "salads": salads]

			DatabaseService.shared.lunchReference.child(date).setValue(parameters)
		}
		alert.addAction(cancel)
		alert.addAction(post)
		present(alert, animated: true, completion: nil)
	}


	@IBOutlet weak var menuButton: UIBarButtonItem!
	override func viewDidLoad() {
		super.viewDidLoad()

		if self.revealViewController() != nil {
			menuButton.target = self.revealViewController()
			menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
			self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
		}
		// Do any additional setup after loading the view.
		UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.fade)
	}

	override func viewDidAppear(_ animated: Bool) {
		let real_date = self.get_date()
		let childRef = DatabaseService.shared.lunchReference.child(real_date)

		childRef.observeSingleEvent(of: .value, with: { (snapshot) in
			print(snapshot)
			guard let lunchsSnapshot = LunchSnapshot(with: snapshot) else { return }
			self.lunchs = lunchsSnapshot.lunchs
			self.lunchs.sort(by: {$0.date.compare($1.date) == .orderedDescending})
			self.tableView.reloadData()
			self.date.text = real_date
			print(real_date)
		})
	}

	override var preferredStatusBarStyle : UIStatusBarStyle {
		return UIStatusBarStyle.lightContent
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
		cell.textLabel?.text = lunchs[indexPath.row].mainLunch
		cell.detailTextLabel?.text = lunchs[indexPath.row].soups
		return cell
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return lunchs.count
	}
}


	