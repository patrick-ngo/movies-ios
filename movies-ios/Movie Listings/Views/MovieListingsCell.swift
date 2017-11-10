//
//  MovieListingsCell.swift
//  movies-ios
//
//  Created by Patrick Ngo on 11/10/17.
//  Copyright © 2017 patrickngo. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class MovieListingsCell: UITableViewCell {
    
    //MARK: - Display data -
    
    func updateWith(movie: MovieModel?) {
        guard let movie = movie else { return }
        
        //name
        if let name = movie.title {
            self.nameLabel.text = name
        }
        
        //categories
        if let genres = movie.genre_ids, genres.count > 0 {
            
            //for each category string from api, find matching ProfessionalCategory enum
            var genreNames:[String] = []
            for genreId in genres {
                
                if let genre = Constants.allGenres().first(where: { genreId == $0.id() }) {
                    genreNames.append(genre.name())
                }
            }
            
            self.categoryLabel.text = genreNames.joined(separator: " • ")
        }
        
        //poster image
        if let poster = movie.poster_path {
            
            let imageUrl = URL(string: "\(MoviesAPI.BASE_URL_IMAGES_LOW)\(poster)")
            self.posterImageView.sd_setImage(with: imageUrl, placeholderImage: nil)
        }
        
        //review rating
        if let average = movie.vote_average, average > 0{
            self.noReviewsLabel.text = String(average)
        }
    }
    

    
    //MARK: - Views -
    
    let posterImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 25 //size 50
        iv.layer.borderColor = UIColor.Border.around.cgColor
        iv.layer.borderWidth = 1
        iv.backgroundColor = UIColor.white
        return iv
    }()
    
    let noReviewsLabel : UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = UIColor.Text.darkGrey
        lbl.text = "Not enough ratings"
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    let categoryLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 11)
        lbl.textColor = UIColor.Text.darkGrey
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    lazy var nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textColor = UIColor.Text.darkGrey
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    //MARK: - Init -
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        
        self.setupViews()
    }
    
    func setupViews() {
        self.selectionStyle = .none
        
        self.contentView.addSubview(self.posterImageView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.categoryLabel)
        self.contentView.addSubview(self.noReviewsLabel)
        
        self.posterImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-15)
            make.left.equalTo(self.contentView.snp.left).offset(10)
            make.width.height.equalTo(50)
        }
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.posterImageView.snp.right).offset(10)
            make.right.equalTo(self.contentView)
            make.height.equalTo(15)
            make.bottom.equalTo(self.categoryLabel.snp.top).offset(0)
        }
        
        self.categoryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.posterImageView.snp.right).offset(10)
            make.right.equalTo(self.contentView)
            make.height.equalTo(13)
            make.centerY.equalTo(self.posterImageView.snp.centerY).offset(0)
        }
        
        self.noReviewsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.posterImageView.snp.right).offset(10)
            make.right.equalTo(self.contentView)
            make.height.equalTo(15)
            make.top.equalTo(self.categoryLabel.snp.bottom).offset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Methods -
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.backgroundColor = UIColor.Button.purple.withAlphaComponent(0.3)
        } else {
            self.backgroundColor = .white
        }
    }
}
