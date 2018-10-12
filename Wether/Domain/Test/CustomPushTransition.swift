//
//  CustomPushTransition.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/12/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit

class CustomPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var duration : TimeInterval
    var isPresenting : Bool
    var originFrame : CGRect
    var image : UIImage
    private let tag = 99
    
    init(duration : TimeInterval, isPresenting : Bool, originFrame : CGRect, image : UIImage) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        self.image = image
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to) else { return }
        self.isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        let nextVisibleView = isPresenting ? toView : fromView
        let prevVisibleView = isPresenting ? fromView : toView
        toView.frame = isPresenting ? CGRect(x: fromView.frame.width, y: 0, width: fromView.frame.width, height: fromView.frame.height) : toView.frame
        toView.alpha = isPresenting ? 0 : 1
        toView.layoutIfNeeded()
        
        
        guard let artwork = nextVisibleView.viewWithTag(tag) as? UIImageView else { return }
        artwork.alpha = 0
        artwork.image = image
        
        let transitionImageView = UIImageView(image: image)
        transitionImageView.frame = isPresenting ? originFrame : artwork.frame
        container.addSubview(transitionImageView)
        
        let animations = {
            transitionImageView.frame = self.isPresenting ? artwork.frame : self.originFrame
            nextVisibleView.frame = self.isPresenting ?
                fromView.frame : CGRect(x: toView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
            nextVisibleView.alpha = self.isPresenting ? 1 : 0
//            prevVisibleView.transform = self.isPresenting ? CGAffineTransform(scaleX: 0.85, y: 1.1) : .identity
        }
        
        UIViewPropertyAnimator
            .runningPropertyAnimator(withDuration: duration,
                                     delay: 0.0,
                                     options: .curveLinear,
                                     animations: animations) { _ in
                                        transitionImageView.removeFromSuperview()
                                        artwork.alpha = 1
                                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    
}
