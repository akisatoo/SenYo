//
//  NoticeModel.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/12/26.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Notice {
    var user_id : String!
}

class NoticeModel : MyModel {
    static var sharedManager: NoticeModel = {
        return NoticeModel()
    }()
    
    private override init() {}
    
    func createGroup(data: Notice, success: (JSON) -> Void, error: (JSON) -> Void) {
        let params = [
            "name": data.user_id,
            ]
    
        Alamofire.request(.GET, "http://127.0.0.1:3000/api/notice/", parameters: params ).responseJSON{ response in
            guard let object = response.result.value else {
                return
            }
            
            let res = JSON(object)
            print("res : " , res )
            if res["status"] == "success" {
                success(res)
                return;
            }
            
            //Error時のコールバック
            error(res)
        }
    }

}