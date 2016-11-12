//
//  GroupModel.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/11/12.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Group {
    var id: String = ""
    var name: String = ""
    var leader_id : String = ""
    var members : NSArray = []
    var message : String = ""
    var calling_flag : Bool = false
    var reactions : NSArray = []
}

class GroupModel: MyModel {
    
    static var sharedManager: GroupModel = {
        return GroupModel()
    }()
    
    private override init() {}
    
    
    func createGroup(data: Group, success: (JSON) -> Void, error: (JSON) -> Void) {
        let params = [
            "name": data.name,
            "leader_id": data.leader_id,
            "members": data.members
        ]
        
        Alamofire.request(.POST, "http://127.0.0.1:3000/api/group/", parameters: params ).responseJSON{ response in
            guard let object = response.result.value else {
                return
            }
            
            let res = JSON(object)
            print(res)
            if res["status"] == "success" {
                success(res)
                return;
            }
            
            //Error時のコールバック
            error(res)
        }
    }
    
    func create(data: Group, success: (JSON) -> Void, error: (JSON) -> Void) {
        let params = [
            "group_id" : data.id,
            "name": data.name,
            "leader_id": data.leader_id,
            "members": data.members
        ]
        
        Alamofire.request(.POST, "http://127.0.0.1:3000/api/user/grop_create/", parameters: params ).responseJSON{ response in
            guard let object = response.result.value else {
                return
            }
            
            let res = JSON(object)
            if res["status"] == "success" {
                success(res)
                return;
            }
            
            //Error時のコールバック
            error(res)
            
        }
    }
    
}

