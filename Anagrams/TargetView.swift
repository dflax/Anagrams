//
//  TargetView.swift
//  Anagrams
//
//  Created by Daniel Flax on 4/29/15.
//  Copyright (c) 2015 Caroline. All rights reserved.
//

import UIKit

class TargetView: UIImageView {

	var letter: Character
	var isMatched:Bool = false

	// this should never be called
	required init(coder aDecoder:NSCoder) {
		fatalError("use init(letter:, sideLength:")
	}

	init(letter:Character, sideLength:CGFloat) {
		self.letter = letter

		let image = UIImage(named: "slot")!
		super.init(image:image)

		let scale = sideLength / image.size.width
		self.frame = CGRectMake(0, 0, image.size.width * scale, image.size.height * scale)
	}

}


