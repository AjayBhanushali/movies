//
//  MovieCardView.swift
//  AssignmentBMS
//
//  Created by Ajay on 10/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import UIKit

class MovieCardView: UIView {
    
    // MARK: View Properties
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = UIFont(with: .MEDIUM, of: .TITLE)
        return titleLabel
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // MARK: Data Properties
    var movie : Movie? {
        didSet {
            guard let movie = movie else {
                return
            }
            titleLabel.text = movie.title
        }
    }
    
    // MARK: Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }
    
    // MARK: Private Custom Methods
    private func prepareView() {
        backgroundColor = .yellow
        
        addSubview(photoImageView)
        photoImageView.pinEdgesToSuperview()
        
        addSubview(titleLabel)
        titleLabel.pinEdgesToSuperview()
    }
    
    func configure(imageURL: URL, size: CGSize, indexPath: IndexPath) {
        photoImageView.loadImage(with: imageURL, size: size, indexPath: indexPath)
    }
}
