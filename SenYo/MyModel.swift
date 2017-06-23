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

class MyModel: NSObject {
    // error count  message
    func errorMessage(res: JSON) -> String {
        var errorMsg = ""
        print("res : ", res["errors"].array?.count )
        if res["errors"].array == nil {
            errorMsg = "\n nil"
        } else {
            for err in res["errors"].array! {
                print(err)
                errorMsg = (errorMsg + "\n" + String(err))
            }
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
    
    func showErrorAlert(error:NSError){
        var title:String!
        var message:String?
        var btnTitle:String!
        if error.localizedFailureReason == nil{
            message = error.localizedDescription
        }else{
            message = error.localizedFailureReason
        }
        if let suggestion = error.localizedRecoverySuggestion {
            title = suggestion
        }else{
            title = "error"
        }
        if let titles = error.localizedRecoveryOptions {
            btnTitle = titles[0]
        }else{
            btnTitle = "OK"
        }
        
        let alertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: btnTitle)
        alertView.show()
    }
}