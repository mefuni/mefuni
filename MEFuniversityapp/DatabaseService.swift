//
//  DatabaseService.swift
//  MEFuniversity
//
//  Created by Can Sirin on 14/04/2018.
//  Copyright © 2018 Meffers. All rights reserved.
//

import Foundation
import Firebase

class DatabaseService {

	static let shared = DatabaseService()
	private init() {}

	let lunchReference = Database.database().reference().child("lunch")

}
