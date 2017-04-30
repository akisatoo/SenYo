//
//  ConnectModel.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2017/02/05.
//  Copyright © 2017年 takahashi akisato. All rights reserved.
//

import Foundation
import SocketIO
import SwiftyJSON
import Alamofire

struct Connect {
    var group_id: String = ""
    var user_id: String = ""
    var leader_id : String = ""
    var members : NSArray = []
    var message : String = ""
    var calling_flag : Bool = false
    var reactions : NSArray = []
}

class ConnentModel : MyModel{
    private var parent_socket : SocketIOClient?
    public var socket : SocketIOClient{
        get{
            return parent_socket!
        }set{
            parent_socket = newValue
        }
    }
    static var sharedManager: ConnentModel = {
        return ConnentModel()
    }()
    
    private override init() {
        
    }
    
    public func hoge(){
        let socket_url = NSURL(string: "http://localhost:3000")
        let socket = SocketIOClient(socketURL: socket_url!, config: [.Log(true), .ForcePolling(true)])
        // 接続時
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        // 切断時
        socket.on("disconnect") { data in
            print("socket disconnected!!")
        }
        
        socket.on("currentAmount") {data, ack in
            if let cur = data[0] as? Double {
                socket.emitWithAck("canUpdate", cur)(timeoutAfter: 0) {data in
                    socket.emit("update", ["amount": cur + 2.50])
                }
                ack.with("Got your currentAmount", "dude")
            }
        }
        socket.connect()
    }
    
    func send_mes(){
        let socket_url = NSURL(string: "http://localhost:3000")
        let socket = SocketIOClient(socketURL: socket_url!, config: [.Log(true), .ForcePolling(true)])
        self.socket = socket
        
        // 接続時
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        // 切断時
        socket.on("disconnect") { data in
            print("socket disconnected!!")
        }
        //投稿された時
        socket.on("post_mes") {(data, emitter) in
            /* if let message = data as? [String] {
             print(message[0])
             let jsonData : NSData = message[0].dataUsingEncoding(NSUTF8StringEncoding)!
             var err : NSError?
             do{
             //self.postArray = try NSJSONSerialization.JSONObjectWithData(
             //jsonData, options: []) as? NSMutableArray
             }catch let error as NSError {
             err = error
             //self.postArray = nil
             }
             }*/
            print("get : ", data)
        }
        socket.connect()
    }
    
    func reaction(){
        let socket_url = NSURL(string: "http://localhost:3000/group/reaction")
        let socket = SocketIOClient(socketURL: socket_url!, config: [.Log(true), .ForcePolling(true)])
        self.socket = socket
        
        // 接続時
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        // 切断時
        socket.on("disconnect") { data in
            print("socket disconnected!!")
        }
        
        socket.on("reaction") {(data, emitter) in
            if let jsonData = data as? JSON {
                print(jsonData)
               // let jsonData : NSData = jsonData[0].dataUsingEncoding(NSUTF8StringEncoding)!
                var err : NSError?
                do{
                    //self.postArray = try NSJSONSerialization.JSONObjectWithData(
                    //jsonData, options: []) as? NSMutableArray
                }catch let error as NSError {
                    err = error
                    //self.postArray = nil
                }
            }
        }
    }
    
        /*
         // receives message
         self.socket.on("event1", callback: {
         (data:[AnyObject], emitter:SocketAckEmitter) -> Void in
         print("Receive Event1")
         })
         
         // send messages
         let params = ["sender" : "taro", "message" : "おはよう！"]
         self.socket.emit("event1", params)
         */
}