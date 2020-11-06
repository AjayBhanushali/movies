//
//  MovieDetailsVC.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import UIKit
import AVKit

final class MovieDetailsVC: UIViewController {
    
    var presenter: MovieDetailsViewOutput!
    var viewState: ViewState = .none
    var movieDetailsViewModel: MovieDetailsViewModel? {
        didSet {
            guard let movieDetailsViewModel = movieDetailsViewModel else {
                return
            }
            title = movieDetailsViewModel.movie?.title
            
        }
    }
    var headers = ["", Strings.synopsis, Strings.cast, Strings.reviews, Strings.similarMovies]
    var storedOffsets = [Int: CGFloat]()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.backgroundColor = .appWhite()
        tableView.sectionHeaderHeight = 56
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    //MARK: ViewController Lifecycle
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        navigationItem.title = ""//Strings.moviesDBTitle
        setNavbarTransculent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.getMovieDetails()
        setNavbarTransculent()
    }
    
    private func setupViews() {
        configureTableView()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.pinEdgesToSuperview()
        tableView.register(ContainerCell.self, forCellReuseIdentifier: "ContainerCell")
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
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(arrayLiteral: index), with: .none)
        tableView.endUpdates()
    }
}

extension MovieDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.isKind(of: UITableView.self) else { return }
        let denominator: CGFloat = 50 //your offset treshold
        let alpha = min(1, scrollView.contentOffset.y / denominator)
        setNavbar(backgroundColorAlpha: alpha)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let viewModel = movieDetailsViewModel else { return 0 }
        switch section {
        case 0:
            return 0
        case 2:
            if viewModel.credits?.cast?.count != nil {
                return tableView.sectionHeaderHeight
            }
            return 0
        case 3:
            if viewModel.reviews.count > 0 {
                return tableView.sectionHeaderHeight
            }
            return 0
        case 4:
            if viewModel.similarMovies.count > 0 {
                return tableView.sectionHeaderHeight
            }
            return 0
        default:
            return tableView.sectionHeaderHeight
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let viewModel = movieDetailsViewModel else { return 0 }
        switch indexPath.section {
        case 0:
            let itemWidth: CGFloat = UIScreen.main.bounds.width
            let itemHeight: CGFloat = itemWidth*9/16
            return itemHeight
        case 1:
            let itemHeight: CGFloat = 104
            return itemHeight
        case 2:
            if viewModel.credits?.cast?.count != nil {
                let itemHeight: CGFloat = 140
                return itemHeight
            }
            return 0
            
        case 3:
            if viewModel.reviews.count > 0 {
                let itemHeight: CGFloat = 120
                return itemHeight
            }
            return 0
        case 4:
            if viewModel.similarMovies.count > 0 {
                let itemWidth: CGFloat = (UIScreen.main.bounds.width - (Constants.numberOfColumns - Constants.defaultSpacing) - 2) / Constants.numberOfColumns
                let itemHeight: CGFloat = (itemWidth - Constants.defaultPadding*2) * 1.5
                return itemHeight
            }
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? ContainerCell else { return }

        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard let tableViewCell = cell as? ContainerCell else { return }

        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContainerCell", for: indexPath) as! ContainerCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
            return headers[section]
        }
        return nil
    }
}

