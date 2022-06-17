//
//  FormViewController.swift
//  CEP_Van
//
//  Created by VanKawa on 16/06/22.
//

import UIKit

class FormViewController: UIViewController {
    
    // MARK: PROPERTIES
    var address: Address?
    var fullAddress: String?
    
    init(address: Address) {
        super.init(nibName: nil, bundle: nil)
        self.address = address
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }

    //OUTLETS
    
    @IBOutlet weak var buttonTagGenerate: UIButton!
    
    @IBOutlet weak var textFieldRecipient: UITextField!
    
    @IBOutlet weak var textFieldAddress: UITextField!
    
    @IBOutlet weak var textFieldNeighborhood: UITextField!
    
    @IBOutlet weak var textFieldNumber: UITextField!
    
    @IBOutlet weak var textFieldAdditional: UITextField!

    @IBOutlet weak var textFieldCity: UITextField!
    
    @IBOutlet weak var textFieldState: UITextField!
    
    @IBOutlet weak var textFieldZipCode: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.title = "TAG"
        filledTextFields()
    }

    
    //OVERRIDES
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Endereço"
        navigationController?.navigationBar.tintColor = UIColor(named: "UseColor")
        let titleColor = UIColor(named: "UseColor") ?? UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: titleColor
        ]

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.title = ""
        
    }
    //ACTIONS
    
    @IBAction func buttonTagGenerator(_ sender: Any) {
        address?.destinatario = textFieldRecipient.text
        address?.numero = textFieldNumber.text
        address?.complemento = textFieldAdditional.text
        createFullAddressTag()
        goToTag()
    }
    
    
    
    //METHODS
    
    private func setupUI() {
    buttonTagGenerate.layer.cornerRadius = 7
}
    private func filledTextFields() {
        textFieldZipCode.text = address?.cep
        textFieldCity.text = address?.localidade
        textFieldState.text = address?.uf
        textFieldAdditional.text = address?.complemento
        textFieldAddress.text = address?.logradouro
        textFieldNeighborhood.text = address?.bairro
    }
    
    private func createFullAddressTag() {
        
        let fullAddress = """
        Destinatário: \(address?.destinatario ?? "").Endereço: \(address?.logradouro ?? ""), \(address?.numero ?? ""), \(address?.localidade ?? ""), \(address?.uf ?? " "), \(address?.bairro ?? "")
        """
    self.fullAddress = fullAddress

    }

    
    private func goToTag() {
        guard let fullAddress = fullAddress else { return }
        let tagViewController = TagViewController(fullAddress: fullAddress)
        navigationController?.pushViewController(tagViewController, animated: true)
    }
}
