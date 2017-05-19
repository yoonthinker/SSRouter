//
//  SSRouterProtocol.swift
//  Sunshine
//
//  Created by yst on 2017/5/17.
//  Copyright © 2017年 jryghq. All rights reserved.
//

import UIKit

public protocol SSRouterPushProtocol {
    //If you want to jump to a specified by routing controller without the need for additional to write jump implementation
    //You need to let your inheritance protocol controller
    //Params is extracted from pattern
    
    init?(_ pattern: SSRouterPattern,_ params: [String: Any]?)
}

public protocol SSRouterPattern {
    var pPath: String? { get }
    var pUrl: URL? { get }
    var pString: String? { get }
    var pHost: String? { get }
    var pPort: Int? { get }
    var pQuery: String? { get }
    var pFragment: String? { get }
    var pScheme: String? { get }
}

extension String: SSRouterPattern {
    
    public var pPath: String? {
        return self.pUrl?.path
    }
    
    public var pUrl: URL? {
        return URL(string: self)
    }
    
    public var pString: String? {
        return self
    }
    
    public var pHost: String? {
        return self.pUrl?.host
    }
    
    public var pPort: Int? {
        return self.pUrl?.port
    }
    
    public var pQuery: String? {
        return self.pUrl?.query
    }
    
    public var pFragment: String? {
        return self.pUrl?.fragment
    }
    
    public var pScheme: String? {
        return self.pUrl?.scheme
    }
}

extension URL: SSRouterPattern {
    
    public var pPath: String? {
        return self.path
    }
    
    public var pUrl: URL? {
        return self
    }
    
    public var pString: String? {
        return self.absoluteString
    }
    
    public var pHost: String? {
        return self.host
    }
    
    public var pPort: Int? {
        return self.port
    }
    
    public var pQuery: String? {
        return self.query
    }
    
    public var pFragment: String? {
        return self.fragment
    }
    
    public var pScheme: String? {
        return self.scheme
    }
    
}
