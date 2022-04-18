//  Tab View
//  Here all views are collected and split into tabs
//  ContentView.swift
//  ReadTogether
//
//  Created by Александр on 17.12.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection: Tab = .profile
    
    enum Tab {
        case profile
        case map
        case library
        case test
    }
    
    var body: some View {
        
        TabView(selection: $selection) {
            
            Library()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(Tab.library)
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .tag(Tab.map)
            
            Profile()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(Tab.profile)
            TestLibrary()
                .tabItem {
                    Label("Books", systemImage: "book.closed.fill")
                }
                .tag(Tab.test)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
