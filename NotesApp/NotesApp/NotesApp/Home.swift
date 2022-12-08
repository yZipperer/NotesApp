//
//  ContentView.swift
//  NotesApp
//
//  Created by Yukon Z on 12/4/22.
//

import SwiftUI

struct Home: View {
    
    @State var notes = [Note]()
    @State var showCreate = false
    
    var body: some View {
        
        NavigationView {
            List(self.notes){ note in
                Text(note.content)
                    .padding()
            }
            .sheet(isPresented: $showCreate, onDismiss: getNotes, content: {
                NewNoteView()
            })
            .onAppear(perform: {
                getNotes()
            })
            
            .navigationTitle("Notes")
            .navigationBarItems(trailing: Button(action : {
                self.showCreate.toggle()
            }, label : {
                Text("Add Note")
            }))
        }
        
    }
    
    func getNotes() {
        let url = URL(string: "http://localhost:8080/notes")!
        
        let task = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let data = data else {return}
            
            do{
                self.notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
                print(error)
            }
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
