//
//  SSRouterUtility.swift
//  Sunshine
//
//  Created by yst on 2017/5/17.
//  Copyright © 2017年 jryghq. All rights reserved.
//

import UIKit

class SSRouterFetch: NSObject {
    
    //mode of jump to the new the page
    enum SSRouterPageMode {
        case push, modal
    }
    
    //mode of action
    //you can expand the type of action flexible
    enum SSRouterActionMode: Int {
        case net
    }
    
    //the type of routing operation
    enum SSRouterOperation {
        case page(SSRouterPageMode), action(SSRouterActionMode), unknow
    }
    
    //result of fetched from pattern
    struct FetchResult {
        
        //operation from pattern url's host
        var operation: SSRouterOperation = .unknow
        
        //parameters from pattern url's query|gragment
        var params: [String: Any]?
    }
    
    //parsing the pattern
    static func fetch(_ pattern: SSRouterPattern,_ params: [String: Any]? = nil) -> FetchResult {
        
        var parameters = [String: Any]()
        
        if params != nil { parameters += params! }
        
        var operation: SSRouterOperation = .unknow
        
        if let host = pattern.pHost {
            switch host {
            case SSRouter.pagePush:
                operation = .page(.push)
                break
            case SSRouter.pageModal:
                operation = .page(.modal)
                break
            case SSRouter.actionNet:
                operation = .action(.net)
            default:
                operation = .unknow
                break
            }
        }
        
        if let query = pattern.pQuery  {
            parameters += fetchParams(query)
        }
        
        if let fragment = pattern.pFragment {
            parameters += fetchParams(fragment)
        }
      
        let result = FetchResult(operation: operation, params: parameters)
        return result
    }
    
    //fetch query parameters
    //name=testname&age=testage -> {"name":"testname","age":"testage"}
    //name=testname&age=testage&address= -> {"name":"testname","age":"testage","address":""}
    static func fetchParams(_ string: String) -> [String: String] {
        
        var params = [String: String]()
        let items = string.components(separatedBy: "&")
        
        for item in items {
            
            let itemArray = item.components(separatedBy: "=")
            if itemArray.count == 2 {
                let (key, value) = (itemArray[0], itemArray[1])
                params[key] = value.removingPercentEncoding
            }else if itemArray.count == 1{
                let key = itemArray[0]
                params[key] = ""
            }
        }
        return params
    }
    
}

extension UIWindow {
    
    static func rootViewController() -> UIViewController? {
        let window = UIApplication.shared.keyWindow
        let rootViewController = window?.rootViewController
        return rootViewController
    }
    
    static func topViewController() -> UIViewController? {
        return UIWindow.top(of: UIWindow.rootViewController())
    }
    
    //Returns the top most view controller from given view controller's stack.
    static func top(of viewController: UIViewController? ) -> UIViewController? {
        //UITabBarController
        if let tabBarViewController = viewController as? UITabBarController, let selectedViewController = tabBarViewController.selectedViewController {
            return self.top(of: selectedViewController)
        }
        
        //UINavigationController
        if let navigationCotroller = viewController as? UINavigationController, let visibleController = navigationCotroller.visibleViewController {
            return self.top(of: visibleController)
        }
        
        //presentedViewController
        if let presentViewController = viewController?.presentedViewController {
            return self.top(of: presentViewController)
        }
        
        //child viewController
        for subView in viewController?.view?.subviews ?? [] {
            if let childViewController = subView.next as? UIViewController {
                return self.top(of: childViewController)
            }
        }
        
        return viewController
    }
}

public func += <keyType, valueType>(lhs: inout Dictionary<keyType, valueType>, rhs: Dictionary<keyType, valueType>) {
    for (key, value) in rhs {
        lhs[key] = value
    }
}



