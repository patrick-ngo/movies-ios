//
//  MovieDetailViewController.swift
//  movies-ios
//
//  Created by Patrick Ngo on 14/06/19.
//  Copyright © 2019 patrickngo. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol MovieDetailViewControllerInput: View where AssociatedState == MovieDetailState {}


final class MovieDetailViewController: UIViewController,
                                       MovieDetailViewControllerInput {
  
  private enum Constants {
    static let BASE_URL_IMAGES_LOW = "https://image.tmdb.org/t/p/w185"
    static let BASE_URL_IMAGES_HIGH = "https://image.tmdb.org/t/p/w500"
  }
  var intent: MovieDetailIntentInput?
  let disposeBag = DisposeBag()
  
  //MARK: - Views
  
  let scrollView: UIScrollView = {
    let sv = UIScrollView()
    sv.backgroundColor = .white
    sv.alwaysBounceVertical = true
    return sv
  }()
  
  let posterImageView: UIImageView = {
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
  
  let titleLabel: UILabel = {
    let lbl = UILabel()
    lbl.text = ""
    lbl.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
    lbl.textColor = UIColor.Text.darkGrey
    lbl.numberOfLines = 0
    return lbl
  }()
  
  let synopsysLabel: UILabel = {
    let lbl = UILabel()
    lbl.text = ""
    lbl.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
    lbl.textColor = UIColor.Text.darkGrey
    lbl.numberOfLines = 0
    lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
    return lbl
  }()
  
  let genresLabel: UILabel = {
    let lbl = UILabel()
    lbl.text = ""
    lbl.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
    lbl.textColor = UIColor.Text.darkGrey
    return lbl
  }()
  
  let languageLabel: UILabel = {
    let lbl = UILabel()
    lbl.text = ""
    lbl.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
    lbl.textColor = UIColor.Text.darkGrey
    return lbl
  }()
  
  let runtimeLabel: UILabel = {
    let lbl = UILabel()
    lbl.text = ""
    lbl.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
    lbl.textColor = UIColor.Text.darkGrey
    return lbl
  }()
  
  //MARK: - Init
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavBar()
    setupViews()
    
    intent?.bind(to: self)
    intent?.getMovie()
  }
  
  private func setupNavBar() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back",
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(onBackButtonTapped))
  }
  
  @objc func onBackButtonTapped() {
    intent?.goBack()
  }
  
  func setupViews() {
    view.addSubview(scrollView)
    scrollView.addSubview(gradientView)
    scrollView.addSubview(posterImageView)
    scrollView.addSubview(titleLabel)
    scrollView.addSubview(synopsysLabel)
    scrollView.addSubview(genresLabel)
    scrollView.addSubview(languageLabel)
    scrollView.addSubview(runtimeLabel)
    
    scrollView.snp.makeConstraints { (make) in
      make.edges.equalTo(0)
    }
    gradientView.snp.makeConstraints { (make) in
      make.height.equalTo(300)
      make.right.left.equalTo(view)
    }
    posterImageView.snp.makeConstraints { (make) in
      make.centerX.equalTo(scrollView.snp.centerX)
      make.top.equalTo(0)
      make.height.equalTo(300)
    }
    titleLabel.snp.makeConstraints { (make) in
      make.top.equalTo(posterImageView.snp.bottom).offset(10)
      make.left.right.equalTo(15)
    }
    genresLabel.snp.makeConstraints { (make) in
      make.top.equalTo(titleLabel.snp.bottom).offset(10)
      make.left.right.equalTo(15)
    }
    synopsysLabel.snp.makeConstraints { (make) in
      make.top.equalTo(genresLabel.snp.bottom).offset(10)
      make.centerX.equalToSuperview()
      make.left.right.equalTo(15)
    }
    languageLabel.snp.makeConstraints { (make) in
      make.top.equalTo(synopsysLabel.snp.bottom).offset(10)
      make.left.right.equalTo(15)
    }
    runtimeLabel.snp.makeConstraints { (make) in
      make.top.equalTo(languageLabel.snp.bottom).offset(10)
      make.left.right.equalTo(15)
      make.bottom.equalToSuperview().offset(-30)
    }
  }
  
  func update(with state: MovieDetailState, prevState: MovieDetailState?) {
    titleLabel.text = state.title
    synopsysLabel.text = state.synopsys
    genresLabel.text = state.genres
    languageLabel.text = state.language
    runtimeLabel.text = state.runtime
    
    let imageUrl = URL(string: "\(Constants.BASE_URL_IMAGES_HIGH)\(state.posterPath)")
    posterImageView.sd_setImage(with: imageUrl, placeholderImage: nil)
  }
}
