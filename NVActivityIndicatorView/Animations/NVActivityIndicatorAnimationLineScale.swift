//
//  NVActivityIndicatorAnimationBarScale.swift
//  NVActivityIndicatorViewDemo
//
//  Created by Nguyen Vinh on 7/24/15.
//  Copyright (c) 2015 Nguyen Vinh. All rights reserved.
//

import UIKit

class NVActivityIndicatorAnimationLineScale: NVActivityIndicatorAnimationDelegate {
    
    func setUpAnimationInLayer(layer: CALayer, size: CGSize, color: UIColor) {
        let lineSize = size.width / 9
        let x = (layer.bounds.size.width - size.width) / 2
        let y = (layer.bounds.size.height - size.height) / 2
        let duration: CFTimeInterval = 1
        let beginTime = CACurrentMediaTime()
        let beginTimes = [0.1, 0.2, 0.3, 0.4, 0.5]
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)
        let keyTimes = [0, 0.5, 1]
        let values = [1, 0.4, 1]
        let timingFunctions = [timingFunction, timingFunction]
        
        // Animations
        let animation = self.scaleAnimiation(duration,
            timingFunctions: timingFunctions,
            keyTimes: keyTimes,
            values: values)
        
        let opacityAnimation = self.opacityAnimation(duration,
            timingFunctions: timingFunctions,
            keyTimes: keyTimes,
            values: values)
        
        opacityAnimation.timingFunctions = [timingFunction, timingFunction]
        // Draw lines
        for var i = 0; i < 5; i++ {
            let line = NVActivityIndicatorShape.Line.createLayerWith(size: CGSize(width: lineSize, height: size.height), color: color)
            let frame = CGRect(x: x + lineSize * 2 * CGFloat(i),
                y: y, width: lineSize, height: size.height)
            
            animation.beginTime = beginTime + beginTimes[i]
            opacityAnimation.beginTime = beginTime + beginTimes[i]
            line.frame = frame
            line.addAnimation(animation, forKey: "scaleAnimation")
            line.addAnimation(opacityAnimation, forKey: "opacityAnimation")
            layer.addSublayer(line)
            
        }
    }
    
    private func scaleAnimiation(duration: CFTimeInterval,
        timingFunctions:[CAMediaTimingFunction],
        keyTimes: [NSNumber],
        values: [NSNumber]) -> CAKeyframeAnimation {
            
            let animation = CAKeyframeAnimation(keyPath: "transform.scale.y")
            animation.keyTimes = keyTimes
            animation.timingFunctions = timingFunctions
            animation.values = values
            animation.duration = duration
            animation.repeatCount = HUGE
            animation.removedOnCompletion = false
            
            return animation
    }
    
    private func opacityAnimation(duration: CFTimeInterval,
        timingFunctions:[CAMediaTimingFunction],
        keyTimes: [NSNumber],
        values: [NSNumber]) -> CAKeyframeAnimation {
            let animation = CAKeyframeAnimation(keyPath: "opacity")
            animation.duration = duration
            animation.keyTimes = [0, 0.5, 1]
            animation.values = [1, 0.2, 1]
            animation.removedOnCompletion = false
            animation.fillMode = kCAFillModeBoth;
            animation.additive = false
            animation.repeatCount = HUGE
            return animation
    }
}
