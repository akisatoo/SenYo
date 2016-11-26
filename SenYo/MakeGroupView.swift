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

protocol MakeGroupViewDelegate : NSObjectProtocol {
    func pushButton(sender : UIButton)
    func imageTapped( sender: UITapGestureRecognizer ) 
}

class MakeGroupView : UIView, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate{
    var delegate : MakeGroupViewDelegate?
    let aspect = Aspect()
    var groupNumLabel = UILabel()
    private var mySearchBar : UISearchBar!
    var member : [String] = []
    var myTableView: UITableView!
    var groupImage = UIImageView()
    let groupName = UITextField()
    
    required init(){
        super.init(frame : CGRectMake(0, 0, 0, 0))
        self.backgroundColor = UIColor.whiteColor()
        let groupButton = UIButton()
        
        myTableView = UITableView()
        myTableView.hidden = true
        myTableView.registerClass( UITableViewCell.self, forCellReuseIdentifier: "MyCell" )
        myTableView.layer.borderColor = UIColor(white: 0.3, alpha: 0.7).CGColor
        myTableView.layer.borderWidth = 0.3
        myTableView.dataSource = self
        myTableView.delegate = self
        self.myTableView.estimatedRowHeight = 100.0
        self.myTableView.rowHeight = UITableViewAutomaticDimension
        
        groupButton.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 1, alpha: 1)
        groupButton.setTitle(" メンバーを追加 ＋ ", forState: UIControlState.Normal)
        groupButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        groupButton.addTarget( delegate, action: "pushButton:", forControlEvents: .TouchUpInside)
        
        groupButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        groupButton.layer.cornerRadius = 16
        groupNumLabel.text = "メンバー : "
        groupNumLabel.font = UIFont.systemFontOfSize(12)
        groupNumLabel.textAlignment = NSTextAlignment.Center
        
        groupName.delegate = self
        groupName.placeholder = "グループ名を編集"
        groupName.textAlignment = NSTextAlignment.Center
        
        groupImage.layer.cornerRadius = 90 / 2
        groupImage.backgroundColor = UIColor.whiteColor()
        groupImage.layer.borderColor = UIColor.blueColor().CGColor
        groupImage.layer.borderWidth = 2.0
        groupImage.layer.masksToBounds = true
        groupImage.userInteractionEnabled = true
        groupImage.addGestureRecognizer(UITapGestureRecognizer(target: delegate, action: "imageTapped:"))
        
        //addsubview
        self.addSubview(groupButton)
        self.addSubview(groupName)
        self.addSubview(myTableView)
        self.addSubview(groupImage)
        self.addSubview(groupNumLabel)
        
        //autolayout
        myTableView.autoSetDimensionsToSize(CGSizeMake( myBoundSize.width, myBoundSize.height / 2 ))
        myTableView.autoPinEdgeToSuperviewEdge( .Bottom, withInset: 0 )
        groupButton.autoSetDimensionsToSize(CGSizeMake( 180, 36 ))
        groupButton.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: myTableView, withOffset: -30 )
        groupButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: myBoundSize.width / 2 - 90 )
        groupNumLabel.autoSetDimensionsToSize(CGSizeMake(100, 10))
        groupNumLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: groupButton, withOffset: -10 )
        groupNumLabel.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: myBoundSize.width / 2 - 50 )
        groupName.autoSetDimensionsToSize(CGSizeMake( 200, 25 ))
        groupName.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: groupNumLabel, withOffset: -10 )
        groupName.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: myBoundSize.width / 2 - 100 )
        groupImage.autoSetDimensionsToSize(CGSizeMake(90, 90))
        groupImage.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: groupName, withOffset: -20 )
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
        if member.isEmpty {
            myTableView.hidden = true
        }else {
            myTableView.hidden = false
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        let userImageView = UIImageView(image: UIImage(named: "hironaka"))
        let userName = UILabel()
        let commentTextField = UITextField()
        userImageView.frame = CGRectMake( 0, 0 , 66, 66 )
        userImageView.layer.masksToBounds = true
        userImageView.layer.borderColor = UIColor(red: 0.1, green: 1, blue: 1, alpha: 1).CGColor
        userImageView.layer.borderWidth = 2.0
        userImageView.layer.cornerRadius = 33
        userImageView.layer.position = CGPointMake( 60, 40 )
        userName.frame = CGRectMake(0, 0, 100, 20)
        userName.layer.position = CGPointMake(162, 26)
        userName.font = UIFont.systemFontOfSize(15)
        userName.text =  "\(self.member[indexPath.row])"
        commentTextField.frame = CGRectMake(0, 0, 180, 20)
        commentTextField.layer.position = CGPointMake(200, 50)
        commentTextField.textAlignment = .Left
        commentTextField.font = UIFont.systemFontOfSize(12)
        commentTextField.delegate = self
        commentTextField.placeholder = "ここにメッセージを入れる？"
        cell.addSubview(userName)
        cell.addSubview(userImageView)
        cell.addSubview(commentTextField)
        return cell
    }
    
    // tableview cell height size
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cellForHeight : CGFloat = 80
        return cellForHeight
    }
    
    // deleate authorization
    func tableView(tableView: UITableView,canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    // action cells
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleate = UITableViewRowAction(style: .Normal, title: "X\n削除") { action, index in
            self.member.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic
            )
            if self.member.count <= 0 {
                self.myTableView.hidden = true
            }
        }
        deleate.backgroundColor = UIColor.redColor()
        return [deleate]
    }
    
    func reload(){
        self.myTableView.reloadData()
    }
    
    // setMember 
    func setList( member : NSArray ){
        if member != [] {
            self.member += member as! [String]
        }
         self.myTableView.reloadData()
    }
    // ----                 -----
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.endEditing(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}