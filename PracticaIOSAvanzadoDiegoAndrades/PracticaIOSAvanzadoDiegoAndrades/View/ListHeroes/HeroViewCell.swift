//
//  HeroViewCell.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 2/3/24.
//

import UIKit

class HeroViewCell: UICollectionViewCell {

    @IBOutlet weak var nameHero: UILabel!
    @IBOutlet weak var imagenHero: UIImageView!

    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameHero.text = nil
    }
    
    //MARK: - Methods
    func configure(heroe: NSMHero) {
        nameHero.text = heroe.name
        guard let imageURL = URL(string: heroe.photo ?? "") else {
            return
        }
        
        imagenHero.setImage(url: imageURL)
    }

}



