//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by T65713 on 9.03.2023.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel{
    public let movieInfo : PublishSubject<Movie> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<String> = PublishSubject()
    
    public func requestData(id: String){
        self.loading.onNext(true)
        Webservice().getMovie(url: URL(string: "https://www.omdbapi.com/?apikey=f3f4d15a&i=\(id)")!) { movieResult in
            self.loading.onNext(false)
            switch movieResult {
            case .success(let movie):
                //print(movie)
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
}
