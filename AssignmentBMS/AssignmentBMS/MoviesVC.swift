//
//  MoviesVC.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import UIKit

final class MoviesVC: UIViewController {
    
    var presenter: MoviesViewOutput!
    var viewState: ViewState = .none
    var moviesViewModel: MoviesViewModel?
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing = Constants.defaultSpacing
        let itemWidth: CGFloat = (UIScreen.main.bounds.width - (Constants.numberOfColumns - spacing) - 2) / Constants.numberOfColumns
        let itemHeight: CGFloat = (itemWidth - Constants.defaultPadding*2) * 1.5 + 67
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .appBackground()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    //MARK: ViewController Lifecycle
    override func loadView() {
        view = UIView()
        view.backgroundColor = .appBackground()
        navigationItem.title = Strings.moviesDBTitle
        setNavbarTransculent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.getMovies()
    }
    
    private func setupViews() {
        configureCollectionView()
        configureNavBarButtons()
    }
    
    private func configureNavBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(with: .SEARCH),
                                             style: .plain, target: self,action: #selector(tappedSearch))
    }
    
    //MARK: ConfigureCollectionView
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.pinEdgesToSuperview()
        collectionView.registerCell(GenericCollectionViewCell<MovieCardView>.self)
        collectionView.register(FooterView.self, ofKind: UICollectionView.elementKindSectionFooter)
    }
    
    @objc func tappedSearch() {
        presenter.tappedOnSearch()
    }
}

extension MoviesVC: MoviesViewInput {
    func changeViewState(_ state: ViewState) {
        viewState = state
        switch state {
        case .loading:
            if moviesViewModel == nil {
                showSpinner()
            }
        case .content:
            hideSpinner()
            collectionView.collectionViewLayout.invalidateLayout()
        case .error(let message):
            hideSpinner()
            showAlert(title: Strings.error, message: message, retryAction: { [unowned self] in
                self.presenter.getMovies()
            })
        default:
            break
        }
    }
    
    func displayMovies(with viewModel: MoviesViewModel) {
        moviesViewModel = viewModel
        collectionView.reloadData()
    }
    
    func insertMovies(with viewModel: MoviesViewModel, at indexPaths: [IndexPath]) {
        collectionView.performBatchUpdates({ [weak self] in
            guard let self = self else { return }
            self.moviesViewModel = viewModel
            self.collectionView.insertItems(at: indexPaths)
        })
    }
    
    func resetViews() {
        moviesViewModel = nil
        collectionView.reloadData()
    }
    
    
}

extension MoviesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = moviesViewModel, !viewModel.isEmpty else {
            return 0
        }
        return viewModel.moviesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as GenericCollectionViewCell<MovieCardView>
        
        guard let viewModel = moviesViewModel else {
            return cell
        }
        
        let imageWidth = collectionViewLayout.itemSize.width
        let imageSize = CGSize(width: imageWidth, height: imageWidth*1.5)
        
        guard cell.cellView != nil else {
            let cardView = MovieCardView(frame: .zero)
            cell.cellView = cardView
            cell.cellView?.movie = viewModel.movieAt(indexPath.item)
            if let imageURL = viewModel.posterURL(indexPath.item) {
                cell.cellView?.configure(imageURL: imageURL, size: imageSize, indexPath: indexPath)
            }
            return cell
        }
        
        if let imageURL = viewModel.posterURL(indexPath.item) {
            cell.cellView?.configure(imageURL: imageURL, size: imageSize, indexPath: indexPath)
        }
        cell.cellView?.movie = moviesViewModel?.movieAt(indexPath.item)
        return cell
    }
    
    
}

extension MoviesVC: UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let denominator: CGFloat = 50 //your offset treshold
        let alpha = min(1, scrollView.contentOffset.y / denominator)
        setNavbar(backgroundColorAlpha: alpha)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectMovie(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let viewModel = moviesViewModel else { return }
        guard viewState != .loading, indexPath.row == (viewModel.moviesCount - 1) else {
            return
        }
        presenter.getMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewModel = moviesViewModel else { return }
        guard viewState != .loading, indexPath.row == (viewModel.moviesCount - 1) else {
            return
        }
        if let imageURL = viewModel.posterURL(indexPath.item) {
            ImageDownloader.shared.changeDownloadPriority(for: imageURL)
        }
    }
    
    //MARK: UICollectionViewFooter
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if viewState == .loading && moviesViewModel != nil {
            return CGSize(width: Constants.screenWidth, height: 50)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath) as FooterView
            return footerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
}

extension UIApplication {
    var statusView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 38482458385
            if let statusBar = self.keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = tag

                self.keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }
}
