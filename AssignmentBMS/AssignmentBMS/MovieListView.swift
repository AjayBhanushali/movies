//
//  MovieListView.swift
//  AssignmentBMS
//
//  Created by Ajay Bhanushali on 12/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import UIKit

class MovieListView: UIView {
    
    // MARK: View Properties
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .appBlack()
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(with: .MEDIUM, of: .TITLE)
        return titleLabel
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(with: .SEARCH)
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(with: .DISCLOSURE)
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
        addSubview(photoImageView)
        photoImageView.pinToSuperview(forAtrributes: [.top, .leading], multiplier: 1, constant: Constants.defaultPadding)
        photoImageView.pinToSuperview(forAtrributes: [.bottom], multiplier: 1, constant:-Constants.defaultPadding)
        photoImageView.pinHeightWidth(constant: 40)
        photoImageView.giveCorner(radius: 20)

        
        addSubview(titleLabel)
        titleLabel.pinToSuperview(atrribute: .centerY)
        titleLabel.pinTo(atrribute: .leading, toView: photoImageView, toAttribute: .trailing, constant: Constants.defaultPadding)
        
        addSubview(iconImageView)
        iconImageView.pinToSuperview(forAtrributes: [.trailing], multiplier: 1, constant: -Constants.defaultPadding)
        iconImageView.pinToSuperview(atrribute: .centerY)
        iconImageView.pinHeightWidth(constant: 32)
    }
    
    // MARK: Methods
    /// display movies
    /// - Parameters:
    ///   - imageURL: link for image
    ///   - size: size for the image
    ///   - indexPath: indexPath of list
    func configure(imageURL: URL, size: CGSize, indexPath: IndexPath) {
        photoImageView.loadImage(with: imageURL, size: size, indexPath: indexPath)
        photoImageView.giveCorner(radius: 20)
    }
}
