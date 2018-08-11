//
//  ViewController.swift
//  FunctionSwiftTest
//
//  Created by great Lock baidu on 2018/6/3.
//  Copyright © 2018年 great Lock baidu. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        testShipRegion()
//        testImageExtion()
//        testArray()
//        testSessionOne()
        testStringTree()
    }
    
    private func testShipRegion() {
        _ = ShipRegion()
    }
    
    private func testImageExtion() {
        let imageExt = ImageExt()
        if let image = imageExt.resultImage {
            let context = CIContext(options: nil)
            let cgImage = context.createCGImage(image, from: image.extent)!
            
            let imageView = UIImageView(image: UIImage(cgImage: cgImage))
            imageView.frame = CGRect(x: 100, y: 100, width: 300, height: 300)
            view.addSubview(imageView)
        }
    }
    
    private func testArray() {
        let array = [1, 2, 3]
        print(array.double2(array: array))
    }
    
    private func testSessionOne() {
        _ = SessionOne()
    }
    
    private func testStringTree() {
        _ = StringTree()
    }
}

