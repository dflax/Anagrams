//
//  Config.swift
//  Anagrams
//
//  Created by Caroline on 1/08/2014.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

import Foundation
import UIKit

//UI constants
let ScreenWidth  = UIScreen.mainScreen().bounds.size.width
let ScreenHeight = UIScreen.mainScreen().bounds.size.height
let TileMargin:    CGFloat = 20.0
let TileYOffset:   UInt32 = 10

// Display HUD details
let FontHUD    = UIFont(name:"comic andy", size: 62.0)!
let FontHUDBig = UIFont(name:"comic andy", size:120.0)!

//Random integer generator
func randomNumber(#minX:UInt32, #maxX:UInt32) -> Int {
	let result = (arc4random() % (maxX - minX + 1)) + minX
	return Int(result)
}

