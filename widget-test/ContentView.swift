//
//  ContentView.swift
//  widget-test
//
//  Created by Iris Roemermann on 13/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var nameInput: String = ""

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            TextField("Enter name value", text: $nameInput)

            Button(action: {
                            updateName()
                        }) {
                            Text("Update Data")
                        }
        }
        .padding()
    }
    
    func updateName() {
            if !nameInput.isEmpty {
                // Update the name
                onNameChanged(newName: nameInput)
            } else {
                print("Name input is empty")
            }
        }
}

#Preview {
    ContentView()
}
