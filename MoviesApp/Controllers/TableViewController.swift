//
//  TableViewController.swift
//  MoviesApp
//
//  Created by SilvaKirsimae on 22/11/2019.
//  Copyright © 2019 Silva. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, MovieManagerDelegate {
    func didUpdateMovies(_ movieManager: MovieManager, movies: Movie) {
        DispatchQueue.main.async {
            self.movies = Movie.init(results: movies.results)
            self.tableView.reloadData()
        }
    }
    var movies: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var movieManager = MovieManager()
        movieManager.delegate = self
        movieManager.fetchMovies()
    }

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell") as? MoviesTableViewCell else {
            return UITableViewCell()
        }
        cell.movieLabel.text = movies?.results[indexPath.row].title
        
        let imageUrlString = "https://image.tmdb.org/t/p/w500/"

        let imageUrl = URL(string: imageUrlString + (movies?.results[indexPath.row].poster_path ?? ""))

        let imageData = try! Data(contentsOf: imageUrl!)

        cell.movieImage.image = UIImage(data: imageData)
        return cell
    }

}
