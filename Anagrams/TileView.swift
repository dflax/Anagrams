//
//  TileView.swift
//  Anagrams
//
//  Created by Daniel Flax on 4/29/15.
//  Copyright (c) 2015 Caroline. All rights reserved.
//

import UIKit

// Delegate protocol to inform Game Controller that tile has dropped.
protocol TileDragDelegateProtocol {
	func tileView(tileView: TileView, didDragToPoint: CGPoint)
}

//1
class TileView:UIImageView {

	// Touch Offsets
	private var xOffset: CGFloat = 0.0
	private var yOffset: CGFloat = 0.0

	//2
	var letter: Character

	//3
	var isMatched: Bool = false

	// Delegate protocol property
	var dragDelegate: TileDragDelegateProtocol?

	// 4 this should never be called
	required init(coder aDecoder:NSCoder) {
		fatalError("use init(letter:, sideLength:")
	}

	//5 create a new tile for a given letter
	init(letter:Character, sideLength:CGFloat) {
		self.letter = letter

		// the tile background
		let image = UIImage(named: "tile")!

		// superclass initializer
		// references to superview's "self" must take place after super.init
		super.init(image:image)

		// Enable touch movement
		self.userInteractionEnabled = true

		// 6 resize the tile
		let scale = sideLength / image.size.width
		self.frame = CGRect(x: 0, y: 0, width: image.size.width * scale, height: image.size.height * scale)

		//add a letter on top
		let letterLabel = UILabel(frame: self.bounds)
		letterLabel.textAlignment = NSTextAlignment.Center
		letterLabel.textColor = UIColor.whiteColor()
		letterLabel.backgroundColor = UIColor.clearColor()
		letterLabel.text = String(letter).uppercaseString
		letterLabel.font = UIFont(name: "Verdana-Bold", size: 78.0*scale)
		self.addSubview(letterLabel)
	}

	// Generate randomness in the tiles
	func randomize() {
		// 1
		// set random rotation of the tile
		// anywhere between -0.2 and 0.3 radians
		let rotation = CGFloat(randomNumber(minX:0, maxX:50)) / 100.0 - 0.2
		self.transform = CGAffineTransformMakeRotation(rotation)

		// 2
		// move randomly up or down -10 to 0 points
		let yOffset = CGFloat(randomNumber(minX: 0, maxX: TileYOffset) - Int(TileYOffset))
		self.center = CGPointMake(self.center.x, self.center.y + yOffset)
	}

	//1
	override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
		if let touch = touches.first as? UITouch {
			let point = touch.locationInView(self.superview)
			xOffset = point.x - self.center.x
			yOffset = point.y - self.center.y
		}
	}

	//2
	override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
		if let touch = touches.first as? UITouch {
			let point = touch.locationInView(self.superview)
			self.center = CGPointMake(point.x - xOffset, point.y - yOffset)
		}
	}

	//3
	override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
		self.touchesMoved(touches, withEvent: event)

		// Inform the delegate that the drag and drop has completed
		dragDelegate?.tileView(self, didDragToPoint: self.center)
	}



}

