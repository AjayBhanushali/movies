//
//  CastView.swift
//  AssignmentBMS
//
//  Created by Ajay Bhanushali on 12/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//
import UIKit

class CastView: UIView {
    
    // MARK: View Properties
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(with: .SEARCH)
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .appBlack()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(with: .MEDIUM, of: .SUB_TITLE)
        return titleLabel
    }()
    
    // MARK: Data Properties
    var movie : Cast? {
        didSet {
            guard let movie = movie else {
                return
            }
            titleLabel.text = movie.name
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
        backgroundColor = .appWhite()
        addSubview(photoImageView)
        
        photoImageView.pinToSuperview(forAtrributes: [.top, .leading], multiplier: 1, constant: Constants.defaultPadding)
        photoImageView.pinToSuperview(forAtrributes: [.trailing], multiplier: 1, constant:-Constants.defaultPadding)
        photoImageView.pinHeightWidth(constant: 100)
        photoImageView.giveCorner(radius: 50)
        
        addSubview(titleLabel)
        titleLabel.pinTo(atrribute: .top, toView: photoImageView, toAttribute: .bottom, constant: Constants.defaultPadding/2)
        titleLabel.pinEdgesEquallyToSuperview(atrributes: [.bottom, .leading, .trailing], constant: Constants.defaultPadding)
    }
    
    // MARK: Methods
    /// display movies
    /// - Parameters:
    ///   - imageURL: link for image
    ///   - size: size for the image
    ///   - indexPath: indexPath of list
    func configure(imageURL: URL, size: CGSize, indexPath: IndexPath) {
        photoImageView.loadImage(with: imageURL, size: size, indexPath: indexPath)
    }
}
