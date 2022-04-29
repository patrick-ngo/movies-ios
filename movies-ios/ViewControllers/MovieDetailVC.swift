//
//  MovieDetailVC.swift
//  movies-ios
//
//  Created by Patrick Ngo on 14/06/19.
//  Copyright © 2019 patrickngo. All rights reserved.
//

import UIKit
import SnapKit
import ReSwift
import RxSwift
import RxCocoa

class MovieDetailVC: UIViewController, StoreSubscriber {
  
  private enum Constants {
    static let BASE_URL_IMAGES_LOW = "https://image.tmdb.org/t/p/w185"
    static let BASE_URL_IMAGES_HIGH = "https://image.tmdb.org/t/p/w500"
  }
  
  typealias StoreSubscriberStateType = MovieDetailState
  
  let disposeBag = DisposeBag()
  
  var movieId: Int? = nil
  
  private let locale = NSLocale(localeIdentifier: NSLocale.current.languageCode!)
  
  private var movie: Movie? = nil {
    didSet {
      guard let movie = movie else { return }
      
      // Poster
      if let profilePic = movie.poster_path {
        let imageUrl = URL(string: "\(Constants.BASE_URL_IMAGES_HIGH)\(profilePic)")
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
      if let genres = movie.genre_ids, genres.count > 0 {
        // Match genre ids with genre names
        let genreNames = genres.map { (genreId) -> String in
          if let genre = MovieUtil.allGenres().first(where: { genreId == $0.id() }) {
            return genre.name()
          }
          return ""
        }
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
    sv.backgroundColor = .white
    sv.alwaysBounceVertical = true
    return sv
  }()
  
  let posterImageView : UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.clipsToBounds = true
    return iv
  }()
  
  let gradientView: UIView = {
    let v = UIView(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: 300))
    v.addGradientAtBottom()
    return v
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
    lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
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
  
  //MARK: - Init -
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupViews()
    self.loadData()
    
    mainStore.subscribe(self) { subcription in
      subcription.select { state in state.movieDetailState }
    }
  }
  
  func setupViews() {
    self.view.addSubview(self.scrollView)
    self.scrollView.addSubview(self.gradientView)
    self.scrollView.addSubview(self.posterImageView)
    
    self.scrollView.addSubview(self.titleLabel)
    self.scrollView.addSubview(self.synopsysLabel)
    self.scrollView.addSubview(self.genresLabel)
    self.scrollView.addSubview(self.languageLabel)
    self.scrollView.addSubview(self.runtimeLabel)
    
    self.scrollView.snp.makeConstraints { (make) in
      make.edges.equalTo(0)
    }
    
    self.gradientView.snp.makeConstraints { (make) in
      make.height.equalTo(300)
      make.right.left.equalTo(self.view)
    }
    
    self.posterImageView.snp.makeConstraints { (make) in
      make.centerX.equalTo(self.scrollView.snp.centerX)
      make.top.equalTo(0)
      make.height.equalTo(300)
    }
    self.titleLabel.snp.makeConstraints { (make) in
      make.top.equalTo(self.posterImageView.snp.bottom).offset(10)
      make.left.right.equalTo(15)
    }
    
    self.genresLabel.snp.makeConstraints { (make) in
      make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
      make.left.right.equalTo(15)
    }
    
    self.synopsysLabel.snp.makeConstraints { (make) in
      make.top.equalTo(self.genresLabel.snp.bottom).offset(10)
      make.centerX.equalToSuperview()
      make.left.right.equalTo(15)
    }
    
    self.languageLabel.snp.makeConstraints { (make) in
      make.top.equalTo(self.synopsysLabel.snp.bottom).offset(10)
      make.left.right.equalTo(15)
    }
    
    self.runtimeLabel.snp.makeConstraints { (make) in
      make.top.equalTo(self.languageLabel.snp.bottom).offset(10)
      make.left.right.equalTo(15)
      make.bottom.equalToSuperview().offset(-30)
    }
  }
  
  //MARK: - State Updates -
  func newState(state: MovieDetailState) {
    if let selectedMovie = state.selectedMovie {
      self.movie = selectedMovie
    }
  }
  
  
  func loadData() {
    mainStore.dispatch(fetchRelatedMovies)
  }
}
