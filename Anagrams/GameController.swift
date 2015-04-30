//
//  GameController.swift
//  Anagrams
//
//  Created by Daniel Flax on 4/29/15.
//  Copyright (c) 2015 Caroline. All rights reserved.
//

import UIKit

class GameController {

	var gameView: UIView!
	var level:    Level!
	var hud:      HUDView!

	private var tiles   = [TileView]()
	private var targets = [TargetView]()

	// For the level timer
	//stopwatch variables
	private var secondsLeft: Int = 0
	private var timer: NSTimer?

	init() {
	}

	// Hand out a random anagram to the user and start the level timer
	func dealRandomAnagram () {
		//1
		assert(level.anagrams.count > 0, "no level loaded")

		//2
		let randomIndex = randomNumber(minX:0, maxX:UInt32(level.anagrams.count-1))
		let anagramPair = level.anagrams[randomIndex]

		//3
		let anagram1 = anagramPair[0] as! String
		let anagram2 = anagramPair[1] as! String

		//4
		let anagram1length = count(anagram1)
		let anagram2length = count(anagram2)

		//5
		println("phrase1[\(anagram1length)]: \(anagram1)")
		println("phrase2[\(anagram2length)]: \(anagram2)")

		// calculate the tile size
		let tileSide = ceil(ScreenWidth * 0.9 / CGFloat(max(anagram1length, anagram2length))) - TileMargin

		// get the left margin for first tile
		var xOffset = (ScreenWidth - CGFloat(max(anagram1length, anagram2length)) * (tileSide + TileMargin)) / 2.0

		// adjust for tile center (instead of the tile's origin)
		xOffset += tileSide / 2.0

		//initialize target list
		targets = []

		// create targets
		for (index, letter) in enumerate(anagram2) {
			if letter != " " {
				let target = TargetView(letter: letter, sideLength: tileSide)
				target.center = CGPointMake(xOffset + CGFloat(index)*(tileSide + TileMargin), ScreenHeight/4)

				gameView.addSubview(target)
				targets.append(target)
			}
		}

		// 1 initialize tile list
		tiles = []

		//2 create tiles
		for (index, letter) in enumerate(anagram1) {

			//3
			if letter != " " {
				let tile = TileView(letter: letter, sideLength: tileSide)
				tile.center = CGPointMake(xOffset + CGFloat(index)*(tileSide + TileMargin), ScreenHeight/4*3)
				tile.randomize()

				// Set the drag and drop delegate for the tile to this controller
				tile.dragDelegate = self

				//4
				gameView.addSubview(tile)
				tiles.append(tile)
			}
		}

		// Start the timer
		self.startStopwatch()
	}

	// MARK: - Game Logic Bits
	// Move tiles into position, when correctly placed
	func placeTile(tileView: TileView, targetView: TargetView) {

		//1
		targetView.isMatched = true
		tileView.isMatched = true

		//2
		tileView.userInteractionEnabled = false

		//3
		UIView.animateWithDuration(0.35, delay:0.00, options:UIViewAnimationOptions.CurveEaseOut,
			//4
			animations: {
				tileView.center = targetView.center
				tileView.transform = CGAffineTransformIdentity
			},
			//5
			completion: {
				(value:Bool) in
				targetView.hidden = true
		})
	}

	func checkForSuccess() {
		for targetView in targets {
			//no success, bail out
			if !targetView.isMatched {
				return
			}
		}
		println("Game Over!")
		//stop the stopwatch
		self.stopStopwatch()
	}

	// MARK: - Timer methods

	// Start the stop watch itself
	func startStopwatch() {
		// initialize the timer HUD
		secondsLeft = level.timeToSolve
		hud.stopwatch.setSeconds(secondsLeft)

		// schedule a new timer
		timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:"tick:", userInfo: nil, repeats: true)
	}

	// Stop the stopwatch
	func stopStopwatch() {
		timer?.invalidate()
		timer = nil
	}

	// Define a tick for each click of the stop watch
	@objc func tick(timer: NSTimer) {
		secondsLeft--
		hud.stopwatch.setSeconds(secondsLeft)
		if secondsLeft == 0 {
			self.stopStopwatch()
		}
	}


}

// MARK: - Tile Drag Delegate Protocol
// Extension to handle Tile Drag and Drops
extension GameController: TileDragDelegateProtocol {

	// a tile was dragged, check if matches a target
	func tileView(tileView: TileView, didDragToPoint point: CGPoint) {
		var targetView: TargetView?
		for tv in targets {
			if tv.frame.contains(point) && !tv.isMatched {
				targetView = tv
				break
			}
		}

		//1 check if target was found
		if let targetView = targetView {

			//2 check if letter matches
			if targetView.letter == tileView.letter {

				//3
				println("Success! You should place the tile here!")
				self.placeTile(tileView, targetView: targetView)

				println("Check if the player has completed the phrase")
				//check for finished game
				self.checkForSuccess()

			} else {
				//4
				println("Failure. Let the player know this tile doesn't belong here")

				//1
				tileView.randomize()

				//2
				UIView.animateWithDuration(0.35, delay:0.00, options:UIViewAnimationOptions.CurveEaseOut,
					animations: {
						tileView.center = CGPointMake(tileView.center.x + CGFloat(randomNumber(minX:0, maxX:40)-20), tileView.center.y + CGFloat(randomNumber(minX:20, maxX:30)))
					},
					completion: nil)
			}
		}
	}
}


