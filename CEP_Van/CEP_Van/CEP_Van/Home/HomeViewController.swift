//
//  HomeViewController.swift
//  CEP_Van
//
//  Created by VanKawa on 16/06/22.
//

import UIKit

struct Address: Decodable {
    let cep: String?
    let logradouro: String?
    var complemento: String?
    let bairro: String?
    let localidade: String?
    let uf: String?
    var destinatario: String?
    var numero: String?
    
    
//    callback_name({
//        "cep": "01001-000",
//        "logradouro": "Praça da Sé",
//        "complemento": "lado ímpar",
//        "bairro": "Sé",
//        "localidade": "São Paulo",
//        "uf": "SP",
//        "ibge": "3550308",
//        "gia": "1004",
//        "ddd": "11",
//        "siafi": "7107"
//      });
}

class HomeViewController: UIViewController {
    var address: Address?
    
    
    
    @IBOutlet weak var imageUseLogo: UIImageView!
    @IBOutlet weak var txtFieldZipCode: UITextField!
    @IBOutlet weak var buttonSearchZip: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.title = " "
    }

    private func getAddress() {
        guard let zipCode = txtFieldZipCode.text else { return }
        guard zipCode.count == 8 else { return }
        guard let url = URL(string: "https://viacep.com.br/ws/\(zipCode)/json/") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print("STATUS CODE: ", response.statusCode)
            }
            guard let data = data else { return }
            guard let address = try? JSONDecoder().decode(Address.self, from: data) else {
                return }
            self.address = address
            
            DispatchQueue.main.async {
                self.goToAddress()
            }
        }.resume()
        
    }
    
    @IBAction func buttonZipSearch(_ sender: Any) {
        getAddress()
    }
    
    
    private func setupUI() {
        buttonSearchZip.layer.cornerRadius = 5
        txtFieldZipCode.placeholder = "Digite o CEP"
        imageUseLogo.image = UIImage(named: "hor-grad")
    }

    private func goToAddress() {
        guard let address = address else { return }
        
        let formViewController = FormViewController(address: address)
        navigationController?.pushViewController(formViewController, animated: true)
    }
}

