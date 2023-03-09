//
//  Webservice.swift
//  MovieApp
//
//  Created by T65713 on 9.03.2023.
//

import Foundation

public enum MovieError : Error {
    case serverError
    case parsingEror
}

class Webservice {
    
    func getMovie(url: URL, completion: @escaping (Result<Movie,MovieError>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.serverError))
            } else if let data = data {
                let movie = try? JSONDecoder().decode(Movie.self, from: data)
                
                if let movie = movie {
                    completion(.success(movie))
                } else {
                    completion(.failure(.parsingEror))
                }
            }
            
        }.resume()
    }
    
    func searchMovies(url: URL, completion: @escaping (Result<SearchResult,MovieError>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.serverError))
            } else if let data = data {
                let movie = try? JSONDecoder().decode(SearchResult.self, from: data)
                
                if let movie = movie {
                    completion(.success(movie))
                } else {
                    completion(.failure(.parsingEror))
                }
            }
            
        }.resume()
    }
}
