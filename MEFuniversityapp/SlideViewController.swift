//
//  SlideViewController.swift
//  MCommerce
//
//

/*
var opacityframe: CGRect = self.view.bounds
var opacityOffset: CGFloat = 0
opacityframe.origin.y = opacityframe.origin.y + opacityOffset
opacityframe.size.height = opacityframe.size.height - opacityOffset
opacityView = UIView(frame: opacityframe)
opacityView.backgroundColor = UIColor.blackColor()
opacityView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
opacityView.layer.opacity = 0.0
self.view.insertSubview(opacityView, atIndex: 1)
*/

import Foundation
import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
	switch (lhs, rhs) {
	case let (l?, r?):
		return l < r
	case (nil, _?):
		return true
	default:
		return false
	}
}


extension UIViewController {

	func slidingViewController() -> SlideViewController
	{
		var viewController:UIViewController? = self.parent
		while !(viewController == nil || viewController?.isKind(of: SlideViewController.self) == true) {
			viewController = viewController?.parent
		}

		return viewController as! SlideViewController
	}

	func viewHasShadow(_ hasShadow:Bool,color:UIColor,cornerRadius:CGFloat,shadowOffsetX:CGFloat,shadowOffsetY:CGFloat,opacity:Float)
	{
		view.layer.isOpaque = false;
		view.layer.cornerRadius = cornerRadius;

		view.layer.shadowColor = color.cgColor
		view.layer.shadowRadius = cornerRadius
		view.layer.shadowOffset = CGSize(width: shadowOffsetX, height: shadowOffsetY)
		view.layer.shadowOpacity = opacity

	}

}


class SlideViewController: UIViewController {

	//MARK: - PROPERTIES
	//MARK: View Controllers Properties
	var centerViewController: UIViewController = UIViewController() {
		didSet {

			centerViewController.view.removeFromSuperview()
			centerViewController.willMove(toParentViewController: nil)
			centerViewController.removeFromParentViewController()

			//self.centerViewController = centerViewController
			view.addSubview(centerViewController.view)
			addChildViewController(centerViewController)
			centerViewController.didMove(toParentViewController: self)

			centerViewController.view.frame = CGRect(x: 0, y: topViewOffsetY, width: view.frame.size.width, height: view.frame.size.height - topViewOffsetY)
			centerViewController.viewHasShadow(true, color: shadowColor, cornerRadius: cornerRadius, shadowOffsetX: shadowOffsetX, shadowOffsetY: shadowOffsetY, opacity: shadowOpacity)
			addGestures()
		}
	}

	var leftViewController: UIViewController? {
		didSet {

			leftViewController!.view.removeFromSuperview()
			leftViewController!.willMove(toParentViewController: nil)
			leftViewController!.removeFromParentViewController()

			//self.leftViewController = leftViewController;
			view.addSubview(leftViewController!.view);
			view.sendSubview(toBack: leftViewController!.view)
			addChildViewController(leftViewController!)
			leftViewController!.didMove(toParentViewController: self)
		}
	}
	var rightViewController: UIViewController? {
		didSet {

			rightViewController!.view.removeFromSuperview()
			rightViewController!.willMove(toParentViewController: nil)
			rightViewController!.removeFromParentViewController()

			//self.rightViewController = rightViewController;
			view.addSubview(rightViewController!.view);
			view.sendSubview(toBack: rightViewController!.view)
			addChildViewController(rightViewController!)
			rightViewController!.didMove(toParentViewController: self)
		}
	}


	var opacityView = UIView()

	//MARK: Settings Properties
	var allowOverswipe: Bool = false
	var topViewOffsetY: CGFloat = 0
	var peakAmount: CGFloat = 140.0
	var peakThreshold: CGFloat = 0.5
	var cornerRadius: CGFloat = 4.0
	var shadowOpacity: Float = 0.3
	var shadowOffsetX: CGFloat = 3.0
	var shadowOffsetY: CGFloat = 3.0
	var shadowColor: UIColor = UIColor.black
	var animationDuration: Double = 0.5

	//MARK: Visibility Properties
	var showingLeft: Bool = false;
	var showingRight: Bool = false;

	//MARK: Gestures
	var panGesture: UIGestureRecognizer = UIGestureRecognizer()
	var tapGesture: UIGestureRecognizer = UIGestureRecognizer()

	//MARK: - Animate to position

