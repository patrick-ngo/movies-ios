//
//  MovieListingsCell.swift
//  movies-ios
//
//  Created by Patrick Ngo on 14/06/19.
//  Copyright © 201 patrickngo. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

struct MovieListCellViewModel: Equatable {
  let title: String?
  let genres: String?
  let posterUrl: String?
  let popularity: String?
}

final class MovieListCell: UITableViewCell {
  
  private enum Constants {
    static let BASE_URL_IMAGES_LOW = "https://image.tmdb.org/t/p/w185"
    static let BASE_URL_IMAGES_HIGH = "https://image.tmdb.org/t/p/w500"
  }
  
  //MARK: - Views
  
  let posterImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.clipsToBounds = true
    return iv
  }()
  
  let popularityLabel: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 1
    lbl.font = UIFont.systemFont(ofSize: 12)
    lbl.textColor = UIColor.Text.darkGrey
    lbl.text = ""
    lbl.textAlignment = .left
    return lbl
  }()
  
  let genresLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 11)
    lbl.textColor = UIColor.Text.darkGrey
    lbl.textAlignment = .left
    lbl.numberOfLines = 0
    return lbl
  }()
  
  lazy var titleLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
    lbl.textColor = UIColor.Text.darkGrey
    lbl.textAlignment = .left
    lbl.numberOfLines = 0
    return lbl
  }()
  
  //MARK: - Init
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style:style, reuseIdentifier:reuseIdentifier)
    self.setupViews()
  }
  
  func setupViews() {
    selectionStyle = .none
    contentView.addSubview(posterImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(genresLabel)
    contentView.addSubview(popularityLabel)
    
    posterImageView.snp.makeConstraints { (make) in
      make.left.equalTo(contentView.snp.left).offset(10)
      make.width.height.equalTo(70)
      make.top.equalTo(4)
      make.bottom.equalTo(0).offset(-4)
    }
    titleLabel.snp.makeConstraints { (make) in
      make.left.equalTo(posterImageView.snp.right).offset(10)
      make.right.equalTo(contentView)
      make.height.equalTo(15)
      make.top.equalTo(4)
    }
    genresLabel.snp.makeConstraints { (make) in
      make.left.equalTo(posterImageView.snp.right).offset(10)
      make.right.equalTo(contentView)
      make.height.equalTo(16)
      make.top.equalTo(titleLabel.snp.bottom).offset(4)
    }
    popularityLabel.snp.makeConstraints { (make) in
      make.left.equalTo(posterImageView.snp.right).offset(10)
      make.right.equalTo(contentView)
      make.height.equalTo(16)
      make.top.equalTo(genresLabel.snp.bottom).offset(4)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Highlight
  
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    if highlighted {
      self.backgroundColor = UIColor.Button.purple.withAlphaComponent(0.3)
    } else {
      self.backgroundColor = .white
    }
  }
  
  // MARK: - Update
  
  func update(with viewModel: MovieListCellViewModel) {
    titleLabel.text = viewModel.title
    genresLabel.text = viewModel.genres
    popularityLabel.text = viewModel.popularity
    
    let imageUrl = URL(string: "\(Constants.BASE_URL_IMAGES_LOW)\(viewModel.posterUrl ?? "")")
    posterImageView.sd_setImage(with: imageUrl, placeholderImage: nil)
  }
}
