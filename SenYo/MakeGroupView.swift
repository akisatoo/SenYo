//
//  MakeGroupView.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/09/03.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import SimpleAnimation

struct Group {
    var image = [UIImage]()
    var name : [String] = []
    var description : [String] = []
}

protocol MakeGroupViewDelegate : NSObjectProtocol {
    func pushButton(sender : UIButton)
}

class MakeGroupView : UIView, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate{
    var delegate : MakeGroupViewDelegate?
    let aspect = Aspect()
    var groupNumLabel = UILabel()
    //var myView : UIView = MemberView()
    private var mySearchBar : UISearchBar!
    var member : NSArray = ["Member1","Member2","Member3"]
    private var myTableView: UITableView!
    
    required init(){
        super.init(frame : CGRectMake(0, 0, 0, 0))
        self.backgroundColor = UIColor.whiteColor()
        let groupButton = UIButton()
        let myTextField = UITextField()
        let groupImage = UIImageView()
        
        myTableView = UITableView()
        myTableView.registerClass( UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.separatorColor = UIColor.blueColor()
        myTableView.dataSource = self
        myTableView.delegate = self
        self.myTableView.estimatedRowHeight = 100.0
        self.myTableView.rowHeight = UITableViewAutomaticDimension
        
        groupButton.backgroundColor = UIColor.cyanColor()
        groupButton.setTitle(" メンバーを追加 + ", forState: UIControlState.Normal)
        groupButton.addTarget( delegate, action: "pushButton:", forControlEvents: .TouchUpInside)
        
        groupButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        groupButton.layer.cornerRadius = 10
        groupNumLabel.text = "メンバー : "
        groupNumLabel.font = UIFont.systemFontOfSize(10)
        
        myTextField.delegate = self
        myTextField.placeholder = "グループ名を編集"
        myTextField.borderStyle = UITextBorderStyle.RoundedRect
        
        groupImage.layer.cornerRadius = 90 / 2
        groupImage.backgroundColor = UIColor.whiteColor()
        groupImage.layer.borderColor = UIColor.blueColor().CGColor
        groupImage.layer.borderWidth = 2.0
        groupImage.layer.masksToBounds = true
        
        //addsubview
        self.addSubview(groupButton)
        self.addSubview(myTextField)
        self.addSubview(myTableView)
        self.addSubview(groupImage)
        self.addSubview(groupNumLabel)
        
        //autolayout
        myTableView.autoSetDimensionsToSize(CGSizeMake( myBoundSize.width, myBoundSize.height / 2 ))
        myTableView.autoPinEdgeToSuperviewEdge( .Bottom, withInset: 0 )
        groupButton.autoSetDimensionsToSize(CGSizeMake( 150, 30 ))
        groupButton.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: myTableView, withOffset: -20 )
        groupButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: myBoundSize.width / 2 - 75 )
        groupNumLabel.autoSetDimensionsToSize(CGSizeMake(100, 10))
        groupNumLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: groupButton, withOffset: -10 )
        groupNumLabel.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: myBoundSize.width / 2 - 50 )
        myTextField.autoSetDimensionsToSize(CGSizeMake( 200, 25 ))
        myTextField.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: groupNumLabel, withOffset: 0 )
        myTextField.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: myBoundSize.width / 2 - 100 )
        groupImage.autoSetDimensionsToSize(CGSizeMake(90, 90))
        groupImage.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: myTextField, withOffset: -20 )
        groupImage.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: myBoundSize.width / 2 - 45 )
    }
    
    // select cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        // print("Num: \(indexPath.row)")
        // print("Value: \(self.myItems[indexPath.row])")
    }
    
    //Cellの総数を返すデータソースメソッド.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupNumLabel.text = "メンバー : \(self.member.count)"
        return self.member.count
    }
    
    //Cellに値を設定するデータソースメソッド.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let userImageView = UIImageView(image: UIImage(named: "hironaka"))
        let userName = UILabel()
        
        userImageView.frame = CGRectMake(0, 0 , 64, 64 )
        userImageView.layer.masksToBounds = true
        userImageView.layer.borderColor = UIColor(red: 0.1, green: 1, blue: 1, alpha: 1).CGColor
        userImageView.layer.borderWidth = 2.0
        userImageView.layer.cornerRadius = 32
        userImageView.layer.position = CGPointMake( 60, 35 )
        userName.frame = CGRectMake(0, 0, 100, 20)
        userName.layer.position = CGPointMake(200, 40)
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
       // cell.textLabel!.text = "\(self.member[indexPath.row])"
        userName.text =  "\(self.member[indexPath.row])"
        cell.addSubview(userName)
        cell.addSubview(userImageView)
        
        return cell
    }
    
    // tableview cell height size
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cellForHeight : CGFloat = 70
        return cellForHeight
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}