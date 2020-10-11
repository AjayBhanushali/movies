//
//  GenericCollectionViewCell.swift
//  AssignmentBMS
//
//  Created by Ajay on 10/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation
import UIKit

class GenericCollectionViewCell<View: UIView>: UICollectionViewCell {
    
    var cellView: View? {
        didSet {
            guard cellView != nil else { return }
            setUpViews()
        }
    }
    
    //  weak var delegate: FormFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //    translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        guard let cellView = cellView else { return }
        addSubview(cellView)
        cellView.pinEdgesToSuperview()
    }
}
