//
//  OrderViewController.swift
//  SSRouter
//
//  Created by yst on 2017/5/18.
//  Copyright © 2017年 JRYGHQ. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    @IBAction func detailBtnClicked(_ sender: Any) {
        SSRouter.push("/order/detail", nil)
    }

    @IBAction func alertBtnClicked(_ sender: Any) {
        SSRouter.execute("/show/alert?title=%e4%b9%94%e6%b2%bb%e5%b0%86%e5%86%9b#fuck=fuck",["message":"谁人曼巴风骨？印城乔治将军！"])
    }
    @IBOutlet weak var detailBtnClicked: UIButton!
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
