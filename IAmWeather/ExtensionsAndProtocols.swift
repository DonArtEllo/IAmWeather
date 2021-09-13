//
//  ExtensionsAndProtocols.swift
//  IAmWeather
//
//  Created by Артем on 06.09.2021.
//

import UIKit

/// Delegating protocol for updating data in CollectionView
protocol UpdatingCollectionDataDelegate: AnyObject {
    
    /// Method to update data
    func updateCollection()
}

extension UIView {
    
    /// Method for adding more than one subview at a time
    func addSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
}

/// Capitalizing first letter in String
extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()
let cachedImages = NSCache<NSString, UIImage>()

extension UIImageView {
    
    /// Method for downloading image from internet
    func loadImageFromURL(url: String) {
        self.image = nil
        guard let URL = URL(string: url) else {
            print("No Image For this url", url)
            return
        }
        
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL) {
                if let image = UIImage(data: data) {
                    let imageTocache = image
                    imageCache.setObject(imageTocache, forKey: url as AnyObject)
                    
                    DispatchQueue.main.async {
                        self?.image = imageTocache
                    }
                }
            }
        }
        
    }

}
