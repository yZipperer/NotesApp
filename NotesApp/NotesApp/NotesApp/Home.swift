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
    @State var showAlert = false
    @State var itemToDelete: Note?
    
    var alert: Alert {
        Alert(title: Text("Delete"), message: Text("Are you sure you want to delete this note?"), primaryButton: .destructive(Text("Delete")), action: deleteNote, secondaryButton: .cancel())
    }
    
    var body: some View {
        
        NavigationView {
            List(self.notes){ note in
                Text(note.content)
                    .padding()
                    .onLongPressGesture{
                        self.showAlert.toggle()
                        itemToDelete = note
                    }
            }
            .alert(isPresented: $showAlert, content: {
                alert
            })
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
    
    func deleteNote() {
        
        guard let id = itemToDelete?._id else {return}
        
        let url = URL(string: "http://localhost:8080/notes/\(id)")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) {data, res, err in
            guard err == nil else {return}
            
            guard let data = data else {return}
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]{
                    print(json)
                }
            } catch let error {
                print(error)
            }
        }
        
        task.resume()
        
        getNotes()
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
