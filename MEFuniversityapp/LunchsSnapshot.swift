//
//  LunchsSnapshot.swift
//  MEFuniversity
//
//  Created by Can Sirin on 14/04/2018.
//  Copyright © 2018 Meffers. All rights reserved.
//

import Foundation
import Firebase

struct LunchSnapshot {

	let lunchs: [Lunch]

	init?(with snapshot: DataSnapshot) {
		var lunchs = [Lunch]()
		guard let snapDict = snapshot.value as? [String: [String: Any]] else {return nil}
		for snap in snapDict {
			let lunch = Lunch(lunchId: snap.key, dict: snap.value)
			lunchs.append(lunch!)
		}
		self.lunchs = lunchs
	}
}
