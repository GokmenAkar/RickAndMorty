//
//  UIImageView+Extensions.swift
//  RickAndMorty
//
//  Created by GÖKMEN AKAR on 1.02.2020.
//  Copyright © 2020 GÖKMEN AKAR. All rights reserved.
//

import UIKit
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func getImage(url: String, completion: @escaping (Bool) -> Void) {
        completion(false)
        guard let url = URL(string: url) else { return }
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(true)
            self.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    completion(false)
                    return
                }
                completion(true)
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async() {    // execute on main thread
                    self.image = image
                }
            }.resume()
        }
    }
}
