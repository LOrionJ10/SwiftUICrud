//
//  CoreDataManager.swift
//  SwiftUIExamen
//
//  Created by CCDM30 on 29/11/22.
//

import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer: NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "Viga")
        persistentContainer.loadPersistentStores(completionHandler: {
            (description, error) in
            if let error = error {
                fatalError("Error al iniciar el CoreData \(error.localizedDescription)")
            }
        })
    }
    
    func guardarViga(clv_obra: String, clv_viga: String, material: String, longitud: String, peso: String){
        let viga = Viga(context: persistentContainer.viewContext)
        viga.clv_obra = clv_obra
        viga.clv_viga = clv_viga
        viga.material = material
        viga.longitud = longitud
        viga.peso = peso
        
        do{
            try persistentContainer.viewContext.save()
            print("Viga guardada correctamente")
        }catch{
            print("Error: No se guardo la viga")
        }
    }
    
    func obtenerVigas()->[Viga]{
        let fetchRequest: NSFetchRequest<Viga> = Viga.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }catch{
            return[]
        }
    }
    
    func borrarVigas(viga:Viga){
        persistentContainer.viewContext.delete(viga)
        do{
            try persistentContainer.viewContext.save()
        }catch{
            persistentContainer.viewContext.rollback()
            print("Error: no se guardo la viga \(error.localizedDescription)")
        }
    }
    
    func actualizarViga(viga: Viga){
        let fetchRequest : NSFetchRequest<Viga> = Viga.fetchRequest()
        let predicate = NSPredicate(format: "idObra =%@", viga.clv_obra ?? "")
        fetchRequest.predicate = predicate
        
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let p = datos.first
            p?.clv_viga = viga.clv_viga
            p?.material = viga.material
            p?.longitud = viga.longitud
            p?.peso = viga.peso
            try persistentContainer.viewContext.save()
            print("Viga actualizada")
        }catch{
            print("Error en \(error)")
        }
    }
    
    func actualizarViga(clv_obra:String, clv_viga:String, material:String, longitud:String, peso:String){
        let fetchRequest : NSFetchRequest<Viga> = Viga.fetchRequest()
        let predicate = NSPredicate(format: "clv_obra = %@", clv_obra ?? "")
        fetchRequest.predicate = predicate
        
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let p = datos.first
            p?.clv_viga = clv_viga
            p?.material = material
            p?.longitud = longitud
            p?.peso = peso
            try persistentContainer.viewContext.save()
            print("Viga actualizada")
        }catch{
            print("Error en \(error)")
        }
    }
}
