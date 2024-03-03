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
        addObservers()
        viewModel.loadData()
        configureUI()


        
    }
    
    func addObservers() {
        viewModel.updatedHeroes = { [weak self] in
            self?.tableView.reloadData()
        }
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
        guard let heroe = viewModel.idForHero(indexPath: indexPath) else {
            return
        }
        let vm = DetailViewModel(hero: heroe)
        let detailViewController = DetailViewController(viewModel: vm)
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
    


