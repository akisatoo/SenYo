//
//  NewsViewController.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/09/02.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit

class NewsViewController : UIViewController, NewsViewDelegate {
   
    //
    override func viewDidLoad() {
        let newsView = NewsView()
        super.viewDidLoad()
        self.view = newsView
        newsView.delegate = self
        self.title = "News"
    }
    //
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    func moveViews( num : Int ){
        switch( num ){
        case 1:
            //let myView = MakeGroupViewController()
            //self.navigationController?.pushViewController(myView, animated: true)
            break
        default:
            break
        }
    }
}