//
//  ViewController.swift
//  NotasApp
//
//  Created by Mac15 on 04/10/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = TBL_Notas.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        celda.textLabel?.text = notas[indexPath.row]
        celda.detailTextLabel?.text = horarios[indexPath.row]
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notas.count
    }
    
    
    var notas:[String] = []
    var horarios:[String] = []
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var TBL_Notas: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //TBL_Notas.delegate = self
        //TBL_Notas.dataSource = self
        
        if defaults.array(forKey: "SavedNotes") == nil
        {
           print("Por el momento no hay notas")
        } else {
            notas = defaults.array(forKey: "SavedNotes") as! [String]
        }
        
        if defaults.array(forKey: "SavedHours") == nil
        {
            print("Por el momento no hay fechas")
        } else {
            horarios = defaults.array(forKey: "SavedHours") as! [String]
        }
        

        
    }

    @IBAction func BTN_AddNota(_ sender: UIBarButtonItem) {
        
        let date = Date()
        
        let dateF = DateFormatter()
        
        dateF.locale = Locale(identifier: "es_MX")
        dateF.dateStyle = .short
        dateF.timeStyle = .short
        
        print("Última modificación: \(dateF.string(from: date))")
        let alerta = UIAlertController(title: "Nueva Nota", message: "Agregar", preferredStyle: .alert)
        
        //Agregar campo para el texto de la nota
        alerta.addTextField { (textoNota) in
            textoNota.placeholder = "Escribe tu nota"
        }
        
        //Agregar campo para la hora de la nota
        alerta.addTextField { (horaNota) in
            horaNota.text = "Última modificación: \(dateF.string(from: date))"
            horaNota.isEnabled = false
            
        }
        let actionGuardar = UIAlertAction(title: "Guardar", style: .default) {_ in
            
            print("Nota Agregada")
            
            guard let texto_Nota = alerta.textFields?.first?.text else { return }
            
            
            guard let hora_Nota = alerta.textFields?[1].text else { return }
            
            self.notas.append(texto_Nota)
            self.horarios.append(hora_Nota)
            
            self.TBL_Notas.reloadData()
            
            self.defaults.set(self.horarios, forKey: "SavedHours")
            self.defaults.set(self.notas, forKey: "SavedNotes")
            
        }
        
        let actionCancelar = UIAlertAction(title: "Cancelar", style: .destructive, handler:  nil)
        
        
        alerta.addAction(actionGuardar)
        alerta.addAction(actionCancelar)
        
        present(alerta, animated: true, completion: nil)
    }
    
    
    
    
}

