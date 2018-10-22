//
//  HarsniqiXzarionPerexod.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/22/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit

class HarsniqiXzarionPerexod: NSObject, UIViewControllerAnimatedTransitioning {
    private let timeInterval = 1.0
    private var transitionContext: UIViewControllerContextTransitioning?
    private var holeView: UIView?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return timeInterval
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        let containerView = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to) else { return }

        containerView.insertSubview(toView, belowSubview: fromView)
        /******************
        * calovi animacya *
        *******************
         
        let midX = fromView.frame.midX
        let height = fromView.frame.height
        toView.frame = CGRect(x: midX, y: 0.0, width: 0.0, height: height)
        toView.alpha = 0.0
        let fromViewFrame = fromView.frame
        
        let animator1 = UIViewPropertyAnimator(duration: timeInterval / 2.0,
                                              curve: .linear)
        let animator2 = UIViewPropertyAnimator(duration: timeInterval / 2.0,
                                               curve: .linear)
        
        animator1.addAnimations {
            fromView.frame = CGRect(x: midX, y: 0.0, width: 0.0, height: height)
        }
        
        animator2.addAnimations {
            toView.alpha = 1.0
            toView.frame = fromViewFrame
        }
        
        animator1.addCompletion { _ in
            animator2.startAnimation()
        }
        
        animator2.addCompletion({ _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
        animator1.startAnimation()
         
        *******************
        * calovi animacya *
        ******************/
        
        toView.frame = fromView.frame
        holeView = fromView
        let bounds = fromView.bounds
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.fillColor = UIColor.black.cgColor
        let kRadius: CGFloat = 10
        let circleRect = CGRect(x: bounds.midX - kRadius, y: bounds.midY - kRadius, width: 2 * kRadius, height: 2 * kRadius)
        let path = UIBezierPath(heartIn: circleRect)
        path.append(UIBezierPath(rect: bounds))
        maskLayer.fillRule = .evenOdd
        holeView?.layer.mask = maskLayer
        
        let circleRect1 = CGRect(x: bounds.midX -  100 * kRadius, y: bounds.midY - 100 * kRadius, width: 200 * kRadius, height: 200 * kRadius)
        let newPath = UIBezierPath(heartIn: circleRect1)
        newPath.append(UIBezierPath(rect: bounds))
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.delegate = self
        animation.duration = timeInterval
        animation.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear)
        animation.fromValue = path.cgPath
        animation.toValue = newPath.cgPath
        animation.isRemovedOnCompletion = false
        maskLayer.add(animation, forKey: "pathAnimation")
    }
    
}

extension HarsniqiXzarionPerexod: CAAnimationDelegate {
    func animationEnded(_ transitionCompleted: Bool) {
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        print("start")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("\(#function) and \(#file) and \(#line)")
        holeView?.layer.mask = nil
        self.transitionContext?.completeTransition(!(self.transitionContext?.transitionWasCancelled).valueOr(false))
    }
}

extension UIBezierPath {
    convenience init(heartIn rect: CGRect) {
        self.init()
        
        
        self.move(to: CGPoint(x: rect.midX, y: rect.minY + rect.height))
        
        self.addCurve(to: CGPoint(x: rect.minX, y: rect.minY + (rect.height / 4.0)),
                      controlPoint1:CGPoint(x: rect.minX + (rect.width / 2.0), y: rect.minY + (rect.height * 3 / 4)) ,
                      controlPoint2: CGPoint(x: rect.minX, y: rect.minY + (rect.height / 2.0)) )
        
        self.addArc(withCenter: CGPoint( x: rect.minX + (rect.width / 4.0),y: rect.minY + (rect.height / 4.0)),
                    radius: (rect.width / 4.0),
                    startAngle: .pi,
                    endAngle: 0,
                    clockwise: true)
        
        self.addArc(withCenter: CGPoint( x: rect.minX + (rect.width * 3 / 4),y: rect.minY + (rect.height / 4.0)),
                    radius: (rect.width / 4.0),
                    startAngle: .pi,
                    endAngle: 0,
                    clockwise: true)
        
//        self.addCurve(to: CGPoint(x: rect.width / 2.0, y: rect.minY + rect.height),
//                      controlPoint1: CGPoint(x: rect.minX + rect.width, y: rect.minY + (rect.height / 2.0)),
//                      controlPoint2: CGPoint(x: rect.minX + (rect.width / 2.0), y: rect.minY + (rect.height * 3 / 4)) )

        //Left Bottom Line
        self.close()
    }
}

extension Int {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}
