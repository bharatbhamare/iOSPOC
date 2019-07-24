//
//  OBuzzParams.swift
//  Networking
//
//  Created by Gabe The Coder on 10/2/17.
//  Copyright © 2017 Gabe The Coder. All rights reserved.
//

import Foundation

public class OBuzzParams {
    
    public var paramData: Data!
    public init() {}
    public init?(params: Any) {
        do {
            paramData = try JSONSerialization.data(withJSONObject: params)
        } catch {
            return nil
        }
    }
    
    public init?<T: Encodable>(model: T) {
        do {
            paramData = try JSONEncoder().encode(model)
        } catch {
            return nil
        }
    }
    
}

extension OBuzzParams {
    
    public convenience init?(id: String) {
        self.init(params: ["id": id])
    }
    
}