extension MovieDetailsVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 2:
            return movieDetailsViewModel?.credits?.cast?.count ?? 0
        case 3:
            return movieDetailsViewModel?.reviews.count ?? 0
        case 4:
            return movieDetailsViewModel?.similarMovies.count ?? 0
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch collectionView.tag {
        case 0: // BackDrop
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as GenericCollectionViewCell<BackDropView>
            guard let viewModel = movieDetailsViewModel?.movie else {
                return cell
            }
            
            let itemWidth: CGFloat = UIScreen.main.bounds.width
            let itemHeight: CGFloat = itemWidth*9/16
            
            
            guard cell.cellView != nil else {
                let cellView = BackDropView(frame: .zero)
                cell.cellView = cellView
                cell.cellView?.movie = viewModel
                if let imageURL = movieDetailsViewModel?.backDropURL() {
                    cell.cellView?.configure(imageURL: imageURL, size: CGSize(width: itemWidth, height: itemHeight), indexPath: indexPath)
                }
                return cell
            }

            cell.cellView?.movie = viewModel
            if let imageURL = movieDetailsViewModel?.backDropURL() {
                cell.cellView?.configure(imageURL: imageURL, size: CGSize(width: itemWidth, height: itemHeight), indexPath: indexPath)
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as GenericCollectionViewCell<SynonpsisView>
            guard let viewModel = movieDetailsViewModel?.synopsis else {
                return cell
            }

            guard cell.cellView != nil else {
                let cellView = SynonpsisView(frame: .zero)
                cell.cellView = cellView
                cell.cellView?.synopsis = viewModel
                return cell
            }

            cell.cellView?.synopsis = viewModel
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as GenericCollectionViewCell<CastView>

            guard let viewModel = movieDetailsViewModel?.credits?.cast?[indexPath.item] else {
                return cell
            }

            let imageWidth: CGFloat = 100
            let imageSize = CGSize(width: imageWidth, height: imageWidth)

            guard cell.cellView != nil else {
                let cardView = CastView(frame: .zero)
                cell.cellView = cardView
                cell.cellView?.movie = viewModel
                if let imageURL = viewModel.profileURL() {
                    cell.cellView?.configure(imageURL: imageURL, size: imageSize, indexPath: indexPath)
                }
                return cell
            }

            cell.cellView?.movie = viewModel
            if let imageURL = viewModel.profileURL() {
                cell.cellView?.configure(imageURL: imageURL, size: imageSize, indexPath: indexPath)
            }
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as GenericCollectionViewCell<ReviewsView>
            guard let viewModel = movieDetailsViewModel?.reviews[indexPath.item] else {
                return cell
            }

            guard cell.cellView != nil else {
                let cellView = ReviewsView(frame: .zero)
                cell.cellView = cellView
                cell.cellView?.review = viewModel
                return cell
            }

            cell.cellView?.review = viewModel
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as GenericCollectionViewCell<SimpleImageView>

            guard let viewModel = movieDetailsViewModel?.similarMovies[indexPath.item] else {
                return cell
            }

            let imageWidth: CGFloat = (UIScreen.main.bounds.width - (Constants.numberOfColumns - Constants.defaultSpacing) - 2) / Constants.numberOfColumns
            let imageSize = CGSize(width: imageWidth, height: imageWidth*1.5)

            guard cell.cellView != nil else {
                let cardView = SimpleImageView(frame: .zero)
                cell.cellView = cardView
                if let imageURL = viewModel.posterURL() {
                    cell.cellView?.configure(imageURL: imageURL, size: imageSize, indexPath: indexPath)
                }
                return cell
            }

            if let imageURL = viewModel.posterURL() {
                cell.cellView?.configure(imageURL: imageURL, size: imageSize, indexPath: indexPath)
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            let itemWidth: CGFloat = UIScreen.main.bounds.width
            let itemHeight: CGFloat = itemWidth*9/16
            return CGSize(width: itemWidth, height: itemHeight)
        case 1:
            let itemWidth: CGFloat = UIScreen.main.bounds.width
            let itemHeight: CGFloat = 104
            return CGSize(width: itemWidth, height: itemHeight)
        case 2:
            let itemWidth: CGFloat = 116
            let itemHeight: CGFloat = 140
            return CGSize(width: itemWidth, height: itemHeight)
        case 3:
            let itemWidth: CGFloat = UIScreen.main.bounds.width - 40
            let itemHeight: CGFloat = 120
            return CGSize(width: itemWidth, height: itemHeight)
        case 4:
            let itemWidth: CGFloat = (UIScreen.main.bounds.width - (Constants.numberOfColumns - Constants.defaultSpacing) - 2) / Constants.numberOfColumns
            let itemHeight: CGFloat = (itemWidth - Constants.defaultPadding*2) * 1.5
            return CGSize(width: itemWidth, height: itemHeight)
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 4 {
            presenter.didSelectMovie(at: indexPath.item)
        } else if collectionView.tag == 0 {
            configureVideoPlayer()
        }
    }
    
    private func configureVideoPlayer() {
        var aurl = "https://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v"
        guard let url = URL(string: aurl) else {
                    return
                }
                // Create an AVPlayer, passing it the HTTP Live Streaming URL.
                let player = AVPlayer(url: url)
                let controller = AVPlayerViewController()
                controller.allowsPictureInPicturePlayback = true
                controller.player = player
                present(controller, animated: true) {
                    controller.player?.play()
                }
    }
}
