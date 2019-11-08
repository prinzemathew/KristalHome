//
//  ViewController.swift
//  KristalHome
//
//  Created by Prince Mathew on 08/11/19.
//  Copyright © 2019 Prince Mathew. All rights reserved.
//

import UIKit
import KristalLogin

class ViewController: UIViewController {

    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonCountry: UIButton!
    private var accessToken: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func countryTapped(_ sender: Any) {
        guard let _token = accessToken,
            _token.count > 0 else {
                self.buttonLogin.isHidden = false
                self.buttonCountry.isHidden = true
                return
        }
        redirectToListing(with: _token)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let _loginVC = UIViewController()
        _loginVC.title = "Login"
        let _loginView = LoginView()
        _loginView.loginCompletion = {[weak self](token) in
            self?.dismiss(animated: true, completion: {
                self?.accessToken = token
                self?.buttonLogin.isHidden = true
                self?.buttonCountry.isHidden = false
                self?.redirectToListing(with: token)
            })
          }
        _loginView.fixIn(_loginVC.view)
        self.navigationController?.present(_loginVC, animated: true, completion: nil)
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func redirectToListing(with accessToken: String) {
        guard let _listVC = UIStoryboard(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "tableViewController") as? TableViewController else {
            return
        }
        self.navigationController?.pushViewController(_listVC, animated: true)
    }
        
}

