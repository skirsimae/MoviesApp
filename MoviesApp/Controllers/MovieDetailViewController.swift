//
//  MovieDetailView.swift
//  MoviesApp
//
//  Created by SilvaKirsimae on 16/02/2020.
//  Copyright © 2020 Silva. All rights reserved.
//

import UIKit

class MovieDetailViewController: UITableViewController, MovieInfoDelegate {
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    func didUpdateGenres(_ movieManager: MovieManager, info: Info) {
        DispatchQueue.main.async {
            self.info = Info.init(genres: info.genres)
            var genres: String = ""
            self.genresLabel.text = ""
            
            
            for genre in info.genres {
                genres = (self.genresLabel.text ?? "") + "\(genre.name), "
                self.genresLabel.text = genres
            }
            
            //Todo: remove comma at the end of the genre list

//            let size = genres.count
//            let lastWord = genres.index(genres.endIndex, offsetBy: -size)
//            var last = genres[lastWord...]
//            let characters: Set<Character> = [" ", ","]
//            last.removeAll(where: { characters.contains($0) })

            self.tableView.reloadData()
        }
    }
    
    
    var movie: Results?
    var movieManager = MovieManager()
    var info: Info?
    
    override func viewWillAppear(_ animated: Bool) {
        movieManager.fetchGenre(movie: movie)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieManager.infoDelegate = self
        
        movieTitleLabel.text = movie?.title
        let imageUrlString = "https://image.tmdb.org/t/p/w500/"
        let imageUrl = URL(string: imageUrlString + (movie?.poster_path ?? ""))
        let imageData = try! Data(contentsOf: imageUrl!)
        movieImage.image = UIImage(data: imageData)
        dateLabel.text = movie?.release_date ?? ""
        overviewLabel.text = movie?.overview ?? ""
        
    }

}
