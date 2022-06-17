//
//  TagViewController.swift
//  CEP_Van
//
//  Created by VanKawa on 17/06/22.
//

import UIKit

class TagViewController: UIViewController {
    
    
    @IBOutlet weak var labelFullAddress: UILabel!
    
    
    let fullAddress: String?
    
    init(fullAddress: String) {
        self.fullAddress = fullAddress
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    @IBOutlet weak var viewTag: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.title = "TAG"

    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = UIColor(named: "UseColor")
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }

    private func setupUI() {
        viewTag.layer.cornerRadius = 7
        labelFullAddress.self.text = fullAddress
    }
    
}
