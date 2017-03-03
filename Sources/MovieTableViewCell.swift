//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Andrew Ervin Gierke on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    //MARK: - Properties 
    
    var movies: DMNMovie? {
        didSet {
            updateViews()
        }
    }
    
    
    //MARK: - Update View
    
    func updateViews() {
        guard let movie = self.movies else { return }
        self.movieTitleLabel.text = movie.title
        self.ratingLabel.text = "\(movie.rating)"
        self.overviewLabel.text = movie.overview
        
        DMNMovieController.fetchPoster(movie.posterImage, completion: { (image) in
            DispatchQueue.main.async {
                self.posterImageView.image = image
            }
        })
    }
}
