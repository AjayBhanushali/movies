//
//  SearchMoviesVC.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import UIKit

final class SearchMoviesVC: UIViewController {
    var presenter: SearchMoviesViewOutput!
    var viewState: ViewState = .none
    var moviesViewModel: MoviesViewModel?
    var searchText = ""
    lazy var workItem = WorkItem()
    
    lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        if #available(iOS 11, *) {
            controller.obscuresBackgroundDuringPresentation = false
        } else {
            controller.dimsBackgroundDuringPresentation = false
        }
        controller.searchResultsUpdater = nil
        controller.searchBar.placeholder = Strings.placeholder
        controller.searchBar.delegate = self
        return controller
    }()
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing = Constants.defaultSpacing
        let itemSize: CGFloat = (UIScreen.main.bounds.width - (1 - spacing) - 2)
        layout.itemSize = CGSize(width: itemSize, height: 56)
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.onViewDidLoad()
        setNavbarTransculent()
    }
    
    private func setupViews() {
        configureSearchController()
        configureCollectionView()
    }
    
    //MARK: configureSearchController
    private func configureSearchController() {
        if #available(iOS 11, *) {
            navigationItem.searchController = searchController
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            navigationItem.titleView = searchController.searchBar
            searchController.hidesNavigationBarDuringPresentation = false
        }
        definesPresentationContext = true
    }
    
    //MARK: ConfigureCollectionView
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.pinEdgesToSuperview()
        collectionView.registerCell(GenericCollectionViewCell<MovieListView>.self)
        collectionView.register(HeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)
    }
}

extension SearchMoviesVC: SearchMoviesViewInput {
    
    func displayMovies(with viewModel: MoviesViewModel) {
        moviesViewModel = viewModel
        collectionView.reloadData()
    }
    
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
                self.presenter.searchMovies(for: "test")
            })
        default:
            break
        }
    }
    
    func resetViews() {
        moviesViewModel = nil
        searchText = ""
        presenter.onViewDidLoad()
    }
}

extension SearchMoviesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = moviesViewModel, !viewModel.isEmpty else {
            return 0
        }
        return viewModel.moviesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as GenericCollectionViewCell<MovieListView>
        
        guard let viewModel = moviesViewModel else {
            return cell
        }
        
        let itemSize = CGSize(width: 40, height: 40)
        
        guard cell.cellView != nil else {
            let cardView = MovieListView(frame: .zero)
            cell.cellView = cardView
            cell.cellView?.movie = viewModel.movieAt(indexPath.item)
            if let imageURL = viewModel.posterURL(indexPath.item) {
                cell.cellView?.configure(imageURL: imageURL, size: itemSize, indexPath: indexPath)
            }
            return cell
        }
        cell.cellView?.movie = moviesViewModel?.movieAt(indexPath.item)
        if let imageURL = viewModel.posterURL(indexPath.item) {
            cell.cellView?.configure(imageURL: imageURL, size: itemSize, indexPath: indexPath)
        }
        return cell
    }
    
    
}

extension SearchMoviesVC: UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let denominator: CGFloat = 50 //your offset treshold
        let alpha = min(1, scrollView.contentOffset.y / denominator)
        setNavbar(backgroundColorAlpha: alpha)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectMovie(at: indexPath.item)
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
    
    //MARK: UICollectionViewHeader
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if searchText.isEmpty && moviesViewModel != nil {
            return CGSize(width: Constants.screenWidth, height: 50)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath) as HeaderView
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
        return UICollectionReusableView()
    }
}

extension SearchMoviesVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            self.searchText = searchText
            presenter.onViewDidLoad()
            return
        }
        
        guard searchText != self.searchText else {
            return
        }
        
        workItem.perform(after: 1.0) { [weak self] in
            guard let self = self else { return }
            self.searchText = searchText
            self.presenter.searchMovies(for: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetViews()
    }
}


class WorkItem {
    
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    func perform(after: TimeInterval, _ block: @escaping (()->Void)) {
        // Cancel the currently pending item
        pendingRequestWorkItem?.cancel()
        
        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem(block: block)
        
        pendingRequestWorkItem = requestWorkItem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + after, execute: requestWorkItem)
    }
}
