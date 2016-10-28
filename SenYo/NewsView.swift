//
//  NewsView.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/09/02.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit

protocol NewsViewDelegate : NSObjectProtocol {
    func moveViews( num : Int )
}

class NewsView : UIView, UITableViewDataSource, UITableViewDelegate {
    private var myTableView : UITableView!
    var delegate : NewsViewDelegate?
    private let myItem : NSArray = [ "弘中研究室", "飲み会", "Swift同好会"]
    //
    required init () {
        super.init( frame : CGRectMake(0,0, 0, 0))
        self.backgroundColor = UIColor.blackColor()
        let displayWidth: CGFloat = myBoundSize.width
        let displayHeight: CGFloat = myBoundSize.height
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.addSubview(myTableView)
    }
    //
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    //総数を返す
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       // print("Num: \(indexPath.row)")
        //print("Value: \(self.myItem[indexPath.row])")
        self.delegate?.moveViews(indexPath.row)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myItem.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        let groupName = UILabel()
        //let descriptionLabel = UILabel()
        let imageView = UIImageView(image: UIImage(named: "hironaka"))
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        groupName.text = "\(self.myItem[indexPath.row])"
        cell.backgroundColor = .whiteColor()
        cell.addSubview(groupName)
        cell.addSubview(imageView)
        imageView.autoSetDimensionsToSize(CGSizeMake(50, 50))
        imageView.autoPinEdgeToSuperviewEdge(.Left, withInset: 20 )
        imageView.autoPinEdgeToSuperviewEdge(.Top, withInset: 10 )
        groupName.autoPinEdgeToSuperviewEdge(.Top, withInset: 20 )
        groupName.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: 20 )
        
        return cell
    }
    
    //cells height setting
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cellForHeight : CGFloat = 70
        return cellForHeight
    }
    

}