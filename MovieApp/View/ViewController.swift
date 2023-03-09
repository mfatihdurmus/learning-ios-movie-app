//
//  ViewController.swift
//  MovieApp
//
//  Created by T65713 on 9.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate {
    let disposeBag = DisposeBag()
    let searchVM = SearchViewModel()
    
    @IBOutlet weak var searchResultsTable: UITableView!
    
    @IBAction func searchFieldChanged(_ sender: UITextField) {
        if let input = sender.text{
            searchVM.requestSearch(query: input)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //requestData(id: "tt1285016")
        //requestSearch(query: "Planet")
        
        searchResultsTable.rx.setDelegate(self).disposed(by: disposeBag)
        setupBindings()
    }
    
    func setupBindings(){
        searchVM.searchResults.bind(to: searchResultsTable.rx.items(cellIdentifier: "movieTableViewCellID", cellType: MovieTableViewCell.self)) { (row,item,cell) in
                cell.item = item
        }.disposed(by: disposeBag)
            
        searchResultsTable.rx.modelSelected(MovieInfo.self).subscribe(onNext: { item in
        print("SelectedItem: \(item)")
            }).disposed(by: disposeBag)
        }
}

