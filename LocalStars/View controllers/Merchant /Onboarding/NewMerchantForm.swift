//
//  NewMerchantForm.swift
//  LocalStars
//
//  Created by Piotr Tuszynski on 21/11/2020.
//

import Foundation
import UIKit
import ImageRow
import Eureka

class NewMerchantForm: FormViewController {
    
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
        self.title = "Rejestracja"
        
        form +++ Section("Informacje o przedsiębiorcy")
            <<< TextRow() { row in
                row.title = "Nazwa firmy"
                row.placeholder = "Sklep wielobranżowy"
            }
            <<< TextRow() { row in
                row.title = "Adres"
                row.placeholder = "ul. Szczecińska 36, 73-110 Stargard"
            }
            <<< PhoneRow() { row in
                row.title = "Numer telefonu"
                row.placeholder = "792-288-646"
            }
            <<< EmailRow() { row in
                row.title = "Adres e-mail"
                row.placeholder = "sklep@o2.pl"
            }
            <<< URLRow() { row in
                row.title = "Strona www"
                row.placeholder = "www.sklep-jacek.pl"
            }
            <<< TextRow() { row in
                row.title = "Godziny otwarcia"
                row.placeholder = "9:00-20:00"
            }
        form +++ Section("Kategoria")
            <<< PushRow<String> { row in
                row.title = "Wybierz kategorię swojego biznesu"
                row.options = ["Gastronomia", "Zakupy", "Zdrowie i uroda", "Wyposażenie i remonty", "Edukacja", "Transport", "inne usługi", "Różne"]
            }
        form +++ Section("Logotyp")
            <<< ImageRow(){
                $0.title = "Wybierz logotyp"
                $0.sourceTypes = [.All]
            }
        form +++ Section()
            <<< ButtonRow {
                $0.title = "Zarejestruj się"
            }
            
    }
}
