//
//  MovieDetailsVC.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import UIKit

final class MovieDetailsVC: UIViewController {
    
    var presenter: MovieDetailsViewOutput!
    var viewState: ViewState = .none
    var movieDetailsViewModel: MovieDetailsViewModel?
        
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing = Constants.defaultSpacing
        let itemSize: CGFloat = (UIScreen.main.bounds.width - (Constants.numberOfColumns - spacing) - 2) / Constants.numberOfColumns
        layout.itemSize = CGSize(width: itemSize, height: 50)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    //MARK: ViewController Lifecycle
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        navigationItem.title = ""//Strings.moviesDBTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.getMovieDetails()
    }
    
    private func setupViews() {
        configureCollectionView()
    }
    
    //MARK: ConfigureCollectionView
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.pinEdgesToSuperview()
        collectionView.registerCell(GenericCollectionViewCell<MovieCardView>.self)
        collectionView.register(FooterView.self, ofKind: UICollectionView.elementKindSectionFooter)
    }
}

extension MovieDetailsVC: MovieDetailsViewInput {
    func changeViewState(_ state: ViewState) {
        viewState = state
        switch state {
        case .loading:
            if movieDetailsViewModel == nil {
                showSpinner()
            }
        case .content:
            hideSpinner()
            collectionView.collectionViewLayout.invalidateLayout()
        case .error(let message):
            hideSpinner()
            showAlert(title: Strings.error, message: message, retryAction: { [unowned self] in
                self.presenter.getMovieDetails()
            })
        default:
            break
        }
    }
    
    func reloadView(at index: Int, viewModel: MovieDetailsViewModel) {
        movieDetailsViewModel = viewModel
        collectionView.reloadData()
//        collectionView.performBatchUpdates({ [weak self] in
//            guard let self = self else { return }
//            let indexSet = IndexSet(integer: index)
//            self.collectionView.reloadSections(indexSet)
//        }, completion: nil)
    }
}

extension MovieDetailsVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if let castCount = movieDetailsViewModel?.credits?.cast?.count {
                if castCount > 4 {
                    return 4
                }
                return castCount
            }
            return 0
        case 2:
            if let reviewsCount = movieDetailsViewModel?.reviews.count {
                if reviewsCount > 4 {
                    return 4
                }
                return reviewsCount
            }
            return 0
        case 3:
            if let moviesCount = movieDetailsViewModel?.similarMovies.count {
                if moviesCount > 4 {
                    return 4
                }
                return moviesCount
            }
            return 0
        default:
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as GenericCollectionViewCell<MovieCardView>
        
        guard let viewModel = movieDetailsViewModel else {
            return cell
        }
        
        guard cell.cellView != nil else {
            let cardView = MovieCardView(frame: .zero)
            cell.cellView = cardView
            switch indexPath.section {
            case 0:
                cell.cellView?.titleLabel.text = viewModel.synopsis?.overview
            case 1:
                cell.cellView?.titleLabel.text = viewModel.credits?.cast![indexPath.item].name
            case 2:
                cell.cellView?.titleLabel.text = viewModel.reviews[indexPath.item].content
            case 3:
                cell.cellView?.titleLabel.text = viewModel.similarMovies[indexPath.item].title
            default:
                break
            }
            
//            cell.cellView?.movie = viewModel.similarMovies[indexPath.item]
//            if let imageURL = viewModel.posterURL(indexPath.item) {
//                cell.cellView?.configure(imageURL: imageURL, size: collectionViewLayout.itemSize, indexPath: indexPath)
//            }
            return cell
        }
        
        switch indexPath.section {
        case 0:
            cell.cellView?.titleLabel.text = viewModel.synopsis?.overview
        case 1:
            cell.cellView?.titleLabel.text = viewModel.credits?.cast![indexPath.item].name
        case 2:
            cell.cellView?.titleLabel.text = viewModel.reviews[indexPath.item].content
        case 3:
            cell.cellView?.titleLabel.text = viewModel.similarMovies[indexPath.item].title
        default:
            break
        }
//        if let imageURL = viewModel.posterURL(indexPath.item) {
//            cell.cellView?.configure(imageURL: imageURL, size: collectionViewLayout.itemSize, indexPath: indexPath)
//        }
//        cell.cellView?.movie = viewModel.similarMovies[indexPath.item]
        return cell
    }
    
    
}

extension MovieDetailsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Test")
    }
    
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard let viewModel = moviesViewModel else { return }
//        guard viewState != .loading, indexPath.row == (viewModel.moviesCount - 1) else {
//            return
//        }
//        if let imageURL = viewModel.posterURL(indexPath.item) {
//            ImageDownloader.shared.changeDownloadPriority(for: imageURL)
//        }
//    }
    
    //MARK: UICollectionViewFooter
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if viewState == .loading && movieDetailsViewModel != nil {
            return CGSize(width: Constants.screenWidth, height: 50)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath) as FooterView
            return footerView
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath) as HeaderView
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
}
