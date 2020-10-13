//
//  SynonpsisView.swift
//  AssignmentBMS
//
//  Created by Ajay Bhanushali on 12/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import UIKit

class SynonpsisView: UIView {
    
    // MARK: View Properties
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .appBlack()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(with: .REGULAR, of: .SUB_TITLE)
        return titleLabel
    }()
    
    // MARK: Data Properties
    var synopsis : MovieSynopsisBase? {
        didSet {
            guard let synopsis = synopsis else {
                return
            }
            titleLabel.text = synopsis.overview
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

        addSubview(titleLabel)
        titleLabel.pinToSuperview(forAtrributes: [.top, .leading], multiplier: 1, constant: Constants.defaultPadding*2)
        titleLabel.pinToSuperview(forAtrributes: [.bottom, .trailing], multiplier: 1, constant: -Constants.defaultPadding*2)
    }
}
