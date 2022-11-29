//
//  ViewController.swift
//  APICoppel
//
//  Created by MacBookMBP1 on 10/11/22.
//

import UIKit

class ViewController: UIViewController {
    
//    private var baseURL = "https://demo.microstrategy.com/MicroStrategyLibrary"
    
    private var requestTokenViewModel = RequestTokenViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GenerarToken()
        
    }
    
    
    private var requestToken : RequestToken?

    @IBOutlet weak var FieldUserName: UITextField!
    
    @IBOutlet weak var FieldPassword: UITextField!
    
    @IBOutlet weak var ButtonMostrar: UIButton!
    
    
    @IBAction func ButtonEntrar(_ sender: UIButton) {
//        let login = baseURL + "/api/auth/login"
//        let parameters = ["username": "guest", "password": ""]
        
        var user : User?
        guard let usuario = self.FieldUserName.text else {
            print("Usuario Invalido")
            return}
        guard let contrasenia = self.FieldPassword.text else {
            print("Contraseña Invalida")
            return
        }
        guard let token = self.requestToken?.request_token else {return}
        
        user = User(username: usuario, password: contrasenia, request_token: token)
        
        let userViewModel = UserViewModel()
        userViewModel.Login(user: user!) { result, data in DispatchQueue.main.async {
            if userViewModel.requestToken.success {
                let alert = UIAlertController(title: "Usuario Ingresado", message: "Bienvenido", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.performSegue(withIdentifier: "MOVIE", sender: self)
                
                UserDefaults.standard.set(userViewModel.requestToken.request_token, forKey: "requestToken")
                UserDefaults.standard.synchronize()
            }else{
                let alert = UIAlertController(title: "SUCCESS FALSE", message: "Hubo un error al ingresar", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func GenerarToken(){
        requestTokenViewModel.GetRequestToken{ object, error in guard let _ = object else {
            print("Error")
            return
        }
            self.requestToken = object
        }
    }
    
    @IBAction func ButtonVer(_ sender: Any) {
        ButtonMostrar.isSelected = !ButtonMostrar.isSelected
        FieldPassword.isSecureTextEntry = !ButtonMostrar.isSelected
    }
}

