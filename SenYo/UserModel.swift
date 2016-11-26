//
//  UserModel.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/09/25.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct User {
    var id: String = ""
    var name: String = ""
    var password: String = ""
    var account_id: String = ""
    var image: String = ""
}

class UserModel: MyModel {
    
    static var sharedManager: UserModel = {
        return UserModel()
    }()
    
    private override init() {}
    
    func login(data: User, success: (JSON) -> Void, error: (JSON) -> Void) {
        let params = [
            "password": data.password,
            "account_id": data.account_id
        ]
        
        Alamofire.request(.POST, "http://127.0.0.1:3000/api/user/login/", parameters: params).responseJSON{ response in
            guard let object = response.result.value else {
                return
            }
            
            let res = JSON(object)
            print("login : " , res )
            if res["status"] == "success" {
                success(res)
                return;
            }
            
            //Error時のコールバック
            error(res)
            
        }
    }
    
    func createUser(data: User, success: (JSON) -> Void, error: (JSON) -> Void) {
        let params = [
            "name": data.name,
            "password": data.password,
            "account_id": data.account_id,
            "image": data.image
        ]
        
        Alamofire.request(.POST, "http://127.0.0.1:3000/api/user/", parameters: params).responseJSON{ response in
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
    
    func userEdit(data: User, success: (JSON) -> Void, error: (JSON) -> Void) {
        let params = [
            "id": data.id,
            "password": data.password,
            "name": data.name,
            "image": data.image
        ]
        
        Alamofire.request(.POST, "http://127.0.0.1:3000/api/user/edit/", parameters: params).responseJSON{ response in
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
    
    func userSearch(data: User, success: (JSON) -> Void, error: (JSON) -> Void) {
        let params = [
            "account_id": data.account_id
        ]
        
        Alamofire.request(.GET, "http://127.0.0.1:3000/api/user/search/", parameters: params).responseJSON{ response in
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