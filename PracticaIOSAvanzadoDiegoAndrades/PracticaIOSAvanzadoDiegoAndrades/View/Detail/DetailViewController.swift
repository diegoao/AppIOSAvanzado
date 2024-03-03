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
    private var id : String = ""

    
    init(id: String, viewModel: DetailViewModel = DetailViewModel()){
        self.id = id
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id)
        viewModel.loadData(id: id)
        configureUI()

    }
    
    func configureUI() {
        


        

        
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: String(describing: DetailCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: DetailCollectionViewCell.reuseIdentifier)
        
        collectionView.backgroundColor = .clear
        


        
        
    }
}




extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numTransform()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.reuseIdentifier, for: indexPath) as? DetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let transform = viewModel.transformAt(indexPath: indexPath) else { debugPrint("No se encuentran transformaciones")
            return UICollectionViewCell()
        }
        
        cell.configure(transformation: transform)
        return cell
    }
    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 100)
    }
    
}
