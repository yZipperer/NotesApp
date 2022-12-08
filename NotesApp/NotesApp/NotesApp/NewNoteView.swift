//
//  NewNoteView.swift
//  NotesApp
//
//  Created by Yukon Z on 12/7/22.
//

import SwiftUI

struct NewNoteView: View {
    
    @State var content = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            TextField("Create a Note", text: $content)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .clipped()
            
            Button(action: createNote) {
                Text("Add")
            }
            .padding(8)
        }
    }
    
    func createNote() {
        let params = ["content" : content] as [String: Any]
        
        let url = URL(string: "http://localhost:8080/notes")!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
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

struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteView()
    }
}
