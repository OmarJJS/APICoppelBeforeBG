//
//  PerfilViewController.swift
//  APICoppel
//
//  Created by MacBookMBP1 on 24/11/22.
//

import UIKit

class PerfilViewController: UIViewController, UICollectionViewDelegate {
   
    // MARK: Objects Of View
    
    
    @IBOutlet weak var FieldNombre: UITextField!
    
    @IBOutlet weak var Nombre: UILabel!
    
    @IBOutlet weak var FieldUsuario: UITextField!
    
    @IBOutlet weak var Usuario: UILabel!
    
    @IBOutlet weak var CollectionViewPerfil: UICollectionView!
    
    //        MARK: Token
    
        var requestToken : String?
    
//        MARK: Session View Model
    
    private var sessionIdViewModel = SessionIdViewModel()
    private var sessionId : SessionId?
    
    //        MARK: Token Profile
    
    private var perfil : Perfil?
    private var idSession : String?
    
    //        MARK: Profile View Model
    
    private var perfilViewModel = PerfilViewModel()
    
    //        MARK: Movie Model
    
    private var movieViewModel = MovieViewModel()
    private var movies: Movies?
    private var movie : Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SessionLoadData()
    }
    
    func SessionLoadData(){
        
        var idUser : Session?
        guard let token = UserDefaults.standard.object(forKey: "requestToken") as? String else { return }
        
        idUser = Session(request_token: token)
        let sessionIdViewModel = SessionIdViewModel()
        sessionIdViewModel.PostSessionId(requestToken: idUser!){
            sessionId, error in DispatchQueue.main.async {
                
                self.idSession = sessionId?.session_id
                self.ProfileLoadData()
                
            }
        }
        
        
    }
    
    func ProfileLoadData(){
        perfilViewModel.GetDetail(idSession: idSession!) {
            perfil, error in
            self.perfil = perfil
            DispatchQueue.main.async {
//                self.FieldNombre.text = self.perfil?.name
//                self.FieldUsuario.text = self.perfil?.username
                self.Nombre.text = self.perfil?.name
                self.Usuario.text = self.perfil?.username
                self.MovieLoadData()
            }
            
            
        }
    }
    
    func MovieLoadData(){
        movieViewModel.GetFavoriteMovies(idSession: idSession!) {
            movies, error in
            self.movies = movies
            DispatchQueue.main.async {
                self.CollectionViewPerfil?.reloadData()
            }
        }
        
        CollectionViewPerfil.delegate = self
        CollectionViewPerfil.dataSource = self

        CollectionViewPerfil.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    
}

extension PerfilViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        let movie: Movie = movies!.results![indexPath.row]
        if let url = URL(string: ("https://image.tmdb.org/t/p/w1280" + (movies?.results?[indexPath.row].posterPath)!)) {
            DispatchQueue.global().async {
                if let data = try? Data( contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.Imagen.image = UIImage(data: data)
                    }
                }
            }
        }
        cell.Titulo.text = movie.title
        cell.Fecha.text = movie.releaseDate
        cell.Lenguaje.text = movie.originalLanguage
        cell.Descripcion.text = movie.overview
        return cell
    }
}
