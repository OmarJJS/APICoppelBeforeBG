//
//  MoviesCollectionViewController.swift
//  APICoppel
//
//  Created by MacBookMBP1 on 14/11/22.
//

import UIKit

private let reuseIdentifier = "MoviesCollectionViewCell"

class MoviesCollectionViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var CollectionViewMovies: UICollectionView!
    
    @IBOutlet weak var ButtonTopRated: UIBarButtonItem!
    
    @IBOutlet weak var ButtonPopular: UIBarButtonItem!
    
    var requestToken : String?
    
    private var movieViewModel = MovieViewModel()
    private var movies : Movies?
    private var movie : [Movie] = []
    private var idMovie : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieViewModel.GetPopularMovie { movies, error in
            self.ButtonPopular.customView?.backgroundColor = UIColor.cyan
            self.movies = movies
            DispatchQueue.main.async {
                self.CollectionViewMovies.reloadData()
            }
        }
        CollectionViewMovies.delegate = self
        CollectionViewMovies.dataSource = self
        CollectionViewMovies!.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
    }
    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 0
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//        return cell
//    }
//    CollectionViewMovies
    
    @IBAction func ButtonTopRatedAction(_ sender: UIButton) {
        movieViewModel.GetTopRatedMovie { movies, error in
            self.movies = movies
            DispatchQueue.main.async {
                self.CollectionViewMovies.reloadData()
            }
        }
        self.ButtonTopRated.customView?.backgroundColor = UIColor.cyan
        self.ButtonPopular.customView?.backgroundColor = UIColor.yellow
    }

    @IBAction func ButtonPopularAction(_ sender: UIButton) {
        movieViewModel.GetPopularMovie { movies, error in
            self.movies = movies
            DispatchQueue.main.async {
                self.CollectionViewMovies.reloadData()
            }
        }
        self.ButtonPopular.customView?.backgroundColor = UIColor.yellow
        self.ButtonTopRated.customView?.backgroundColor = UIColor.cyan
    }
}


extension MoviesCollectionViewController : UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        self.idMovie = movies!.results![indexPath.row].id
        self.performSegue(withIdentifier: "Detallemovie", sender: self)
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionViewMovies.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        let movie : Movie = movies!.results![indexPath.row]
        if let url = URL( string:("https://image.tmdb.org/t/p/w1280" + (movies?.results?[indexPath.row].posterPath)!)){
            DispatchQueue.global().async {
                if let data = try? Data( contentsOf : url){
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "DetalleMovie"{
            var detalleMovieController = segue.destination as? DetallesMovieViewController
            detalleMovieController?.IdMovie = self.idMovie!
        }
    }
}
