//
//  ViewEditar.swift
//  SwiftUIExamen
//
//  Created by CCDM30 on 29/11/22.
//

import Foundation
import CoreData
import SwiftUI

struct ViewEditar: View{
    let coreDM: CoreDataManager
    
    @Binding var clvO: String
    @Binding var clvV: String
    @Binding var materialV: String
    @Binding var longitudV: String
    @Binding var pesoV: String
    
    var body: some View{
        VStack{
            TextField("Clave de viga", text: $clvV)
                .textFieldStyle(.roundedBorder)
                .textContentType(.telephoneNumber)
            
            TextField("Material", text: $materialV)
                .textFieldStyle(.roundedBorder)
                .textContentType(.telephoneNumber)
            
            TextField("Longitud", text: $longitudV)
                .textFieldStyle(.roundedBorder)
                .textContentType(.telephoneNumber)
            
            TextField("Peso", text: $pesoV)
                .textFieldStyle(.roundedBorder)
                .textContentType(.telephoneNumber)
            
            Button("Guardar"){
                coreDM.actualizarViga(clv_obra: clvO, clv_viga: clvV, material: materialV, longitud: longitudV, peso: pesoV)
            }
        }
    }
}