	func slideRight() {

		attachTapGesture()

		if rightViewController != nil {
			view.sendSubview(toBack: rightViewController!.view)
			if (rightViewController?.responds(to: #selector(getter: UIViewController.preferredStatusBarStyle)) != nil){
				UIApplication.shared.setStatusBarStyle(rightViewController!.preferredStatusBarStyle, animated: false)
			}
		}

		if leftViewController == nil {
			return;
		}

		view.bringSubview(toFront: centerViewController.view)
		if showingLeft && centerViewController.view.frame.origin.x == peakAmount {
			snapToOrigin()
		}else {

			UIView.animate(withDuration: self.animationDuration, delay: 0, options: UIViewAnimationOptions.beginFromCurrentState,
			               animations: {
							self.centerViewController.view.frame = CGRect(x: self.peakAmount, y: self.topViewOffsetY, width: self.view.frame.size.width, height: self.view.frame.size.height - self.topViewOffsetY)
			},
			               completion:  { (finished: Bool) in
							self.showingLeft = true;
			}
			)

		}
	}

	func slideLeft() {

		attachTapGesture()

		if leftViewController != nil {
			view.sendSubview(toBack: leftViewController!.view)
			if (leftViewController?.responds(to: #selector(getter: UIViewController.preferredStatusBarStyle)) != nil){
				UIApplication.shared.setStatusBarStyle(leftViewController!.preferredStatusBarStyle, animated: false)
			}
		}

		if rightViewController == nil {
			return;
		}

		view.bringSubview(toFront: centerViewController.view)
		if showingRight && centerViewController.view.frame.origin.x == 0 - peakAmount {
			snapToOrigin()
		}else {

			UIView.animate(withDuration: self.animationDuration, delay: 0, options: UIViewAnimationOptions.beginFromCurrentState,
			               animations: {
							self.centerViewController.view.frame = CGRect(x: 0 - self.peakAmount, y: self.topViewOffsetY, width: self.view.frame.size.width, height: self.view.frame.size.height - self.topViewOffsetY)
			},
			               completion:  { (finished: Bool) in
							self.showingRight = true;
			}
			)

		}
	}

	func snapToOrigin() {

		showingLeft = false;
		showingRight = false;

		UIView.animate(withDuration: self.animationDuration / 2.0, delay: 0, options: UIViewAnimationOptions.beginFromCurrentState,
		               animations: {
						self.centerViewController.view.frame = CGRect(x: 0, y: self.topViewOffsetY, width: self.view.frame.size.width, height: self.view.frame.size.height - self.topViewOffsetY)
		},
		               completion:  { (finished: Bool) in
						self.centerViewController.view.removeGestureRecognizer(self.tapGesture);
		}
		)

	}

	//MARK: - UIGestureRecognizers

	func addGestures() {
		panGesture = UIPanGestureRecognizer(target: self, action: #selector(SlideViewController.dragView(_:)))
		centerViewController.view.addGestureRecognizer(panGesture)
		//***** panGesture.delegate = self;

		tapGesture = UITapGestureRecognizer(target: self, action: #selector(SlideViewController.tapClose))
		centerViewController.view.removeGestureRecognizer(tapGesture)
	}

	func attachTapGesture() {

		centerViewController.view.removeGestureRecognizer(tapGesture)
		centerViewController.view.addGestureRecognizer(tapGesture)
	}

	func tapClose() {
		snapToOrigin()
	}

	func dragView(_ sender:AnyObject) {

		(sender as! UIPanGestureRecognizer).view?.layer.removeAllAnimations()
		let senderView :UIView? = sender.view
		let translatedPoint = (sender as! UIPanGestureRecognizer).translation(in: view)
		let velocity = (sender as! UIPanGestureRecognizer).velocity(in: senderView)
		let topLeftX = senderView?.frame.origin.x

		if ((sender as! UIPanGestureRecognizer).state == UIGestureRecognizerState.began) {

			var viewToShow :UIViewController? = nil;
			if (velocity.x > 0) {
				if !showingRight && rightViewController != nil {
					viewToShow = rightViewController;
				}else {
					return;
				}
			}else {
				if !showingLeft && leftViewController != nil {
					viewToShow = leftViewController;
				}else {
					return;
				}
			}

			if (viewToShow?.responds(to: #selector(getter: UIViewController.preferredStatusBarStyle)) != nil) {
				UIApplication.shared.setStatusBarStyle(viewToShow!.preferredStatusBarStyle, animated: false)
			}

			view.sendSubview(toBack: viewToShow!.view)
			senderView?.bringSubview(toFront: (sender as! UIPanGestureRecognizer).view!)
		}

		if ((sender as! UIPanGestureRecognizer).state == UIGestureRecognizerState.ended) {
			let frameWidth = senderView?.frame.size.width
			let widthVisibleAfterPeak = frameWidth! - peakAmount
			let thresholdCenter = (frameWidth! - widthVisibleAfterPeak) * peakThreshold

			if(showingLeft) {
				if(topLeftX < thresholdCenter) {
					snapToOrigin()
				}else {
					slideRight()
				}
			}else if(showingRight) {
				if(topLeftX < 0 - thresholdCenter) {
					slideLeft()
				}else {
					snapToOrigin()
				}
			}else {
				snapToOrigin()
			}
		}

		if ((sender as! UIPanGestureRecognizer).state == UIGestureRecognizerState.changed) {
			let centerX: CGFloat? = senderView?.center.x
			let centerY: CGFloat? = senderView?.center.y;
			let newCenter = CGPoint(x: centerX! + translatedPoint.x, y: centerY!)
			let frameCenter = senderView!.frame.size.width / 2


			if (velocity.x < 0 && rightViewController == nil && newCenter.x < frameCenter)
				|| (velocity.x > 0 && leftViewController == nil && newCenter.x > frameCenter)
				|| (showingLeft == true && newCenter.x < frameCenter && !allowOverswipe)
				|| (showingRight == true && newCenter.x > frameCenter && !allowOverswipe) {
				return;
			}

			senderView?.center = newCenter;
			(sender as! UIPanGestureRecognizer).setTranslation(CGPoint(x: 0, y: 0), in: view)

			if(newCenter.x < frameCenter) {
				showingRight = true
				showingLeft = false
			}else if(newCenter.x > frameCenter) {
				showingRight = false
				showingLeft = true
			}else {
				showingRight = false
				showingLeft = false
			}
		}

	}


}







