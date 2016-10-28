//
//  GradientLayer.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/10/28.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit

class GradientLayer : CAGradientLayer {
    override init( ) {
        super.init()
        
    }
    internal func blueColor(){
        let color1 = UIColor(red: 0.4, green: 0.7, blue: 0.9, alpha: 1.0).CGColor as CGColorRef
        let color2 = UIColor(red: 0.1, green: 0.5, blue: 0.8, alpha: 1.0).CGColor as CGColorRef
        let color3 = UIColor.whiteColor().CGColor
        self.colors = [color1, color2,color3]
        self.startPoint = CGPointMake(0, 0);
        self.endPoint = CGPointMake(1.0, 0.8);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}