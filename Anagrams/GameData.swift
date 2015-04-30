//
//  GameData.swift
//  Anagrams
//
//  Created by Daniel Flax on 4/30/15.
//  Copyright (c) 2015 Caroline. All rights reserved.
//

import Foundation

class GameData {

	// Store the user's game achievement
	var points:Int = 0 {
		didSet {
			points = max(points, 0)
		}
	}

}


