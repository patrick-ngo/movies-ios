//
//  MovieListingsVC.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2019-06-15.
//  Copyright © 2019 patrickngo. All rights reserved.
//

import UIKit
import SnapKit

class MovieListingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var movieList: [MovieModel] = []
    
    private var page = 0
    private var isLoading =  false
    private var hasNext = true
    
    //MARK: - Views -
    
    private lazy var tableView : UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .plain)
        tv.separatorStyle = .none
        
        tv.delegate = self
        tv.dataSource = self
        
        // Cell registration
        tv.register(MovieListingsCell.self, forCellReuseIdentifier: String(describing: MovieListingsCell.self))
        tv.register(TableViewLoadingCell.self, forCellReuseIdentifier: String(describing: TableViewLoadingCell.self))
        
        return tv
    }()
    
    private lazy var refreshControl:UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(self.reloadData(refreshControl:)), for: .valueChanged)
        return rc
    }()
    
    //MARK: - Init -

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar()
        self.setupViews()
        self.loadData()
    }
    
    func setupNavBar() {
        guard let navBar = self.navigationController?.navigationBar else { return }
        navBar.tintColor = UIColor.white
        navBar.barTintColor = UIColor.NavBar.purple
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBar.barStyle = .black
        self.navigationItem.title = "Discover"
    }
    
     func setupViews() {
        // Add Refresh Control to Table View
        tableView.refreshControl = refreshControl
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalToSuperview()
        }
    }
    
    func loadData(reloadAll:Bool = false) {
        guard !self.isLoading else {
            return
        }
        
        // Start loading
        self.isLoading = true
        
        // Calculate new page
        self.page = reloadAll ? 1 : self.page + 1
        
        MoviesAPI.shared.retrieveMovies(page: self.page) { (result, error) in
            if let result = result, error == nil {
                do {
                    let moviesResponse = try JSONDecoder().decode(MovieListModel.self, from: result)
                    
                    // Check if there are more movies to load
                    if let totalPages = moviesResponse.total_pages {
                        self.hasNext = self.page < totalPages
                    }
                    
                    // Set list of movies
                    if let movies = moviesResponse.results {
                        self.movieList = reloadAll ? movies : self.movieList + movies
                    }
                    
                    // Reload table with new movies
                    self.tableView.reloadData()
                }
                catch let error {
                    let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            
            // End loading
            self.isLoading = false
            
            //stop refreshing
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc func reloadData(refreshControl:UIRefreshControl) {
        self.loadData(reloadAll:true)
    }

    //MARK: - TableView Datasource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Add 1 for the loading cell
        if self.hasNext {
            return movieList.count + 1
        }
        
        return movieList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Start loading more when nearing the end of list
        if indexPath.row >= self.movieList.count - 1 {
            self.loadData()
        }
        
        // Loading cell for last row
        if self.hasNext,
            indexPath.row >= self.movieList.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewLoadingCell.self))
            return cell!
        }
        
        // Get movie cell
        let movieCell = self.tableView.dequeueReusableCell(withIdentifier: String(describing: MovieListingsCell.self)) as? MovieListingsCell
        let movie = movieList[indexPath.row]
        movieCell?.movie = movie
        return movieCell!
    }
    
    
    //MARK: - TableView Delegate -
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Go to movie detail screen
        let movieDetailVC = MovieDetailVC()
        let movie = movieList[indexPath.row]
        movieDetailVC.movieId = movie.id
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}

