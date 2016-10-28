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

protocol MemberViewDelegate : NSObjectProtocol{
    func chooseCell(  name : String )
}

class MemberView : UIView, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    var delegate : MemberViewDelegate?
    var myItems: NSArray = ["Member1","Member2","Member3"]
    var searchUsers : NSArray = []
    private var myTableView: UITableView!
    private var myView : UIView!
    private var mySearchBar: UISearchBar!
    var searchResult = [String]()
    
    required init () {
        super.init(frame: CGRectMake(0,0,0,0))
        //self.backgroundColor = UIColor.yellowColor()
        self.backgroundColor = UIColor.whiteColor()
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.blackColor().CGColor
        
        mySearchBar = UISearchBar()
        mySearchBar.delegate = self
        mySearchBar.searchBarStyle = UISearchBarStyle.Prominent
        mySearchBar.showsCancelButton = false
        mySearchBar.enablesReturnKeyAutomatically = false
        mySearchBar.placeholder = "名前を入力してください"
        searchResult = searchUsers as! [String]
        mySearchBar.tintColor = UIColor.blueColor()

        myTableView = UITableView()
        myTableView.registerClass( UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.separatorColor = UIColor.redColor()
        myTableView.dataSource = self
        myTableView.delegate = self
        self.addSubview(myTableView)
        self.addSubview(mySearchBar)
       
    }
    
    func setAutoLayout(){
        // autoLayout
        self.autoSetDimensionsToSize(CGSizeMake( 300, 400 ))
        //myView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: myTableView, withOffset: 20 )
        self.autoPinEdgeToSuperviewEdge(.Top, withInset: 200 )
        self.autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 150 )
        mySearchBar.autoSetDimensionsToSize(CGSizeMake( 295, 30 ))
        mySearchBar.autoPinEdgeToSuperviewEdge(.Top, withInset: 30)
        mySearchBar.autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 185 )
        myTableView.autoSetDimensionsToSize(CGSizeMake( 300, 310 ))
        myTableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: mySearchBar, withOffset: 30 )
        myTableView.autoPinEdgeToSuperviewEdge(.Left, withInset: 0 )
    }
    
    //選択されたCell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        // select cell add image
        let checkImg = UIImageView(image: UIImage( named: "check"))
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell!.addSubview(checkImg)
        checkImg.autoSetDimensionsToSize(CGSizeMake(20, 20))
        checkImg.autoPinEdgeToSuperviewEdge(.Right, withInset: 20 )
        checkImg.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10 )
        self.delegate?.chooseCell(self.myItems[indexPath.row] as! String)
    }
    
    //Cellの総数を返すデータソースメソッド.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResult.count
    }
    
    //Cellに値を設定するデータソースメソッド.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        cell.textLabel!.text = "\(self.searchResult[indexPath.row])"
        cell.textLabel?.font = UIFont.systemFontOfSize(12)
        cell.backgroundColor = UIColor.clearColor()
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}