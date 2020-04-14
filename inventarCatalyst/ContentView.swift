//
//  ContentView.swift
//  inventarCatalyst
//
//  Created by Stefan Schwinghammer on 14.04.20.
//  Copyright © 2020 Stefan Schwinghammer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let place = [
        "Tiefkühler 🥶", "Kühlschrank 🏠"
    ]
    
    
    var body: some View {
        NavigationView {
            List(place, id: \.self) { place in
            NavigationLink(destination: DetailsView(message: place)) {
                Text(place)
            }
                .navigationBarTitle("Inventar 🕵🏻‍♂️")
        }
    }
}
    
    
struct DetailsView: View {
    
    let message: String

    struct Item: Identifiable {
        let id = UUID()
        let title: String
    }
    
    
    @State public var items: [Item] = []
    private static var count = 0
    
    @State private var editMode = EditMode.inactive
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    Text(item.title)
                }
                .onDelete(perform: onDelete)
                .onMove(perform: onMove)
            }
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .environment(\.editMode, $editMode)
        }
    }
    
    // 2.
    private func onDelete(offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    // 3.
    private func onMove(source: IndexSet, destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
    private func onAdd() {
        items.append(Item(title: "Item #\(Self.count)"))
        Self.count += 1
    }
    
    
    
    private var addButton: some View {
        switch editMode {
        case .inactive:
            return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
        default:
            return AnyView(EmptyView())
        }
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

