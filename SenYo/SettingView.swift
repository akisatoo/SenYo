//
//  File.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/08/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit

protocol SettingViewDelegate : NSObjectProtocol {
    func moveViews( num : Int )
    
}

class SettingView : UIView , UITableViewDataSource, UITableViewDelegate{
    var delegate : SettingViewDelegate?
    var myItems: NSArray = ["ログ","グループ作成","プロフィール編集"]
    private var myTableView: UITableView!
    private var myView : UIView!
    
    required init () {
        super.init(frame: CGRectMake(0,0,0,0))
        self.backgroundColor = UIColor.yellowColor()
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        let displayWidth: CGFloat = myBoundSize.width
        let displayHeight: CGFloat = myBoundSize.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.addSubview(myTableView)
    }
    
    //Cellの総数を返す
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(self.myItems[indexPath.row])")
        self.delegate?.moveViews(indexPath.row)
    }
    
    //Cellの総数を返すデータソースメソッド.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myItems.count
    }
    
    //Cellに値を設定するデータソースメソッド.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        cell.textLabel!.text = "\(self.myItems[indexPath.row])"
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}