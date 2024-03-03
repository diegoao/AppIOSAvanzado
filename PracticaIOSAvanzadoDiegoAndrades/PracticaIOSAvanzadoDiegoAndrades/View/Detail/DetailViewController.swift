//
//  DetailViewController.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 3/3/24.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var mapHero: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel = DetailViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: DetailViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }




}
