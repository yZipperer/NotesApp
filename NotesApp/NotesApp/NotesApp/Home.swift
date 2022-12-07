//
//  ContentView.swift
//  NotesApp
//
//  Created by Yukon Z on 12/4/22.
//

import SwiftUI

struct Home: View {
    var body: some View {
        
        NavigationView {
            List(0..<2){ i in
                Text("Hello World \(i)")
                    .padding()
            }
            .onAppear(perform: {
                getNotes()
            })
            
            .navigationTitle("Notes")
            .navigationBarItems(trailing: Button(action : {
                print("Added Note")
            }, label : {
                Text("Add Note")
            }))
        }
        
    }
    
    func getNotes() {
        let url = URL(string: "http://localhost8080/")!
        
        let task = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let data = data else {return}
        }
        
        task.resume()
    }
}

struct Note: Identifiable, Codable {
    var id: String {_id}
    var _id: String
    var content: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
