//
//  ViewController.swift
//  Anagrams
//
//  Created by Caroline on 1/08/2014.
//  Copyright (c) 2014 Caroline. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	private let controller:GameController

	required init(coder aDecoder: NSCoder) {
		controller = GameController()
		super.init(coder: aDecoder)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

println("isPad: \(isPad)")

		let level1 = Level(levelNumber: 1)
		println("anagrams: \(level1.anagrams)")

		// add one layer for all game elements
		let gameView = UIView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
		self.view.addSubview(gameView)
		controller.gameView = gameView

		//add one view for all hud and controls
		let hudView = HUDView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
		self.view.addSubview(hudView)
		controller.hud = hudView

		// Start up and load level 1
		controller.level = level1
		controller.dealRandomAnagram()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	override func prefersStatusBarHidden() -> Bool {
		return true
	}



}


