//
//  TranslatorViewModel.swift
//  Translator
//
//  Created by Ludmila Rezunic on 30.03.2021.
//

import Foundation
import CoreData

class TranslatorViewModel: ObservableObject{
    
    @Published var active : Bool = false
    @Published var english : String = ""
    @Published var russian : String = ""
    
    
    func writeData(context: NSManagedObjectContext){
      
        
        // If new word is created we are getting all the values from input.
        let newWord = Word(context: context)
        newWord.english = english.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        newWord.russian = russian.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        print("Saving" + newWord.russian! + newWord.english!)
        try! context.save() // Trying to save current context.
        
        // Go back to default parameters.
        english = ""
        russian = ""
        
        return
    }
    
    
}
