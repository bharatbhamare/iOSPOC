//
//  SpeedyConfiguration.swift
//  Networking
//
//  Created by Gabe The Coder on 10/2/17.
//  Copyright © 2017 Gabe The Coder. All rights reserved.
//

import Foundation

public class OBuzzConfiguration {
    
    static let shared = OBuzzConfiguration()
    
    public var defaultUrl: URL?
    public var defaultAuthorizationHeader: String?
    public init() {}
    
}
