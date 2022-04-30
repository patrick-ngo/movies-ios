//
//  MovieListingsVC.swift
//  movies-ios
//
//  Created by Patrick Ngo on 14/06/19.
//  Copyright © 2019 patrickngo. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol MovieListViewControllerInput: View where AssociatedState == MovieListState {}

final class MovieListViewController: UIViewController,
                                     UITableViewDelegate,
                                     UITableViewDataSource,
                                     MovieListViewControllerInput {
  
  var intent: MovieListIntentInput?
  
  private var hasNext = true
  private var movieList: [Movie] = []
  private var isLoading =  false
  
  //MARK: - Views
  
  private lazy var tableView : UITableView = {
    let tv = UITableView(frame: .zero, style: .plain)
    tv.separatorStyle = .singleLine
    tv.separatorColor = UIColor.Border.around
    tv.delegate = self
    tv.dataSource = self
    tv.register(MovieListCell.self, forCellReuseIdentifier: String(describing: MovieListCell.self))
    tv.register(LoadingCell.self, forCellReuseIdentifier: String(describing: LoadingCell.self))
    tv.rowHeight = UITableView.automaticDimension
    tv.estimatedRowHeight = 80
    return tv
  }()
  
  private lazy var refreshControl:UIRefreshControl = {
    let rc = UIRefreshControl()
    rc.addTarget(self, action: #selector(onRefreshPulled), for: .valueChanged)
    return rc
  }()
  
  //MARK: - Init
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavBar()
    setupViews()
    
    intent?.bind(to: self)
    intent?.getMovies()
  }
  
  func setupNavBar() {
    guard let navBar = self.navigationController?.navigationBar else { return }
    navBar.tintColor = .black
    navBar.barTintColor = .white
    navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    self.navigationItem.title = NSLocalizedString("Now Playing", comment: "Now Playing")
  }
  
  func setupViews() {
    view.addSubview(tableView)
    tableView.refreshControl = refreshControl
    
    tableView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalTo(0)
      make.top.equalToSuperview()
    }
  }
  
  // MARK: - Update from State

  func update(with state: MovieListState, prevState: MovieListState?) {
    hasNext = state.hasNext
    isLoading = state.isLoading

    if !state.isLoading,
       refreshControl.isRefreshing {
      refreshControl.endRefreshing()
    }

    if state.movies != prevState?.movies {
      movieList = state.movies
      tableView.reloadData()
    }
  }
  
  // MARK: - Interactions
  
  @objc func onRefreshPulled() {
     intent?.getMovies()
   }
  
  func onEndOfListReached() {
    intent?.getMoreMovies()
  }
  
  func onMovieCellTapped(with index: Int) {
    intent?.goToMovieDetail(with: index)
  }
  
  //MARK: - TableViewDelegate
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if hasNext {
      return movieList.count + 1
    }
    return movieList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if hasNext,
       indexPath.row >= movieList.count - 1 {
      onEndOfListReached()
    }
    
    if hasNext,
       indexPath.row >= movieList.count {
      let loadingCell = tableView.dequeueReusableCell(withIdentifier: String(describing: LoadingCell.self), for: indexPath)
      return loadingCell
    }
    
    let movieCell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieListCell.self), for: indexPath)
    if let movieListCell = movieCell as? MovieListCell {
      let movie = movieList[indexPath.row]
      movieListCell.movie = movie
    }
    return movieCell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    onMovieCellTapped(with: indexPath.row)
  }
}

