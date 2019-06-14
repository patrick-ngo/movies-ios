//
//  MovieListingsVC.swift
//  movies-ios
//
//  Created by Patrick Ngo on 11/10/17.
//  Copyright © 2017 patrickngo. All rights reserved.
//

import UIKit
import SnapKit

class MovieListingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var movieList: [MovieModel] = []
    
    private var page = 0
    private var knownMaxItemCount = 0
    private var isLoading =  false
    private var hasNext = true
    
    //MARK: - Views -
    
    private lazy var tableView : UITableView = {
        
        let tv = UITableView(frame: CGRect.zero, style: .plain)
        tv.separatorStyle = .none
        
        tv.delegate = self
        tv.dataSource = self
        
        //cell registration
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupNavBar() {
        
        guard let navBar = self.navigationController?.navigationBar else { return }
        
        navBar.tintColor = UIColor.white
        navBar.barTintColor = UIColor.NavBar.purple
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.navigationItem.title = "TMDb"
        
        if #available(iOS 11.0, *) {
            navBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
    }
    
     func setupViews() {

        self.tableView.addSubview(self.refreshControl)
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
    }
    
    func loadData(reloadAll:Bool = false) {
        guard !self.isLoading else {
            return
        }
        
        //signal start loading
        self.isLoading = true
        
        if reloadAll {
            self.page = 1
        }
        else {
            self.page += 1
        }
        
        MoviesAPI.shared.retrieveMovies(page: self.page) { (result, error) in

            if let result = result, error == nil {
                
                do {
                    let moviesResponse = try JSONDecoder().decode(MovieListModel.self, from: result)
                    
                    //check if more to load after
                    if let totalPages = moviesResponse.total_pages {
                        self.hasNext = self.page < totalPages
                    }

                    
                    //set list of movies
                    if let movies = moviesResponse.results {
                        
                        if reloadAll {
                            self.movieList = movies
                        }
                        else {
                            self.movieList = self.movieList + movies
                        }
                    }
                    
                    //reload table
                    self.tableView.reloadData()
                }
                catch {
                    print("Error serializing json:", error)
                }
            }
            
            //signal end loading
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
        
        if self.hasNext {
            return movieList.count + 1 //add 1 for the loading cell
        }
        
        return movieList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //start loading more when nearing the end
        if indexPath.row >= self.movieList.count - 1 {
            self.loadData()
        }
        
        //loading cell for last row
        if self.hasNext,
            indexPath.row >= self.movieList.count {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewLoadingCell.self))
            return cell!
        }
        
        let movieCell = self.tableView.dequeueReusableCell(withIdentifier: String(describing: MovieListingsCell.self)) as? MovieListingsCell
        
        //set movie
        let movie = movieList[indexPath.row]
        movieCell?.updateWith(movie: movie)
        
        return movieCell!
    }
    
    
    //MARK: - TableView Delegate -
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //do nothing
    }
    

}

