//
//  Color.swift
//  Pixels
//
//  Created by Aaron Wright on 10/14/19.
//  Copyright © 2019 Infinite Token. All rights reserved.
//

import Foundation

struct RGBA {
    
    var red: UInt8 = 0
    var green: UInt8 = 0
    var blue: UInt8 = 0
    var alpha: UInt8 = 0
    
}

extension RGBA {
    
    static var black: RGBA { RGBA(red: 0, green: 0, blue: 0, alpha: 255) }
    static var white: RGBA { RGBA(red: 255, green: 255, blue: 255, alpha: 255) }
    static var clear: RGBA { RGBA(red: 0, green: 0, blue: 0, alpha: 0) }
    static var random: RGBA { RGBA(red: UInt8.random(in: 0..<255), green: UInt8.random(in: 0..<255), blue: UInt8.random(in: 0..<255), alpha: 255) }
    
    var bytes: UInt32 {
        return (UInt32(alpha) << 24) | (UInt32(blue) << 16) | (UInt32(green) <<  8) | (UInt32(red))
    }

}
