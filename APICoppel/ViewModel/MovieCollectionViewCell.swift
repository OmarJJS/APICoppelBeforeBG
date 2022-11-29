//
//  MovieCollectionViewCell.swift
//  APICoppel
//
//  Created by MacBookMBP1 on 17/11/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var Imagen: UIImageView!
    
    @IBOutlet weak var Titulo: UITextField!
    
    @IBOutlet weak var Lenguaje: UITextField!
    
    @IBOutlet weak var Descripcion: UITextField!
    
    @IBOutlet weak var Fecha: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
