//
//  TransforViewController.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 3/3/24.
//

import UIKit

class TransforViewController: UIViewController {

    @IBOutlet weak var nameTransfor: UILabel!
    
    @IBOutlet weak var imageTransfor: UIImageView!
    
    @IBOutlet weak var lbDescription: UITextView!
    
    
    private var viewModel: TransforViewModel
    
    init(viewModel: TransforViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTransfor.text = viewModel.nameForHero()
        viewImage()
        lbDescription.text = viewModel.descriptionHero()


    }


    
    func viewImage(){
        let url = viewModel.photoHero()
        guard let imageURL = URL(string: url ?? "") else {
            return
        }
        imageTransfor.setImage(url: imageURL)
    }


}
