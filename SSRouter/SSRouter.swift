//
//  SSRouter.swift
//  Sunshine
//
//  Created by yst on 2017/5/16.
//  Copyright © 2017年 jryghq. All rights reserved.
//

import UIKit



public class SSRouter: NSObject {
    
    //default is page.push
    public static var pagePush = "page.push"
    
    //default is page.modal
    public static var pageModal = "page.modal"
    
    //default is action.net
    public static var actionNet = "action.net"
    
    //SSRouterHandler define
    public typealias SSRouterHandler = (_ pattern: SSRouterPattern, _ params: [String: Any]?) -> Bool
    
    //store handler
    private(set) var handlerMap = [String: SSRouterHandler]()
    
    //store protocoltype
    private(set) var pushMap = [String: SSRouterPushProtocol.Type]()
    
    //The singleton of 'SSRouter'
    static let `default` = SSRouter()
    
    //map pattern with handler
    @discardableResult
    public func map(_ pattern: SSRouterPattern, _ handler: SSRouterHandler?) -> Bool {
        
        //http://news.xinhuanet.com/politics/2017-05/18/c_1120991501.htm -> key = politics/2017-05/18/c_1120991501.htm
        //news/china/Shandong -> key = news/china/Shandong
        //&*@&   !*(&@*(f kdajfjaieio -> key = nil
        
        guard let key = pattern.pPath else {
            return false
        }
        handlerMap[key] = handler
        return true
    }
    
    //map pattern with SSRouterPushProtocol.Type
    @discardableResult
    public func map(_ pattern: SSRouterPattern, _ pushType: SSRouterPushProtocol.Type) -> Bool{
        guard let key = pattern.pPath else {
            return false
        }
        pushMap[key] = pushType
        return true
    }
    
    //Perform a routing operations
    //If you pass the pattern contains a host string
    //  if the host like page.push or page.modal, that will be to perform a jump page first if can fetch new page
    //  if the host like action.get, that will be to perform a handler if exists
    //  if the host mismatch in the preset, that still to perform a handler if exists
    //If you pass the pattern not contains a host string, it will be perform a handler if exists
    /***********************************************************************************************
     *
     * for example: you map SSGuideViewController to Router
     * SSRouter.map("home/guide", SSGuideViewController.self)
     *
     * you execute like this
     * SSRouter.execute("SSRouter://\(SSRouter.pagePush):1/home/guide?title=Guide")
     * next will push new page "SSGuideViewController" by Router auto, send patameter ["title":"Guide"] yet.
     *
     ***********************************************************************************************/
    
    /***********************************************************************************************
     *
     * for example: you map SSGuideViewController to Router
     * SSRouter.map("upload/location", { (pattern, params) -> Bool in
     *  do upload location
     * })
     *
     * you execute like this
     * SSRouter.execute("SSRouter://\(SSRouter.actionNet)/upload/location", ["longitude":0.0,"latitude":0.0])
     * next will call upload location closure.
     *
     ***********************************************************************************************/
    
    @discardableResult
    public func execute(_ pattern: SSRouterPattern, _ params: [String: Any]? = nil) -> (Bool, Any?) {
        
        guard let key = pattern.pPath else {
            return (false, nil)
        }
        
        let result = SSRouterFetch.fetch(pattern, params)
        switch result.operation {
        case .page(.push):
            return transition(pattern, result: result)
        case .page(.modal):
            return transition(pattern, result: result)
        case .action(.net):
            guard let handler = handlerMap[key] else {
                return (false, nil)
            }
            return (handler(pattern, result.params), nil)
        case .unknow:
            guard let handler = handlerMap[key] else {
                return (false, nil)
            }
            return (handler(pattern, result.params), nil)
        }
    }
    
    // Just to open new page use this function
    // Will push a new page, if you can get in through the pattern
    //
    @discardableResult
    public func push(_ pattern: SSRouterPattern, _ params: [String: Any]? = nil) -> (Bool, Any?) {
        var result = SSRouterFetch.fetch(pattern, params)
        result.operation = .page(.push)
        return transition(pattern, result: result)
    }
    
    // Just to open new page use this function
    // Will present a new page, if you can get in through the pattern
    //
    @discardableResult
    public func present(_ pattern: SSRouterPattern, _ params: [String: Any]? = nil) -> (Bool, Any?) {
        var result = SSRouterFetch.fetch(pattern, params)
        result.operation = .page(.modal)
        return transition(pattern, result: result)
    }
    
    private func transition(_ pattren: SSRouterPattern, result: SSRouterFetch.FetchResult) -> (Bool, Any?) {
        
        guard let classType = pushMap[pattren.pPath!] else { return (false, nil) }
        guard let viewController = (classType.init(pattren, result.params) as? UIViewController) else { return (false, nil) }
        
        //Whether according the port number to switch tabbarcontroller
        if pattren.pPort != nil, let tabbarVC = UIWindow.rootViewController() as? UITabBarController {
            tabbarVC.selectedIndex = pattren.pPort!
        }
        guard let navController = UIWindow.topViewController()?.navigationController else { return (false, nil) }
        
        switch result.operation {
        case .page(.modal):
            if viewController.isKind(of: UINavigationController.self) {
                navController.present(viewController, animated: true, completion: nil)
                return (true, viewController)
            }else {
                let newNav = UINavigationController(rootViewController: viewController)
                navController.present(newNav, animated: true, completion: nil)
                return (true, newNav)
            }
        case .page(.push):
            navController.pushViewController(viewController, animated: true)
            return (true, viewController)
        default :
            return (false, nil)
        }
    }
}

extension SSRouter {
    
    @discardableResult
    public static func map(_ pattern: SSRouterPattern, _ handler: SSRouterHandler?) -> Bool {
        return SSRouter.default.map(pattern, handler)
    }
    
    @discardableResult
    public static func map(_ pattern: SSRouterPattern, _ push: SSRouterPushProtocol.Type) -> Bool{
        return SSRouter.default.map(pattern, push)
    }
    
    @discardableResult
    public static func execute(_ pattern: SSRouterPattern, _ params: [String: Any]? = nil) -> (Bool, Any?) {
        return SSRouter.default.execute(pattern, params)
    }
    
    @discardableResult
    public static func push (_ pattern: SSRouterPattern, _ params: [String: Any]? = nil) -> (Bool, Any?) {
        return SSRouter.default.push(pattern, params)
    }
    
    @discardableResult
    public static func present(_ pattern: SSRouterPattern, _ params: [String: Any]? = nil) -> (Bool, Any?) {
        return SSRouter.default.present(pattern, params)
    }
    
}
