//
//  MyModel.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/09/25.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class Model: NSObject {
    
    func errorMessage(res: JSON) -> String {
        var errorMsg = ""
        for err in res["errors"].array! {
            print(err)
            errorMsg = (errorMsg + "\n" + String(err))
        }
        
        return errorMsg
    }
    
    func errorAlert(res: JSON) -> UIAlertController {
        let alert:UIAlertController = UIAlertController(title: "SenYo!",
            message: self.errorMessage(res) ?? "通信エラーです",
            preferredStyle: UIAlertControllerStyle.Alert)
        let cancelAction:UIAlertAction = UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction!) -> Void in
        })
        alert.addAction(cancelAction)
        return alert
    }
    
}