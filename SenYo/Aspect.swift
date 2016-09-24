//
//  Aspect.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/09/16.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit

class Aspect{
    private let deviceSize : CGSize = UIScreen.mainScreen().bounds.size
    // standerd Aspect iPhone6
    private let standerdAspectHeight : CGFloat = 667
    private let standerdAspectWidth : CGFloat = 375
    
    private func euclid( var size : CGFloat ) -> CGFloat{
        if  size != deviceSize.width {
            if size != standerdAspectHeight {
                size /= standerdAspectHeight
            }
        }else{
            if size != standerdAspectWidth {
                size /= standerdAspectWidth
            }
        }
        return size
    }
    
    func yAspect() -> CGFloat{
        var mySize : CGFloat!
        mySize = deviceSize.height / standerdAspectHeight
        return mySize
    }
    
    func xAspect()->CGFloat{
        let xAspect = deviceSize.width / standerdAspectWidth
        return xAspect
    }
}