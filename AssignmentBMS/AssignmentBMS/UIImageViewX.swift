//
//  UIImageViewX.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /*!
     * @description: Load Image into imageView from the given imageUrl using ImageDownloader
     * class
     * @parameters: takes imageURL, placeholderImage and indexPath as params
     */
    func loadImage(with imageURL: URL, placeholder: UIImage? = UIImage(color: .black), size: CGSize, indexPath: IndexPath?) {
        self.image = placeholder
        ImageDownloader.shared.downloadImage(
            withURL: imageURL,
            size: size,
            indexPath: indexPath,
            completion: { [weak self] (image: UIImage?, resultIndexPath: IndexPath?, url: URL, error: Error?) in
                if let self = self, let kIndexPath = resultIndexPath, indexPath == kIndexPath, imageURL.absoluteString == url.absoluteString {
                    DispatchQueue.main.async {
                        if let downloadedImage = image {
                            self.fadeTransition(with: downloadedImage)
                        }
                    }
                }
        })
    }
    
    //MARK: Fade transition Animation
    func fadeTransition(with image: UIImage?, duration: TimeInterval = 0.5, completion: ((Bool) -> Void)? = nil) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.image = image
        }, completion: completion)
    }
}
