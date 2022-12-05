//
//  ContentView.swift
//  NotesApp
//
//  Created by Yukon Z on 12/4/22.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
