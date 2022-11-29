//
//  DetallesMovieViewController.swift
//  APICoppel
//
//  Created by MacBookMBP1 on 24/11/22.
//

import UIKit

class DetallesMovieViewController: UIViewController {

    //  MARK: Elementos
    
    @IBOutlet weak var imageMovie: UIImageView!
    
    @IBOutlet weak var textTitulo: UILabel!
    
    @IBOutlet weak var textIdioma: UILabel!
    
    @IBOutlet weak var textFecha: UILabel!
    
    @IBOutlet weak var textDescripcion: UILabel!
    
    //  MARK: Movies
    
    private var detailsMovie = DetailsMovie()
    private var movie : Movie?
    var IdMovie : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsMovie.GetDetailMovie(idMovie: IdMovie!) { movie, error in
            self.movie = movie
            DispatchQueue.main.async {
                self.LoadData()
            }
        }
    }
    
    func LoadData(){
        if let url = URL(string:("https://image.tmdb.org/t/p/w1280" + (movie?.posterPath)!)) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        self.imageMovie.image = UIImage(data: data)
                    }
                }
            }
        }
        
        self.textTitulo.text = movie?.title
        self.textFecha.text = movie?.releaseDate
        self.textIdioma.text = movie?.originalLanguage
        self.textDescripcion.text = movie?.overview
        
    }
    
}
