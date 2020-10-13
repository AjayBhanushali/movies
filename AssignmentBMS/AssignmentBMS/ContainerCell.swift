//
//  ContainerCell.swift
//  AssignmentBMS
//
//  Created by Ajay Bhanushali on 12/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import UIKit

class ContainerCell: UITableViewCell {

    // MARK: View Properties
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing = Constants.defaultSpacing
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: collectionViewLayout)
        return collectionView
    }()
    
    // MARK: Init Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }
    
    // MARK: Private custom methods
    func prepareView() {
        addSubview(collectionView)
        collectionView.pinEdgesToSuperview()
        collectionView.registerCell(GenericCollectionViewCell<BackDropView>.self)
        collectionView.registerCell(GenericCollectionViewCell<SynonpsisView>.self)
        collectionView.registerCell(GenericCollectionViewCell<ReviewsView>.self)
        collectionView.registerCell(GenericCollectionViewCell<SimpleImageView>.self)
        collectionView.registerCell(GenericCollectionViewCell<CastView>.self)
    }
}

// MARK: CollectionView DataSource n Delegate bindings
extension ContainerCell {

    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {

        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.backgroundColor = .appWhite()
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false)
        collectionView.reloadData()
    }

    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}
