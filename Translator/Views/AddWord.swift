//
//  AddWord.swift
//  Translator
//
//  Created by Ludmila Rezunic on 30.03.2021.
//

import SwiftUI

struct AddWord : View {
    @ObservedObject var model : TranslatorViewModel
    @Environment(\.managedObjectContext) var context
    
    init(model:TranslatorViewModel){
        UITextView.appearance().backgroundColor = .clear
        self.model = model
    }
    
    
    var body: some View{
        VStack(spacing: 30){
            Spacer()
            
            Text("Добавить новое слово")
                .font(.title)
                .padding()
            
            TextField("Введите слово на русском", text: $model.russian)
                .padding()
                .frame(width: 340, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(20)
            
            TextField("Введите его перевод на английский", text: $model.english)
                .padding()
                .frame(width: 340, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(20)
            
            Spacer()
            Button(action: {model.writeData(context: context)}, label: {
                Text("Добавить слово")
            })
            .disabled(model.russian.trimmingCharacters(in: .whitespacesAndNewlines) == "" || model.english.trimmingCharacters(in: .whitespacesAndNewlines)  == ""  ? true : false)
            
            Spacer(minLength: 50)
        }
    }
}
