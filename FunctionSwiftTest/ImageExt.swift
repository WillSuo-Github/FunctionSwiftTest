//
//  ImageExt.swift
//  FunctionSwiftTest
//
//  Created by great Lock on 2018/6/24.
//  Copyright © 2018年 great Lock baidu. All rights reserved.
//

import UIKit

typealias Filter = (CIImage) -> CIImage

infix operator >>>
func >>>(filter1: @escaping Filter, filter2: @escaping Filter) -> Filter {
    return {image in filter2(filter1(image))}
}

class ImageExt: NSObject {
    public var resultImage: CIImage?
    
    override init() {
        super.init()
        
        let ciImage = CIImage(image: UIImage(named: "123")!)!
        let blurAndOverlay =  blur(raidus: 10) >>> overlay(color: UIColor(red: 123.0/255.0, green: 213.0/255.0, blue: 45.0/255.0, alpha: 0.2))
        resultImage = blurAndOverlay(ciImage)
    }
    
    
    private func blur(raidus: Double) -> Filter {
        return { image in
            let parameters: [String: Any] = [
                kCIInputRadiusKey: raidus,
                kCIInputImageKey: image,
            ]
            
            guard let filter = CIFilter(name: "CIGaussianBlur", parameters: parameters) else {fatalError()}
            guard let outputImage = filter.outputImage else {fatalError()}
            
            return outputImage
        }
    }
    
    private func generate(color: UIColor) -> Filter {
        return { _ in
            
            let parameters = [kCIInputColorKey: CIColor(cgColor: color.cgColor)]
            guard let filter = CIFilter(name: "CIConstantColorGenerator", parameters: parameters) else {fatalError()}
            guard let outputImage = filter.outputImage else {fatalError()}
            
            return outputImage
        }
    }
    
    private func compositeSourceOver(overlay: CIImage) -> Filter {
        return { image in
            let parameters = [
                kCIInputBackgroundImageKey: image,
                kCIInputImageKey: overlay
            ]
            
            guard let filter = CIFilter(name: "CISourceOverCompositing", parameters: parameters) else {fatalError()}
            guard let outputImage = filter.outputImage else {fatalError()}
            
            return outputImage.cropped(to: image.extent)
        }
    }
    
    private func overlay(color: UIColor) -> Filter {
        return { image in
            let overlay = self.generate(color: color)(image).cropped(to: image.extent)
            return self.compositeSourceOver(overlay: overlay)(image)
        }
    }
    
    private func compose(filter filter1: @escaping Filter, with filter2: @escaping Filter) -> Filter {
        return {image in filter2(filter1(image))}
    }

}
