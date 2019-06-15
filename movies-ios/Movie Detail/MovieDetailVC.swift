//
//  MovieDetailVC.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2019-06-14.
//  Copyright © 2019 patrickngo. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {
    var movieId: Int? = nil
    
    private let locale = NSLocale(localeIdentifier: NSLocale.current.languageCode!)
    
    private var movie: MovieModel? = nil {
        didSet {
            guard let movie = movie else { return }
            
            // Poster
            if let profilePic = movie.poster_path {
                let imageUrl = URL(string: "\(MoviesAPI.BASE_URL_IMAGES_HIGH)\(profilePic)")
                self.posterImageView.sd_setImage(with: imageUrl, placeholderImage: nil)
            }
            
            // Title
            if let name = movie.title {
                self.titleLabel.text = name
                
                // Also change navigation bar title
                self.title = name
            }
            
            // Synopsys
            if let overview = movie.overview {
                self.synopsysLabel.text = overview
            }
            
            // Genres
            if let genres = movie.genres, genres.count > 0 {
                let genreNames = genres.map { $0.name ?? "" }
                self.genresLabel.text = genreNames.joined(separator: " • ")
            }
            
            // Language
            if let original_language = movie.original_language {
                if let language = self.locale.displayName(forKey: NSLocale.Key.identifier, value: original_language) {
                    self.languageLabel.text = "\(NSLocalizedString("LABEL_LANGUAGE", comment: "Language")) \(language)"
                }
            }
            
            // Runtime
            if let runtime = movie.runtime {
                self.languageLabel.text = "\(NSLocalizedString("LABEL_RUNTIME", comment: "Runtime")) \(runtime)m"
            }
        }
    }
    
    //MARK: - Views -
    
    let scrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor =  UIColor.Background.grey
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    let containerView: UIView = {
        let iv = UIView()
        iv.backgroundColor = .white
        return iv
    }()
    
    let posterImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let titleLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        lbl.textColor = UIColor.Text.darkGrey
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let synopsysLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        lbl.textColor = UIColor.Text.darkGrey
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let genresLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        lbl.textColor = UIColor.Text.darkGrey
        return lbl
    }()
    
    let languageLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        lbl.textColor = UIColor.Text.darkGrey
        return lbl
    }()
    
    let runtimeLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        lbl.textColor = UIColor.Text.darkGrey
        return lbl
    }()
    
    lazy var bookButton : UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle(NSLocalizedString("BUTTON_BOOK_MOVIE", comment: "Book movie").uppercased(), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        btn.backgroundColor = UIColor.Button.purple
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(onPressBook), for: .touchUpInside)
        
        return btn
    }()
    

    
    //MARK: - Init -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.loadData()
    }
    
    func setupViews() {
        self.view.addSubview(self.containerView)
        self.containerView.addSubview(self.scrollView)
        self.containerView.addSubview(self.bookButton)

        self.scrollView.addSubview(self.posterImageView)
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.synopsysLabel)
        self.scrollView.addSubview(self.genresLabel)
        self.scrollView.addSubview(self.languageLabel)
        self.scrollView.addSubview(self.runtimeLabel)
        
        self.containerView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
        self.scrollView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(self.bookButton.snp.top)
        }

        self.posterImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.scrollView.snp.top).offset(20)
            make.centerX.equalTo(self.scrollView.snp.centerX)
            make.width.height.equalTo(300)
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.posterImageView.snp.bottom).offset(10)
            make.centerX.equalTo(self.posterImageView.snp.centerX)
            make.left.right.equalTo(15)
        }
        
        self.genresLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.centerX.equalTo(self.posterImageView.snp.centerX)
            make.left.right.equalTo(15)
        }
        
        self.synopsysLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.genresLabel.snp.bottom).offset(10)
            make.centerX.equalTo(self.posterImageView.snp.centerX)
            make.left.right.equalTo(15)
        }

        self.languageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.synopsysLabel.snp.bottom).offset(10)
            make.centerX.equalTo(self.posterImageView.snp.centerX)
            make.left.right.equalTo(15)
        }

        self.runtimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.languageLabel.snp.bottom).offset(10)
            make.centerX.equalTo(self.posterImageView.snp.centerX)
            make.left.right.equalTo(15)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        self.bookButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(0)
            }
            make.height.equalTo(50)
        }
    }
    
    func loadData() {
        guard let movieId = self.movieId else { return }
        
        MoviesAPI.shared.retrieveMovie(byId: movieId) { (result, error) in
            if let result = result, error == nil {
                do {
                    let movieResponse = try JSONDecoder().decode(MovieModel.self, from: result)

                    // Set movie
                    self.movie = movieResponse
                }
                catch let error {
                    let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    
    //MARK: - Actions -
    @objc func onPressBook() {
        if let url = URL(string: MoviesAPI.CATHAY_URL) {
            UIApplication.shared.open(url)
        }
    }
}
