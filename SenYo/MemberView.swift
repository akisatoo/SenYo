//
//  MemberView.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/09/05.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import SwiftyJSON
import Alamofire

protocol MemberViewDelegate : NSObjectProtocol{
}

class MemberView : UIView, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    var delegate : MemberViewDelegate?
    var myItems : NSArray = ["坂井まどか", "松江飛雄馬", "高橋秋里", "User1", "User2", "User3"]             //User情報
    var selectUser : [String] = []
    var searchUsers : NSArray = []
    var searchResult = [String]()
    private var myTableView: UITableView!
    private var myView : UIView!
    private var mySearchBar: UISearchBar!
    let textLabel = UILabel()
    let addUserIconImg = UIImage(named: "addUser")
    let userTag = 11
    
    required init () {
        super.init(frame: CGRectMake(0,0,0,0))
        
        self.backgroundColor = UIColor.whiteColor()
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor(white: 1.0, alpha: 0.4).CGColor
    
        mySearchBar = UISearchBar()
        mySearchBar.delegate = self
        mySearchBar.searchBarStyle = UISearchBarStyle.Prominent
        mySearchBar.translucent = true
        mySearchBar.layer.borderWidth = 1.0
        mySearchBar.layer.borderColor = UIColor(red: 0.1, green: 1, blue: 1, alpha: 1).CGColor
        mySearchBar.layer.cornerRadius = 20.0
        mySearchBar.tintColor = .whiteColor()
        mySearchBar.barTintColor = .whiteColor()
        mySearchBar.backgroundColor = .whiteColor()
        mySearchBar.showsCancelButton = false
        mySearchBar.enablesReturnKeyAutomatically = false
        mySearchBar.placeholder = "名前を入力してください"
        
        textLabel.text = "もしかして？"
        textLabel.textColor = .blackColor()
        textLabel.font = UIFont.systemFontOfSize(15)
        textLabel.textAlignment = .Center
        searchResult = searchUsers as! [String]
        
        myTableView = UITableView()
        myTableView.registerClass( UITableViewCell.self, forCellReuseIdentifier: "MyCell" )
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.layer.cornerRadius = 10.0
        myTableView.layer.borderColor = UIColor.blackColor().CGColor
        myTableView.rowHeight = 70
        //
        self.addSubview(myTableView)
        self.addSubview(mySearchBar)
        self.addSubview(textLabel)
    }
    
    func setAutoLayout(){
        // autoLayout
        self.autoSetDimensionsToSize(CGSizeMake( 320, 350 ))
        self.autoPinEdgeToSuperviewEdge(.Top, withInset: 150 )
        self.autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 160 )
        mySearchBar.autoSetDimensionsToSize(CGSizeMake( 256, 40 ))
        mySearchBar.autoPinEdgeToSuperviewEdge(.Top, withInset: 30)
        mySearchBar.autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 156 )
        textLabel.autoSetDimensionsToSize(CGSizeMake(100, 50))
        textLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: mySearchBar,withOffset : 5 )
        textLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 75)
        myTableView.autoSetDimensionsToSize(CGSizeMake( 300, 200 ))
        myTableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: textLabel, withOffset: 5 )
        myTableView.autoPinEdgeToSuperviewEdge(.Left, withInset: 0 )
    }
    
    // 選択されたCell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let addUserIcon = cell!.viewWithTag(userTag) as! UIImageView
        // select cell add image
        let checkString = ( addUserIcon.image != UIImage(named: "addUser") ) ? "addUser" : "addUser_on"
        let checkImg = UIImage( named: checkString )
        addUserIcon.image! = checkImg!
        self.selectUser.append(self.searchResult[indexPath.row])
    }
    
    //Cellの総数を返すデータソースメソッド.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResult.count
    }
    
    //Cellに値を設定するデータソースメソッド.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        let userName = UILabel()
        let userImageView = UIImageView(image: UIImage(named: "hironaka"))
        let cellSelectedBgView = UIView()
        let addUserIcon = UIImageView(image: addUserIconImg)
        userImageView.frame = CGRectMake( 0, 0 , 58, 58 )
        userImageView.layer.masksToBounds = true
        userImageView.layer.borderColor = UIColor(red: 0.1, green: 1, blue: 1, alpha: 1).CGColor
        userImageView.layer.borderWidth = 2.0
        userImageView.layer.cornerRadius = 29
        userImageView.layer.position = CGPointMake( 60, 36 )
        userName.frame = CGRectMake(0, 0, 100, 20)
        userName.layer.position = CGPointMake(162, 35)
        userName.font = UIFont.systemFontOfSize(15)
        userName.text =  "\(self.searchResult[indexPath.row])"
        addUserIcon.contentMode = .ScaleAspectFit
        addUserIcon.tag = userTag
        cellSelectedBgView.backgroundColor = UIColor.clearColor()
        cell.selectedBackgroundView = cellSelectedBgView
        cell.addSubview(userName)
        cell.addSubview(userImageView)
        cell.addSubview(addUserIcon)
        addUserIcon.autoSetDimensionsToSize(CGSizeMake( 24, 24 ))
        addUserIcon.autoPinEdgeToSuperviewEdge(.Right, withInset: 20 )
        addUserIcon.autoPinEdgeToSuperviewEdge(.Top, withInset: 24 )
        return cell
    }
    
    // SearchBar
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        mySearchBar.endEditing(true)
        searchResult.removeAll()
        if(mySearchBar.text == "") {
            searchResult = searchUsers as! [String]
        } else {
            for data in myItems {
                if data.containsString(mySearchBar.text!) {
                    searchResult.append(data as! String)
                }
            }
        }
        //テーブルを再読み込みする。
        myTableView.reloadData()
    }
    
    // serchbar cansel button action
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        //searchBar.showsCancelButton = false
        searchResult.removeAll()
        searchBar.resignFirstResponder()
        myTableView.reloadData()
    }
    
    // get members
    func getList() -> [String] {
        return self.selectUser
    }
    // ----
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