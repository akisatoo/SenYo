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
    private var myTableView: UITableView!
    private var myView : UIView!
    private var mySearchBar: UISearchBar!
    var searchResult = [String]()
    
    required init () {
        super.init(frame: CGRectMake(0,0,0,0))
        self.backgroundColor = UIColor.yellowColor()
        
        mySearchBar = UISearchBar()
        mySearchBar.delegate = self
        mySearchBar.frame = CGRectMake(0, 0, myBoundSize.width, 80)
        mySearchBar.showsCancelButton = true
        mySearchBar.enablesReturnKeyAutomatically = false
        mySearchBar.layer.position = CGPoint(x: myBoundSize.width/2, y: 100)
        searchResult = myItems as! [String]

        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height +  mySearchBar.frame.height
        let displayWidth: CGFloat = myBoundSize.width
        let displayHeight: CGFloat = myBoundSize.height
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.registerClass( UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.separatorColor = UIColor.blueColor()
        myTableView.dataSource = self
        myTableView.delegate = self
        self.addSubview(myTableView)
        self.addSubview(mySearchBar)
    }
    
    //選択されたCell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
       // print("Num: \(indexPath.row)")
       // print("Value: \(self.myItems[indexPath.row])")
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
        let myButton = UIButton( frame: CGRectMake( 0, 0, 30, 30 ))
        myButton.layer.cornerRadius = myButton.frame.width / 2
        myButton.backgroundColor = UIColor.blueColor()
        cell.addSubview(myButton)
        myButton.layer.position = CGPointMake( myBoundSize.width - 50, 20 )
        // 背景色
        /*cell.backgroundColor = UIColor.clearColor()
        // 選択された時の背景色
        let cellSelectedBgView = UIView()
        cellSelectedBgView.backgroundColor = UIColor.redColor()
        cell.selectedBackgroundView = cellSelectedBgView
        */
        return cell
    }
    
    // SearchBar
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        mySearchBar.endEditing(true)
        searchResult.removeAll()
        if(mySearchBar.text == "") {
            searchResult = myItems as! [String]
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