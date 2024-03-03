//
//  HeroTableViewCell.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 2/3/24.
//

import UIKit

class HeroTableViewCell: UITableViewCell {
    // MARK: - Identificador
    static let identifier = "HeroTableViewCell"
    //MARK: - OUTLETS

    @IBOutlet weak var imagenHero: UIImageView!
    @IBOutlet weak var nameHero: UILabel!
    
    // MARK: - Configure
    func configure(heroe: NSMHero) {
        nameHero.text = heroe.name
        guard let imageURL = URL(string: heroe.photo ?? "") else {
            return
        }
        
        imagenHero.setImage(url: imageURL)
    }
}
