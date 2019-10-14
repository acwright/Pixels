//
//  ViewController.swift
//  Pixels
//
//  Created by Aaron Wright on 10/14/19.
//  Copyright © 2019 Infinite Token. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    let context = CGContext(
        data: nil, width: 512,
        height: 512,
        bitsPerComponent: 8,
        bytesPerRow: 512 * 4,
        space: CGColorSpaceCreateDeviceRGB(),
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    )
    
    var pixels: [Pixel] = []
    
    var timer: Timer!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clear()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1 / 60, repeats: true, block: { (timer) in
            self.update()
            self.render()
        })
    }
    
    // MARK: - Actions
    
    @IBAction func handleClear(_ sender: NSButton) {
        self.pixels = []
        self.clear()
    }
    
    // MARK: - Mouse
    
    override func mouseDown(with event: NSEvent) {
        let location = event.locationInWindow
        
        for _ in 0..<UInt8.random(in: 0..<255) {
            self.pixels.append(Pixel(x: Int(floor(location.x)), y: Int(floor(512 - location.y)), color: RGBA.random))
        }
    }
    
    // MARK: - Render Loop
    
    func update() {
        let bounds = self.view.bounds
        
        DispatchQueue(label: "Update").async {
            self.pixels = self.pixels.map({ (pixel) -> Pixel in
                return Pixel(x: pixel.x + Int.random(in: 0..<10) * Bool.random().signValue, y: pixel.y + Int.random(in: 0..<10) * Bool.random().signValue, color: pixel.color)
            }).filter({ (pixel) -> Bool in
                return pixel.isOnscreen(rect: bounds)
            })
        }
    }
    
    func render() {
        DispatchQueue(label: "Render").async {
            for pixel in self.pixels {
                self.draw(pixel: pixel)
            }
            
            guard let image = self.context?.makeImage() else { return }
            
            DispatchQueue.main.async {
                self.view.layer?.contents = image
            }
        }
    }
    
    // MARK: - Helpers
    
    func clear() {
        guard let context = self.context else { return }
        guard let pixels = context.data else { return }
        
        let size = context.width * context.height * 4
        
        for i in stride(from: 0, to: size, by: 4) {
            pixels.storeBytes(of: RGBA.clear.bytes, toByteOffset: i, as: UInt32.self)
        }
    }
    
    func draw(pixel: Pixel) {
        guard let context = self.context else { return }
        guard let pixels = context.data else { return }
        
        let width = Int(context.width)
        let height = Int(context.height)
        
        if pixel.x >= 0 && pixel.x < width && pixel.y >= 0 && pixel.y < height {
            let offset = (pixel.x + pixel.y * Int(context.width)) * 4
            
            pixels.storeBytes(of: pixel.color.bytes, toByteOffset: offset, as: UInt32.self)
        }
    }
    
}
