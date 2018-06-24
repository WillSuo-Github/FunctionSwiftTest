//
//  ImageExt.swift
//  FunctionSwiftTest
//
//  Created by great Lock on 2018/6/24.
//  Copyright © 2018年 great Lock baidu. All rights reserved.
//

import UIKit

typealias Filter = (CIImage) -> CIImage

class ImageExt: NSObject {
    
    override init() {
        super.init()
        
        var ciImage = CIImage(image: UIImage(named: "123")!)!
        ciImage = blur(raidus: 10)(ciImage)

    }
    
    
    func blur(raidus: Double) -> Filter {
        return { image in
            let parameters: [String: Any] = [
                kCIInputRadiusKey: raidus,
                kCIInputImageKey: image,
            ]
            
            guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parameters) else {fatalError()}
            
            guard let outputImage = filter.outputImage else {fatalError()}
            return outputImage
        }
    }
}
