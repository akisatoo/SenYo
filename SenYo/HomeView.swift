//
//  HomeView.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/08/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//


import UIKit
import PureLayout
import SimpleAnimation

protocol HomeViewDelegate: NSObjectProtocol {
    func clickButton( sender : UIBarButtonItem )
}

class HomeView: UIView, UITableViewDelegate, UITableViewDataSource{
    
    var delegate: HomeViewDelegate?
    private var cellMeneuView : UIView = UIView()
    private var myTableView = UITableView()
    private var userArray : [[UIImageView]] = [[UIImageView]]()
    var itemArray : NSArray = ["お知らせ","ユーザ編集","ログアウト"]
    var itemNames : NSArray = ["bell", "gear", "door"]
    var aspect = Aspect()
    
    required init() {
        super.init(frame: CGRectMake(0, 0, 0, 0));
        self.backgroundColor = UIColor.whiteColor()
        let myImage = UIImage(named: "hironaka")
        let leader = UIImageView()
        //let balloon = BalloonView(frame: CGRectMake((myBoundSize.width - 280) / 2, 100, 280, 100))
        let views = UIView(frame: CGRectMake( 0, 0, 500 * aspect.xAspect(), 500 * aspect.yAspect() ))
        let myScrollView = UIScrollView()
        let leaderSize = 100 * aspect.yAspect()
        leader.layer.cornerRadius = leaderSize / 2
        leader.backgroundColor = UIColor.whiteColor()
        leader.layer.borderColor = UIColor.blueColor().CGColor
        leader.layer.borderWidth = 2.0
        leader.layer.masksToBounds = true
        leader.image = myImage
        myScrollView.backgroundColor = UIColor.whiteColor()
        
        cellMeneuView.backgroundColor = UIColor.whiteColor()
        cellMeneuView.layer.cornerRadius = 20
        cellMeneuView.layer.masksToBounds = true
        //cellMeneuView.layer.borderColor = UIColor.blackColor().CGColor
        //cellMeneuView.layer.borderWidth = 5.0
        myTableView.registerClass( UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        //myTableView.separatorColor = UIColor.redColor()
        myTableView.dataSource = self
        myTableView.delegate = self
        // balloon.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(myScrollView)
        // User 配置
        for i in 0...6 {
            userArray.append([])
            for j in 0...2 {
                var xWidth = 30
                let userSize = 70 * aspect.yAspect()
                let myImageView = UIImageView()
                let userName = UILabel(frame: CGRectMake( 0, 0, 100 * aspect.xAspect(), 50  * aspect.yAspect() ))
                userName.text = "name"
                //myImageView.image = myImage
                myImageView.layer.cornerRadius = userSize / 2
                userArray[i].append(myImageView)
                if j % 2 != 0  {
                    xWidth = 100
                }
                userArray[i][j].backgroundColor = UIColor.whiteColor()
                userArray[i][j].layer.borderColor = UIColor.redColor().CGColor
                userArray[i][j].layer.borderWidth = 2.0
                userArray[i][j].layer.masksToBounds = true
                myScrollView.addSubview( userArray[i][j] )
                myScrollView.addSubview( userName )
                userArray[i][j].autoSetDimensionsToSize( CGSizeMake( userSize, userSize ) )
                userArray[i][j].autoPinEdgeToSuperviewEdge( .Top, withInset:  CGFloat(  -45 + 90 * j  ) * aspect.yAspect() )
                userArray[i][j].autoPinEdgeToSuperviewEdge( .Left, withInset: CGFloat( xWidth + 150 * i ) * aspect.xAspect())
                userName.autoPinEdgeToSuperviewEdge( .Top, withInset: CGFloat( 30 + 90 * j ) * aspect.yAspect() )
                userName.autoPinEdgeToSuperviewEdge( .Left, withInset: CGFloat(xWidth + 10 + 150 * i) * aspect.xAspect() )
            }
        }
        // Scrollできる幅の設定
        myScrollView.contentSize = CGSizeMake( ( CGFloat(userArray[0].count ) * (CGFloat(userArray.count) * 52) ) * aspect.xAspect(), myScrollView.frame.size.height * aspect.yAspect() )
        
        //addsubview
        self.addSubview(views)
        self.addSubview(cellMeneuView)
        self.cellMeneuView.addSubview(myTableView)
        views.addSubview(leader)
        //views.addSubview(balloon)
        
        //autolayout
        views.autoPinEdgeToSuperviewEdge(.Top, withInset : 34 )
        views.autoPinEdge(.Bottom, toEdge: .Top, ofView: myScrollView, withOffset: 0)
        leader.autoSetDimensionsToSize( CGSizeMake( leaderSize, leaderSize ))
        leader.autoCenterInSuperview()
        leader.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset:  ( myBoundSize.width / 2 - leaderSize / 2 )  )
        myScrollView.autoSetDimensionsToSize( CGSizeMake(myBoundSize.width, myBoundSize.height / 2 ))
        myScrollView.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 35 * aspect.yAspect())
        cellMeneuView.autoSetDimensionsToSize(CGSizeMake(150, 150))
        cellMeneuView.autoPinEdgeToSuperviewEdge(.Right, withInset : 10)
        cellMeneuView.autoPinEdgeToSuperviewEdge(.Top, withInset : 65)
        myTableView.autoSetDimensionsToSize(CGSizeMake(140, 140))
        myTableView.autoPinEdgeToSuperviewEdge(.Right, withInset : 10)
        myTableView.autoPinEdgeToSuperviewEdge(.Top, withInset : 10)
        
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //選択されたCell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //self.delegate?.chooseCell(self.itemArray[indexPath.row] as! String)
    }
    
    //Cellの総数を返すデータソースメソッド.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemArray.count
    }
    
    //Cellに値を設定するデータソースメソッド.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        let textLabel = UILabel()
        textLabel.text = self.itemArray[indexPath.row] as! String
        let imageViews = UIImageView(image : UIImage( named: itemNames[indexPath.row] as! String))
        cell.backgroundColor = UIColor.clearColor()
        cell.addSubview(textLabel)
        cell.addSubview(imageViews)
        textLabel.autoPinEdgeToSuperviewEdge(.Top, withInset : 10 )
        textLabel.autoPinEdgeToSuperviewEdge(.Left, withInset : 50 )
        imageViews.autoSetDimensionsToSize(CGSizeMake(18, 18))
        imageViews.autoPinEdgeToSuperviewEdge(.Top, withInset : 12 )
        imageViews.autoPinEdgeToSuperviewEdge(.Left, withInset : 15 )
        //cell.textLabel!.text = "\(self.itemArray[indexPath.row])"
        //cell.textLabel?.font = UIFont.systemFontOfSize(18)
        
       // print(cell.textLabel!.text )
        return cell
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}