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
    var self_id : String = ""
}

class GroupModel: MyModel {
    
    static var sharedManager: GroupModel = {
        return GroupModel()
    }()
    
    private override init() {}
    
    /*
     * 新規グループの作成
     */
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
            if res["status"] == "success" {
                success(res)
                return;
            }
            
            //Error時のコールバック
            error(res)
        }
    }
    
    // グループ情報を取得
    func getGroup(data: String, success: (JSON) -> Void, error: (JSON) -> Void) {
        let params : [String : String] = [
            "user_id" : data
        ]
        
        Alamofire.request( .GET, "http://127.0.0.1:3000/api/group/list/", parameters: params ).responseJSON{ response in
            guard let object = response.result.value else {
                return
            }
            
            
            let res = JSON(object)
            print("--- getGroup ---")
            print("res : ", res)
            if res["status"] == "success" {
                success(res)
                return
            }
            //Error時のコールバック
            error(res)
        }
    }
    
    // グループを削除
    func deleteGroup(data: Group, success: (JSON) -> Void, error: (JSON) -> Void) {
        let params = [
            "group_id": data.id,
        ]
        
        Alamofire.request(.POST, "http://127.0.0.1:3000/api/group/delete", parameters: params ).responseJSON{ response in
            guard let object = response.result.value else {
                return
            }
            
            let res = JSON(object)
            print("--- deleteGroup ---")
            print("res : " , res )
            if res["status"] == "success" {
                success(res)
                return;
            }
            
            //Error時のコールバック
            error(res)
        }
    }
    
    // グループ情報を編集
    func editGroup(data: Group, success: (JSON) -> Void, error: (JSON) -> Void) {
        let params = [
            "name": data.name,
            "add_members" : data.members,
            "remove_members" : data.members
        ]
        
        Alamofire.request(.POST, "http://127.0.0.1:3000/api/group/edit/", parameters: params ).responseJSON{ response in
            guard let object = response.result.value else {
                return
            }
            
            let res = JSON(object)
            print("--- editGroup ---")
            print("res : " , res )
            if res["status"] == "success" {
                success(res)
                return;
            }
            //Error時のコールバック
            error(res)
        }
    }
    
    // 通知
    func calling(data: Group, success: (JSON) -> Void, error: (JSON) -> Void) {
        let params = [
            "group_id": data.id
        ]
        
        Alamofire.request(.POST, "http://127.0.0.1:3000/api/group/calling/", parameters: params ).responseJSON{ response in
            guard let object = response.result.value else {
                return
            }
            
            let res = JSON(object)
            print("--- calling ---")
            print("res : " , res )
            if res["status"] == "success" {
                success(res)
                return;
            }
            
            //Error時のコールバック
            error(res)
        }
    }
    
    // 通知完了
    func calling_Finish(data: Group, success: (JSON) -> Void, error: (JSON) -> Void) {
        let params = [
            "group_id": data.id
        ]
        
        Alamofire.request(.POST, "http://127.0.0.1:3000/api/group/calling_finish/", parameters: params ).responseJSON{ response in
            guard let object = response.result.value else {
                return
            }
            
            let res = JSON(object)
            print("--- calling_Finish ---")
            print("res : " , res )
            if res["status"] == "success" {
                success(res)
                return;
            }
            
            //Error時のコールバック
            error(res)
        }
    }
    
    
    // 返信
    func reaction(data: Group, success: (JSON) -> Void, error: (JSON) -> Void) {
        let params = [
            "group_id": data.id,
        ]
        
        Alamofire.request(.POST, "http://127.0.0.1:3000/api/group/reaction", parameters: params ).responseJSON{ response in
            guard let object = response.result.value else {
                return
            }
            
            let res = JSON(object)
            print("--- reaction ---")
            print("res : " , res )
            if res["status"] == "success" {
                success(res)
                return;
            }
            
            //Error時のコールバック
            error(res)
        }
    }
    
    // グループ参加を承認
    func approval(data: Group, success: (JSON) -> Void, error: (JSON) -> Void) {
        let params = [
            "group_id": data.id,
            "user_id": data.self_id
        ]
        
        Alamofire.request(.POST, "http://127.0.0.1:3000/api/group/approval", parameters: params ).responseJSON{ response in
            guard let object = response.result.value else {
                return
            }
            
            let res = JSON(object)
            print("--- approval ---")
            print("res : " , res )
            if res["status"] == "success" {
                success(res)
                return;
            }
            
            //Error時のコールバック
            error(res)
        }
    }
    
    // グループを抜ける
    func escape(data: Group, success: (JSON) -> Void, error: (JSON) -> Void) {
        let params = [
            "group_id": data.id,
            "user_id": data.self_id
        ]
        
        Alamofire.request(.POST, "http://127.0.0.1:3000/api/group/escape", parameters: params ).responseJSON{ response in
            guard let object = response.result.value else {
                return
            }
            
            let res = JSON(object)
            print("--- escape ---")
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

