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
    private let locationManager = CLLocationManager()
    
    
    
    init(viewModel: DetailViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        viewModel.loadDataFromService()
        configureUI()
        
    }
    
    func configureUI() {
        lbName.text = viewModel.nameForHero()
        descriptionText.text = viewModel.descriptionHero()
        viewImage()
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: String(describing: DetailCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: DetailCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        mapHero.delegate = self
        mapHero.showsUserTrackingButton = true
        mapHero.mapType = .hybrid
        checklocationAuthorizationStatus()
        
        
        
        
    }
    
    func addObservers() {
        viewModel.dataUpdated = { [weak self] in
            self?.collectionView.reloadData()
            self?.updateDataInterface()
            
        }
    }
    //Funcion para cargan imanegn del detalle
    func viewImage(){
        let url = viewModel.photoHero()
        guard let imageURL = URL(string: url ?? "") else {
            return
        }
        heroImage.setImage(url: imageURL)
    }
    
    
    
    
    private func updateDataInterface(){
        addAnnotations()
        if let annotation = mapHero.annotations.first {
            let region = MKCoordinateRegion(center: annotation.coordinate,
                                            latitudinalMeters: 1800,
                                            longitudinalMeters: 1800)
            mapHero.region = region
        }
    }
    
    private func addAnnotations(){
        var annotations = [HeroAnnotation]()
        let (name, id) = viewModel.heroNameAndId()
        for location in viewModel.locationsHero() {
            annotations.append(
                HeroAnnotation.init(coordinate: .init(latitude: Double(location.latitude ?? "") ?? 0.0,
                                                      longitude: Double(location.longitude ?? "") ?? 0.0),
                                    title: name,
                                    id: id,
                                    date: location.date)
            )
        }
        //Añade las annotations al mapa
        mapHero.addAnnotations(annotations)
    }
    
    func checklocationAuthorizationStatus() {
        
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            mapHero.showsUserLocation = false
        case .authorizedAlways, .authorizedWhenInUse:
            mapHero.showsUserLocation = true
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
}


extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let transformation = viewModel.idTransfor(indexPath: indexPath) else {
            return
        }
        let vm = TransforViewModel(transfor: transformation)
        let transforViewController = TransforViewController(viewModel: vm)
        navigationController?.pushViewController(transforViewController, animated: true)
        
    }
    
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



//extension DetailViewController: MKMapViewDelegate {
//    
//    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
//        guard let heroAnnotation = annotation as? HeroAnnotation else {
//            return
//        }
//    }
//    
//    
//    
//}



