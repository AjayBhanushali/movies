//
//  ReviewsView.swift
//  AssignmentBMS
//
//  Created by Ajay Bhanushali on 12/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import UIKit

class ReviewsView: UIView {
    
    // MARK: View Properties
    
    lazy var nameLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .appBlack()
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(with: .MEDIUM, of: .TITLE)
        return titleLabel
    }()
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .appSecBackground()
        return view
    }()
    
    lazy var reviewLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .appBlack()
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(with: .REGULAR, of: .SUB_TITLE)
        return titleLabel
    }()
    
    // MARK: Data Properties
    var review : MovieReview? {
        didSet {
            guard let review = review else {
                return
            }
            nameLabel.text = review.author
            reviewLabel.text = review.content
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
        addSubview(cardView)
        cardView.pinToSuperview(forAtrributes: [.top], multiplier: 1, constant: Constants.defaultPadding)
        cardView.pinToSuperview(forAtrributes: [.leading], multiplier: 1, constant: Constants.defaultPadding*2)
        cardView.pinToSuperview(forAtrributes: [.bottom], multiplier: 1, constant: -Constants.defaultPadding)
        cardView.pinToSuperview(forAtrributes: [.trailing], multiplier: 1, constant: -Constants.defaultPadding*2)
        cardView.giveCorner(radius: Constants.defaultRadius)
    
        cardView.addSubview(nameLabel)
        nameLabel.pinEdgesEquallyToSuperview(atrributes: [.top, .leading, .trailing], constant: Constants.defaultPadding)
        
        cardView.addSubview(reviewLabel)
        reviewLabel.pinTo(atrribute: .top, toView: nameLabel, toAttribute: .bottom, constant: Constants.defaultPadding/2)
        reviewLabel.pinToSuperview(forAtrributes: [.leading], multiplier: 1, constant: Constants.defaultPadding*2)
        reviewLabel.pinToSuperview(forAtrributes: [.bottom, .trailing], multiplier: 1, constant: -Constants.defaultPadding*2)
    }
}
