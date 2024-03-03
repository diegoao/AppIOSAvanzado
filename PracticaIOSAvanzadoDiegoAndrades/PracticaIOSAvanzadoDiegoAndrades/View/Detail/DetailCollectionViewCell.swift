//
//  DetailCollectionViewCell.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 3/3/24.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageHero: UIImageView!
    @IBOutlet weak var nameHero: UILabel!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        var reuseIdentifier: String {
                return String(describing:self)
            }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameHero.text = nil
    }
    
    //MARK: - Methods
    func configure(transformation: NSMTransformation) {
        nameHero.text = transformation.name
        guard let imageURL = URL(string: transformation.photo ?? "") else {
            return
        }
        
        imageHero.setImage(url: imageURL)
    }
}
