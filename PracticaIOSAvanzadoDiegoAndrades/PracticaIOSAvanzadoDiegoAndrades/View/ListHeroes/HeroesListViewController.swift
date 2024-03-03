//
//  HeroesListViewController.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 26/2/24.
//

import UIKit

class HeroesListViewController: UIViewController {
    
    //MARK: - IBOutlets

  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonLogout: UIButton!
    
    private var viewModel: HeroViewModel

    
    
    init(viewModel: HeroViewModel = HeroViewModel()){
        self.viewModel = viewModel
        super.init(nibName: String(describing: HeroesListViewController.self), bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
        configureUI()


        
    }
    
    // Función para eliminar el token
    @IBAction func ButtonLogout(_ sender: Any) {
        let borradoDatos = viewModel.deleteData()
        if borradoDatos{
            let loginVC = LoginViewController()
            navigationController?.setViewControllers([loginVC], animated: true)
        }
    }
    
    //MARK: - Internal Methods
    func configureUI() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeCell")
        
        // MARK: CELDA CUSTOM
         //registro la clase de la celda personalizada
        tableView.register(
            UINib(nibName: HeroTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: HeroTableViewCell.identifier)
        
    }
}


//MARK: - Extension Delegate para temas de navegación
extension HeroesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = viewModel.nameForHero(indexPath: indexPath)
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
}

//MARK: - Extesion DataSource
extension HeroesListViewController: UITableViewDataSource {
    //Numero de columnas por seccion
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numOfHero()
    }
    //Formato de la celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroTableViewCell.identifier,
                                                 for: indexPath) as! HeroTableViewCell

        // Le paso a la celda el index del personaje
        cell.configure(heroe: viewModel.HeroAt(indexPath: indexPath)!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Devuelve la altura deseada para la celda en indexPath
       100
    }
}
    
//extension HeroesListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.viewModel.numOfHero()
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroesViewCell.reuseIdentifier, for: indexPath)
//        
//        let nameHero = self.viewModel.nameForHero(indexPath: indexPath)
//        (cell as? HeroeViewCell)?.configureWith(name: nameHero)
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.bounds.size.width, height: 60)
//    }
//}
//    
////    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let bootcamp = viewModel.HeroAt(indexPath: indexPath) else { return }
//        
//        let viewModel = DevelopersListViewModel(bootcamp: bootcamp)
//        let developersVC = DevelopersListController(viewModel: viewModel)
//        navigationController?.pushViewController(developersVC, animated: true)
//    }
    
    

