//
//  ViewController.swift
//  KK
//
//  Created by sphota on 2/15/16.
//  Copyright © 2016 Lex Levi. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore

class MenuViewController: UIViewController {
	
	@IBOutlet weak var tutorialButton: UIButton!
	@IBOutlet weak var engineerButton: UIButton!
	@IBOutlet weak var casualButton: UIButton!
	
	var mesh = Mesh()
	let sB = UIStoryboard(name: "Main", bundle: nil)
	
	func setup () {
		// . . L o g o
		let logoView = LogoView(frame: CGRect(x: 0, y: 0, width: 220, height: 220))
		logoView.frame.origin =  CGPointMake(CGRectGetMidX(logoView.frame), CGRectGetMidY(logoView.frame))
		logoView.layer.anchorPoint = CGPointMake(CGRectGetMidX(logoView.frame), CGRectGetMidY(logoView.frame))
		if UIScreen.mainScreen().bounds.width <= 320 {
			logoView.frame = CGRectMake(CGRectGetMidX(self.view.frame) - logoView.frame.width/2, CGRectGetMidY(self.view.frame) - logoView.frame.width * 1.45, logoView.frame.width, logoView.frame.height)
		}
		else {
			logoView.frame = CGRectMake(CGRectGetMidX(self.view.frame) - logoView.frame.width/2, CGRectGetMidY(self.view.frame) - logoView.frame.width * 1.15, logoView.frame.width, logoView.frame.height)
		}
		logoView.layer.cornerRadius = 10
		logoView.layer.masksToBounds = true
		self.view.addSubview(logoView)
		self.mesh = Mesh(frame: CGRectMake(logoView.frame.origin.x, logoView.frame.origin.y, logoView.frame.width, logoView.frame.height), magnitude: 0, table: [])
		self.view.addSubview(mesh)
		tutorialButton.layer.borderWidth = 1
		tutorialButton.layer.borderColor = UIColor.whiteColor().CGColor
		engineerButton.layer.borderColor = UIColor.whiteColor().CGColor
		engineerButton.layer.borderWidth = 1
		casualButton.layer.borderColor = UIColor.whiteColor().CGColor
		casualButton.layer.borderWidth = 1
		self.view.backgroundColor = BACKGROUND_COLOR
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(true)
		self.mesh.animateMesh()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func prefersStatusBarHidden() -> Bool {
		return true
	}

	@IBAction func casualPressed(sender: AnyObject) {
		animateMenuButton(casualButton) { (data: Bool) -> Void in
			self.casualButton.selected = false
			let  trans = UIViewAnimationTransition.FlipFromRight
			UIView.beginAnimations("trans", context: nil)
			UIView.setAnimationTransition(trans, forView: UIApplication.sharedApplication().keyWindow!, cache: true)
			UIView.setAnimationDuration(0.3)
			let config = StoryBoardManager.sharedManager.instantiateViewControllerWithIdentifier("ConfigView") as? ConfigViewController
			self.presentViewController(config!, animated: false, completion: nil)
			UIView.commitAnimations()
		}
	}
	
	@IBAction func engineerPressed(sender: AnyObject) {
		animateMenuButton(engineerButton) { (data: Bool) -> Void in
			self.casualButton.selected = false
			let trans = UIViewAnimationTransition.FlipFromRight
			UIView.beginAnimations("trans", context: nil)
			UIView.setAnimationTransition(trans, forView: UIApplication.sharedApplication().keyWindow!, cache: true)
			UIView.setAnimationDuration(0.3)
			let config = StoryBoardManager.sharedManager.instantiateViewControllerWithIdentifier("ConfigView") as? ConfigViewController
			self.presentViewController(config!, animated: false, completion: nil)
			UIView.commitAnimations()

		}
	}
	
	@IBAction func tutorialPressed(sender: AnyObject) {
		animateMenuButton(tutorialButton) { (data: Bool) -> Void in

		}
	}
	
	internal func animateMenuButton(view: AnyObject, completion: ((Bool) -> Void)?) {
		guard let button = view as? UIButton
			else { print(Error.UnknownType); return }
		
		if !button.selected {
			button.selected = true
			UIView.animateWithDuration(0.3, animations: { () -> Void in
				button.transform = CGAffineTransformMakeScale(1.2, 1.2)
			}, completion:completion)
		} else {
			button.selected = false
			UIView.animateWithDuration(0.3, animations: { () -> Void in
				button.transform = CGAffineTransformMakeScale(1, 1)
			}, completion: completion)
		}
	}
	
	override func viewWillDisappear(animated: Bool) {
		UIView.animateWithDuration(0.3, animations: { () -> Void in
			self.engineerButton.transform = CGAffineTransformMakeScale(1, 1)
			self.casualButton.transform = CGAffineTransformMakeScale(1, 1)
			self.tutorialButton.transform = CGAffineTransformMakeScale(1, 1)
			}, completion: nil)
		self.engineerButton.selected = false
		self.casualButton.selected = false
		self.tutorialButton.selected = false
	}
}