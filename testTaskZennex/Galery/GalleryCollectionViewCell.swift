//
//  GalleryCollectionViewCell.swift
//  testTaskZennex
//
//  Created by Radmir Dzhurabaev on 29.01.2020.
//  Copyright © 2020 Radmir Dzhurabaev. All rights reserved.
//

import UIKit
import Kingfisher

class GalleryCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!

    
    func loadImage(from urlString: String) {
        let url = URL(string: urlString)
        let cache = ImageCache.default
        cache.memoryStorage.config.countLimit = 3
        imageView.kf.indicatorType = .activity
        
        imageView.kf.setImage(with: url, options: [.transition(.fade(0.2)), .forceRefresh])
    }

    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

    
    
}
