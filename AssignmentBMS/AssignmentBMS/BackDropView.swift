//
//  BackDropView.swift
//  AssignmentBMS
//
//  Created by Ajay Bhanushali on 12/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import UIKit

class BackDropView: UIView {
    
    // MARK: View Properties
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .appWhite()
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(with: .BOLD, of: .HEADER2)
        return titleLabel
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(with: .SEARCH)
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
        // image view
        addSubview(photoImageView)
        photoImageView.pinEdgesToSuperview()
        
        addSubview(titleLabel)
        titleLabel.pinEdgesEquallyToSuperview(atrributes: [.leading, .trailing, .bottom], constant: Constants.defaultPadding)
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
