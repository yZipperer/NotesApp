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
            
            .navigationTitle("Notes")
            .navigationBarItems(trailing: Button(action : {
                print("Added Note")
            }, label : {
                Text("Add Note")
            }))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
