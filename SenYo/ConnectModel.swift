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



class ConnentModel : MyModel{
    static var sharedManager: ConnentModel = {
        return ConnentModel()
    }()
    
    private override init() {
    }
    
    func hoge(){
        
        let socket = SocketIOClient(socketURL: NSURL(string: "http://localhost:3000")!, config: [.Log(true), .ForcePolling(true)])
        
        // 受信
        socket.on("connect") {data, ack in
            print("socket connected")
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