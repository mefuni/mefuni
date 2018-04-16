//
//  Lunch.swift
//  MEFuniversity
//
//  Created by Can Sirin on 14/04/2018.
//  Copyright © 2018 Meffers. All rights reserved.
//

import Foundation

struct Lunch {

	let lunchId: String
	let mainLunch: String
	let soups: String
	let salads: String
	let date: String

	init?(lunchId: String, dict: [String: Any]){
		self.lunchId = lunchId
		let date = Date()
		let locale = Locale(identifier: "tr")

		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMMM yyyy"
		dateFormatter.locale = locale

		let weekdayFormatter = DateFormatter()
		weekdayFormatter.dateFormat = "EEEE"
		weekdayFormatter.locale = locale

		let currentDayString: String = dateFormatter.string(from: date)
		let currentWeekDayString: String = weekdayFormatter.string(from: date)


		let mainLunch = dict["mainLunch"] as? String
		let soups = dict["soups"] as? String
		let salads = dict["salads"] as? String
		let fullDate = "\(currentDayString)" + " " + "\(currentWeekDayString)"

		self.date = fullDate
		self.soups = soups!
		self.salads = salads!
		self.mainLunch = mainLunch!
		print(mainLunch)
	}
}
