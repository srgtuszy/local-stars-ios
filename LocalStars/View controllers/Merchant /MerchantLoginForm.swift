//
//  MerchantLoginForm.swift
//  LocalStars
//
//  Created by Piotr Tuszynski on 21/11/2020.
//

import Foundation
import Eureka
import UIKit

class MerchantLoginForm: FormViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Logowanie"

        form +++ Section("Logowanie przedsiębiorcy")
            <<< EmailRow() { row in
                row.title = "Adres e-mail"
                row.placeholder = "sklep_jacek@wp.pl"
            }
            <<< PasswordRow() { row in
                row.title = "Hasło"
            }
            <<< ButtonRow() { row in
                row.title = "Zaloguj"
            }
        form.allSections[0].footer = {
            var header = HeaderFooterView<UIView>(.callback({
                        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                        view.backgroundColor = .clear
                        let button = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 50.0))
                        button.setTitle("Nie masz konta? Zarejestruj się!", for: .normal)
                        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
                        button.setTitleColor(.gray, for: .normal)
                        button.titleLabel?.textAlignment = .center
                        button.addTarget(self, action: #selector(self.showRegisterFlow), for: .touchUpInside)
                        view.addSubview(button)
                          return view
                      }))
                      header.height = { 100 }
                      return header
        }()
    }
    
    @objc func showRegisterFlow() {
        let registerForm = NewMerchantForm()
        self.navigationController?.pushViewController(registerForm, animated: true)
    }
}
