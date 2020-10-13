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
        titleLabel.textColor = .appBlack()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(with: .MEDIUM, of: .SUB_TITLE)
        return titleLabel
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(with: .SEARCH)
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var bookButton: UIButton = {
        let bookButton = UIButton()
        bookButton.setTitle("Book", for: .normal)
        bookButton.setTitleColor(.appWhite(), for: .normal)
        bookButton.backgroundColor = UIColor(hex: APP_COLOR.THEME.rawValue)
        bookButton.titleLabel?.font = UIFont(with: .MEDIUM, of: .SUB_TITLE)
        return bookButton
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
        photoImageView.pinEdgesEquallyToSuperview(atrributes: [.top, .leading, .trailing], constant: Constants.defaultPadding)
        photoImageView.pin(attribute: .height, toView: photoImageView, toAttribute: .width, multiplier: 1.5, constant: 0)
        photoImageView.giveCorner(radius: Constants.defaultRadius)
        
        addSubview(titleLabel)
        titleLabel.pinTo(atrribute: .top, toView: photoImageView, toAttribute: .bottom, constant: Constants.defaultSpacing)
        titleLabel.pinEdgesEquallyToSuperview(atrributes: [.leading, .trailing], constant: Constants.defaultPadding)
        
        addSubview(bookButton)
        bookButton.pinTo(atrribute: .top, toView: titleLabel, toAttribute: .bottom, constant: Constants.defaultPadding/2)
        bookButton.pinEdgesEquallyToSuperview(atrributes: [.leading, .trailing], constant: Constants.defaultPadding*2)
        bookButton.pinEdgesEquallyToSuperview(atrributes: [.bottom], constant: Constants.defaultPadding)
        bookButton.giveCorner(radius: Constants.defaultRadius)
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
