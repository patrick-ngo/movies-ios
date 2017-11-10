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
    
    //MARK: - Views -
    
    private lazy var tableView : UITableView = {
        
        let tv = UITableView(frame: CGRect.zero, style: .plain)
        tv.separatorStyle = .none
        
        tv.delegate = self
        tv.dataSource = self
        
        //cell registration
        tv.register(MovieListingsCell.self, forCellReuseIdentifier: String(describing: MovieListingsCell.self))
        
        return tv
    }()
    
    private let refreshControl:UIRefreshControl = {
        let rc = UIRefreshControl()
        return rc
    }()
    
    //MARK: - Init -
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavBar()
        self.setupViews()
    }
    
    func setupNavBar() {
        guard let navBar = self.navigationController?.navigationBar else { return }
        
        navBar.tintColor = UIColor.Button.pink
        navBar.barTintColor = .white
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.Button.pink]
        
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

    //MARK: - TableView Datasource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: String(describing: MovieListingsCell.self)) as? MovieListingsCell
        return cell!
    }
    
    
    //MARK: - TableView Delegate -
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //do nothing
    }
    

}

