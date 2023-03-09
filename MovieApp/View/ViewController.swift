//
//  ViewController.swift
//  MovieApp
//
//  Created by T65713 on 9.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    public let movieInfo : PublishSubject<Movie> = PublishSubject()
    public let searchResults : PublishSubject<SearchResult> = PublishSubject()

    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<String> = PublishSubject()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //requestData(id: "tt1285016")
        
        requestSearch(query: "Planet")
        
    }


    public func requestData(id: String){
        self.loading.onNext(true)
        Webservice().getMovie(url: URL(string: "https://www.omdbapi.com/?apikey=f3f4d15a&i=\(id)")!) { movieResult in
            self.loading.onNext(false)
            switch movieResult {
            case .success(let movie):
                print(movie)
                self.movieInfo.onNext(movie)
            case .failure(let failure):
                switch failure {
                case .parsingEror:
                    self.error.onNext("Cannot parse your data")
                case .serverError:
                    self.error.onNext("Cannot get your data at all")
                }
            }
        }
    }
    
    public func requestSearch(query: String){
        self.loading.onNext(true)
        Webservice().searchMovies(url: URL(string: "https://www.omdbapi.com/?apikey=f3f4d15a&s=\(query)")!) { searchResult in
            self.loading.onNext(false)
            switch searchResult {
            case .success(let searchResult):
                print(searchResult)
                self.searchResults.onNext(searchResult)
            case .failure(let failure):
                switch failure {
                case .parsingEror:
                    self.error.onNext("Cannot parse your data")
                case .serverError:
                    self.error.onNext("Cannot get your data at all")
                }
            }
        }
    }
}

