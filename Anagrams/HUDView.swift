//
//  HUDView.swift
//  Anagrams
//
//  Created by Daniel Flax on 4/30/15.
//  Copyright (c) 2015 Caroline. All rights reserved.
//

import UIKit

class HUDView: UIView {

	var stopwatch: StopwatchView

	// this should never be called
	required init(coder aDecoder:NSCoder) {
		fatalError("use init(frame:")
	}

	override init(frame:CGRect) {
		self.stopwatch = StopwatchView(frame:CGRectMake(ScreenWidth/2-150, 0, 300, 100))
		self.stopwatch.setSeconds(0)

		super.init(frame:frame)
		self.addSubview(self.stopwatch)

		// Turn off user interactions for the HUD, so touches flow through to the game
		self.userInteractionEnabled = false
	}

}

