//
//  Bool+Sign.swift
//  Pixels
//
//  Created by Aaron Wright on 10/14/19.
//  Copyright © 2019 Infinite Token. All rights reserved.
//

import Foundation

extension Bool {
    
    var signValue: Int {
        return self ? 1 : -1
    }
    
}
