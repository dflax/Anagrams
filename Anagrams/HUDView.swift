//
//  HUDView.swift
//  Anagrams
//
//  Created by Daniel Flax on 4/30/15.
//  Copyright (c) 2015 Caroline. All rights reserved.
//

import UIKit

class HUDView: UIView {

	var stopwatch:  StopwatchView
	var gamePoints: CounterLabelView

	// this should never be called
	required init(coder aDecoder:NSCoder) {
		fatalError("use init(frame:")
	}

	override init(frame:CGRect) {
		self.stopwatch = StopwatchView(frame:CGRectMake(ScreenWidth/2-150, 0, 300, MarginTop))
		self.stopwatch.setSeconds(0)

		// Dynamic points label
		self.gamePoints = CounterLabelView(font: FontHUD, frame: CGRectMake(ScreenWidth-200, 30, 200, 70))
		gamePoints.textColor = UIColor(red: 0.38, green: 0.098, blue: 0.035, alpha: 1)
		gamePoints.value = 0

		super.init(frame:frame)
		self.addSubview(self.stopwatch)

		// Add the Points HUD to the scene
		self.addSubview(gamePoints)
		
		//"points" label
		var pointsLabel = UILabel(frame: CGRectMake(ScreenWidth-340, 30, MarginTop * 1.5, 70))
		pointsLabel.backgroundColor = UIColor.clearColor()
		pointsLabel.font = FontHUD
		pointsLabel.text = " Points:"
		self.addSubview(pointsLabel)

		// Turn off user interactions for the HUD, so touches flow through to the game
		self.userInteractionEnabled = false
	}


}

