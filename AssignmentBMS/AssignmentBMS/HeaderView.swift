//
//  HeaderView.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import UIKit

final class HeaderView: UICollectionReusableView, Reusable {
    
    // MARK: View Properties
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(with: .MEDIUM, of: .SUB_TITLE)
        titleLabel.textAlignment = .left
        titleLabel.text = Strings.recentSearch
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) not implemented")
    }
    
    // MARK: Private Custom Methods
    private func setup() {
        backgroundColor = .appSecBackground()
        addSubview(titleLabel)
        titleLabel.pinEdgesEquallyToSuperview(atrributes: [.leading, .trailing, .top, .bottom], constant: Constants.defaultPadding)
    }
}
