//
//  EditarNotaViewController.swift
//  NotasApp
//
//  Created by Mac15 on 09/10/21.
//

import UIKit

class EditarNotaViewController: UIViewController {
    
    var defaults = UserDefaults.standard
    
    var notaRecibida: String?
    var indexNota: Int?
    var arrayNotas:[String]?
    
    var indexFecha: Int?
    var arrayFechas: [String]?

    @IBOutlet weak var TF_NotaAEditar: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(arrayNotas!)
        print(arrayFechas!)
        
        
        TF_NotaAEditar.text = notaRecibida
    }
    
    @IBAction func BTN_GuardarCambios(_ sender: UIButton) {
        
        let date = Date()
        
        let dateF = DateFormatter()
        
        dateF.locale = Locale(identifier: "es_MX")
        dateF.dateStyle = .short
        dateF.timeStyle = .short
        
        print("Última modificación: \(dateF.string(from: date))")
        
        if let editedNote:String = TF_NotaAEditar.text
        {
            
            arrayNotas![indexNota!] = editedNote
            defaults.set(arrayNotas, forKey: "SavedNotes")
            
            arrayFechas![indexFecha!] = "Última modificación: \(dateF.string(from: date))"
            defaults.setValue(arrayFechas, forKey: "SavedHours")
            
            navigationController?.popToRootViewController(animated: true)
        }

        
    }
    @IBAction func BTN_CancelarEditar(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
