//
//  MovieDetailView.swift
//  MoviesApp
//
//  Created by SilvaKirsimae on 16/02/2020.
//  Copyright © 2020 Silva. All rights reserved.
//

import UIKit

class MovieDetailViewController: UITableViewController {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Results?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitleLabel.text = movie?.title
        let imageUrlString = "https://image.tmdb.org/t/p/w500/"

        let imageUrl = URL(string: imageUrlString + (movie?.poster_path ?? ""))

        let imageData = try! Data(contentsOf: imageUrl!)
        movieImage.image = UIImage(data: imageData)
        dateLabel.text = movie?.release_date ?? ""
        overviewLabel.text = movie?.overview ?? ""
    }

}
