//
//  UpdateNoteView.swift
//  NotesApp
//
//  Created by Yukon Z on 12/7/22.
//

import SwiftUI

struct UpdateNoteView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var content: String
    @Binding var noteId: String
    
    
    var body: some View {
        HStack {
            TextField("Edit Note", text: $content)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .clipped()
            
            Button(action: updateNote) {
                Text("Update")
            }
            .padding(8)
        }
    }
    
    func updateNote() {
        let params = ["content" : content] as [String: Any]
        
        let url = URL(string: "http://localhost:8080/notes/\(noteId)")!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PATCH"
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch {
            print(error)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) {data, res, err in
            guard err == nil else {return}
            
            guard let data = data else {return}
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]{
                    print(json)
                }
            } catch let error{
                print(error)
            }
        }
        
        task.resume()
        
        self.content = ""
        
        presentationMode.wrappedValue.dismiss()
    }
}
