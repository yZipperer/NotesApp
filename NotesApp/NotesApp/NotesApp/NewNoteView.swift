//
//  NewNoteView.swift
//  NotesApp
//
//  Created by Yukon Z on 12/7/22.
//

import SwiftUI

struct NewNoteView: View {
    
    @State var content = ""
    
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
        
    }
}

struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteView()
    }
}
