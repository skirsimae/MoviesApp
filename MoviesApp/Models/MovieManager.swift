//
//  MovieManager.swift
//  MoviesApp
//
//  Created by SilvaKirsimae on 25/11/2019.
//  Copyright © 2019 Silva. All rights reserved.
//

import Foundation

protocol MovieManagerDelegate {
    func didUpdateMovies(_ movieManager: MovieManager, movies: Movie)
}

protocol MovieInfoDelegate {
    func didUpdateGenres(_ movieManager: MovieManager, info: Info)
}

struct MovieManager {
    let key = moviesAPIKey
    let baseURL = "https://api.themoviedb.org/3/movie/"
    let popularMoviesURL: String = "popular?api_key="
    let movieDetailsURL: String = "271110?api_key="
    var movieDelegate: MovieManagerDelegate?
    var infoDelegate: MovieInfoDelegate?
    
    func fetchMovies() {
        let url = URL(string: "\(baseURL)\(popularMoviesURL)\(key)&page=1")!
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                fatalError("Error: invalid HTTP response code")
            }
            guard let data = data else {
                fatalError("Error: missing response data")
            }

            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode(Movie.self, from: data)
                print(movies)
                self.movieDelegate?.didUpdateMovies(self, movies: movies)
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        
       
        //Start the task
        task.resume()
    }
    
    func fetchGenre(movie: Results?) {
        guard let id = movie?.id else { return }

        let url = URL(string: "\(baseURL)\(id)?api_key=\(key)&language=en-US")!
//        var genres: [Genres] = []
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                 fatalError("Error: \(error.localizedDescription)")
             }
             guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                 fatalError("Error: invalid HTTP response code")
             }
            
             guard let data = data else {
                 fatalError("Error: missing response data")
             }
            print(data)

             do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(Info.self, from: data)
                self.infoDelegate?.didUpdateGenres(self, info: results)
//                let genres = results.genres
//                for genre in results.genres {
//                    print(genre.name)
//                    genres.append(genre.name)
//                }
             }
             catch {
                 debugPrint(error)
                 print("Error: \(error.localizedDescription)")
             }
        }
        //Start the task
        task.resume()
//        return genres
    }
}

