//
//  MovieDetailView.swift
//  MoviesApp
//
//  Created by SilvaKirsimae on 16/02/2020.
//  Copyright © 2020 Silva. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MovieDetailViewController: UITableViewController, MovieInfoDelegate, MovieTrailerDelegate {
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var trailerButton: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let playerVC = segue.destination as? WKYTPlayerViewController {

        guard let key = videos?.results[0].key else { return }
        print(key)
        playerVC.key = key
       }
    }

    func didUpdateGenres(_ movieManager: MovieManager, info: Info) {
        DispatchQueue.main.async {
            self.info = Info.init(genres: info.genres)
            self.genresLabel.text = ""
            
            for genre in info.genres {
                self.genresLabel.text = (self.genresLabel.text ?? "") + "\(genre.name), "
            }
            //Remove last two characters (comma and space) from the string
            self.genresLabel.text = String(self.genresLabel.text?.dropLast(2) ?? "")
            self.tableView.reloadData()
        }
    }
    
    func didFetchTrailer(_ movieManager: MovieManager, videos: Videos) {
        DispatchQueue.main.async {
            self.videos = Videos.init(results: videos.results)
            self.trailerButton.isEnabled = true
            self.trailerButton.backgroundColor = .link
        }
    }
    
    var movie: Results?
    var movieManager = MovieManager()
    var info: Info?
    var videos: Videos?
    
    override func viewWillAppear(_ animated: Bool) {
        movieManager.fetchGenre(movie: movie)
        movieManager.fetchTrailer(movie: movie)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieManager.infoDelegate = self as MovieInfoDelegate
        movieManager.trailerDelegate = self as MovieTrailerDelegate
        movieTitleLabel.text = movie?.title
        let imageUrlString = "https://image.tmdb.org/t/p/w500/"
        let imageUrl = URL(string: imageUrlString + (movie?.poster_path ?? ""))
        let imageData = try! Data(contentsOf: imageUrl!)
        movieImage.image = UIImage(data: imageData)
        dateLabel.text = movie?.release_date ?? ""
        overviewLabel.text = movie?.overview ?? ""
        
    }

}
