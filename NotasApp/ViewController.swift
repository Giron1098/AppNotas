//
//  ViewController.swift
//  NotasApp
//
//  Created by Mac15 on 04/10/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var notaAEditar: String?
    var indexNotaAEditar: Int?

    var indexFechaAEditar: Int?
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = TBL_Notas.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        celda.textLabel?.text = notas[indexPath.row]
        celda.detailTextLabel?.text = horarios[indexPath.row]
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notas.count
    }
    
    //MARK: - Eliminar una elemento
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            print("Nota \"\(notas[indexPath.row])\" eliminada")
            self.notas.remove(at: indexPath.row)
            self.horarios.remove(at: indexPath.row)
            
            self.defaults.set(self.notas, forKey: "SavedNotes")
            self.defaults.set(self.horarios, forKey: "SavedHours")
            
            TBL_Notas.reloadData()
        }
    }
    
    //MARK: - Identificar cuando se selecciona un elemento de la tabla
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row), \(notas[indexPath.row])")
        
        TBL_Notas.deselectRow(at: indexPath, animated: true)
        notaAEditar = notas[indexPath.row]
        indexNotaAEditar = indexPath.row
        
        indexFechaAEditar = indexPath.row
        
        performSegue(withIdentifier: "editarNota", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editarNota"
        {
            let objDestino = segue.destination as! EditarNotaViewController
            
            objDestino.notaRecibida = notaAEditar
            objDestino.indexNota = indexNotaAEditar
            objDestino.arrayNotas = self.notas
            
            objDestino.indexFecha = indexFechaAEditar
            objDestino.arrayFechas = self.horarios
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        if defaults.array(forKey: "SavedNotes") == nil
        {
           print("Por el momento no hay notas nuevas")
        } else {
            notas = defaults.array(forKey: "SavedNotes") as! [String]
        }
        
        if defaults.array(forKey: "SavedHours") == nil
        {
            print("Por el momento no hay fechas nuevas")
        } else {
            horarios = defaults.array(forKey: "SavedHours") as! [String]
        }
        self.TBL_Notas.reloadData()
    }

    @IBAction func BTN_AddNota(_ sender: UIBarButtonItem) {
        
        let date = Date()
        
        let dateF = DateFormatter()
        
        dateF.locale = Locale(identifier: "es_MX")
        dateF.dateStyle = .short
        dateF.timeStyle = .short
        
        print("Última modificación: \(dateF.string(from: date))")
        let alerta = UIAlertController(title: "Nueva Nota", message: "Agregar", preferredStyle: .alert)
        
        //MARK: - Agregar campo para el texto de la nota
        alerta.addTextField { (textoNota) in
            textoNota.placeholder = "Escribe tu nota"
        }
        
        //MARK:- Agregar campo para la hora de la nota
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

