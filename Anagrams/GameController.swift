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
	var level: Level!

	private var tiles = [TileView]()

	init() {
	}

	// Hand out a random anagram to the user
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

		//1 initialize tile list
		tiles = []

		//2 create tiles
		for (index, letter) in enumerate(anagram1) {

			//3
			if letter != " " {
				let tile = TileView(letter: letter, sideLength: tileSide)
				tile.center = CGPointMake(xOffset + CGFloat(index)*(tileSide + TileMargin), ScreenHeight/4*3)
				tile.randomize()

				//4
				gameView.addSubview(tile)
				tiles.append(tile)
			}
		}
	}


}


