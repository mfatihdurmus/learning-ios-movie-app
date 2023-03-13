//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by T65713 on 13.03.2023.
//

import UIKit
import RxSwift

class DetailsViewController: UIViewController {
    
    public var imdbID : String = ""
    
    let disposeBag = DisposeBag()
    let detailVM = DetailViewModel()
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var imdbRatingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        
        detailVM.requestData(id: imdbID)
    }
    
    func setupBindings(){
        self.detailVM.movieInfo
          .asObservable()
          .map { info -> String? in
                  return Optional(info.title)}
          .bind(to:self.titleLabel.rx.text)
          .disposed(by:self.disposeBag)
        
        self.detailVM.movieInfo
          .asObservable()
          .map { info -> String? in
                  return Optional(info.year)}
          .bind(to:self.yearLabel.rx.text)
          .disposed(by:self.disposeBag)
    
        self.detailVM.movieInfo
          .asObservable()
          .map { info -> String? in
                  return Optional(info.actors)}
          .bind(to:self.castLabel.rx.text)
          .disposed(by:self.disposeBag)
    
        self.detailVM.movieInfo
          .asObservable()
          .map { info -> String? in
                  return Optional(info.country)}
          .bind(to:self.countryLabel.rx.text)
          .disposed(by:self.disposeBag)
    
        self.detailVM.movieInfo
          .asObservable()
          .map { info -> String? in
                  return Optional(info.director)}
          .bind(to:self.directorLabel.rx.text)
          .disposed(by:self.disposeBag)
    
        self.detailVM.movieInfo
          .asObservable()
          .map { info -> String? in
                  return Optional(info.imdbRating)}
          .bind(to:self.imdbRatingLabel.rx.text)
          .disposed(by:self.disposeBag)
    
        self.detailVM.posterImage
          .asObservable()
          .map { image -> UIImage? in
                  return Optional(image)}
          .bind(to:self.posterImage.rx.image)
          .disposed(by:self.disposeBag)
    }
}
