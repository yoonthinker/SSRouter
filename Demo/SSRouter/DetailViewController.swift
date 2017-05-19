//
//  DetailViewController.swift
//  SSRouter
//
//  Created by yst on 2017/5/18.
//  Copyright © 2017年 JRYGHQ. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, SSRouterPushProtocol {

    required convenience init?(_ pattern: SSRouterPattern, _ params: [String : Any]?) {
        self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
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
