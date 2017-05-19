//
//  HomeViewController.swift
//  SSRouter
//
//  Created by yst on 2017/5/18.
//  Copyright © 2017年 JRYGHQ. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    @IBAction func goodsBtnClicked(_ sender: Any) {
        SSRouter.execute("ssrouter://\(SSRouter.pagePush):0/home/goods", nil)
        
    }
    
    @IBAction func detailBtnClicked(_ sender: Any) {
        SSRouter.execute("ssrouter://\(SSRouter.pagePush):1/order/detail", nil)
    }
    
    @IBAction func presentBtnClicked(_ sender: Any) {
        SSRouter.present("/home/present", ["title":"乔治将军"])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
