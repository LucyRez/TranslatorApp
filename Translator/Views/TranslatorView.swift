//
//  TranslatorView.swift
//  Translator
//
//  Created by Ludmila Rezunic on 30.03.2021.
//

import SwiftUI

struct TranslatorView: View {
    @State var word = ""
    @State var fromEnglish = true
    @ObservedObject var model = TranslatorViewModel()
   
    
    var body: some View {
        VStack(spacing:30){
            
            
            Text(fromEnglish ? "English - Russian Translator" : "Russian - English Translator" )
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
                .padding()
            
            TextField(fromEnglish ? "Напишите слово на Английском..." : "Напишите слово на Русском...", text: $word)
                .padding(20)
                .background(Color.white)
                .cornerRadius(20)
            
            Button(action: {fromEnglish.toggle()}, label: {
                Image(systemName: "arrow.left.arrow.right")
            })
            
            Spacer()
            
            TranslatedView(fromEnglish : fromEnglish, filter: word.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(), model: model)
                .padding()
            
            
            Button(action: {
                model.active.toggle()
            }, label: {
                Text("Добавить слово в словарь")
            })
            .sheet(isPresented: $model.active, content: {
                AddWord(model: model)
            })
            
            Spacer()
            
            
        }
        
        .background(Color.black.ignoresSafeArea().opacity(0.05))
        
    }
}

struct TranslatedView: View{
    
    @ObservedObject var model : TranslatorViewModel
    var fromEnglish : Bool
    
    var fetchRequest : FetchRequest<Word>
    
    var words : FetchedResults<Word>{
        fetchRequest.wrappedValue
    }
    
    init(fromEnglish : Bool, filter: String, model: TranslatorViewModel){
        if fromEnglish {
            fetchRequest = FetchRequest(entity: Word.entity(), sortDescriptors: [], predicate: NSPredicate(format: "english == %@", filter))
        }else{
            fetchRequest = FetchRequest(entity: Word.entity(), sortDescriptors: [], predicate: NSPredicate(format: "russian == %@", filter))
        }
        
        self.fromEnglish = fromEnglish
        self.model = model
        print("Got:" + (words.first?.english ?? "") + (words.first?.russian ?? ""))
    }
    
    var body: some View{
        VStack{
            Text("Перевод: ")
                .font(.title)
                .padding()
            
            
            Text(fromEnglish ? words.first?.russian ?? "" :  words.first?.english ?? "")
                .font(.system(size: 28))
        
        }
    }
}


