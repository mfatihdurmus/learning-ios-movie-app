//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by T65713 on 9.03.2023.
//

import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    public var item: MovieInfo! {
           didSet {
               self.titleLabel.text = item.title
               self.yearLabel.text = item.year
               let url = URL(string: item.poster)
               
               DispatchQueue.global().async {
                   let data = try? Data(contentsOf: url!)
                   
                   if let data = data {
                       let image = UIImage(data: data)
                       DispatchQueue.main.async {
                           self.posterImageView.image = image
                           self.posterImageView.contentMode = .scaleAspectFit
                       }
                   }
               }
           }
       }
}
/*
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}*/
