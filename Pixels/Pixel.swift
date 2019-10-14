//
//  Pixel.swift
//  Pixels
//
//  Created by Aaron Wright on 10/14/19.
//  Copyright © 2019 Infinite Token. All rights reserved.
//

import Foundation

struct Pixel {
    
    var x: Int
    var y: Int
    var color: RGBA
    
    func isOnscreen(rect: NSRect) -> Bool {
        return NSPointInRect(NSPoint(x: self.x, y: self.y), rect)
    }
    
}
