//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by T65713 on 9.03.2023.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    public let searchResults : PublishSubject<[MovieInfo]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<String> = PublishSubject()
    
    public func requestSearch(query: String){
        self.loading.onNext(true)
        Webservice().searchMovies(url: URL(string: "https://www.omdbapi.com/?apikey=f3f4d15a&s=\(query)")!) { searchResult in
            self.loading.onNext(false)
            switch searchResult {
            case .success(let searchResult):
                //print(searchResult)
                self.searchResults.onNext(searchResult.search)
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
