//
//  ContentView.swift
//  Shared
//
//  Created by Zülküf Seçkin on 9.09.2021.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                                .ignoresSafeArea()
                                .accentColor(.black)
                                .onAppear {
                    viewModel.checkLocationServicesEnabled()
                }) {
                    Text("MapKit")
                        .font(.title)
                }
                
                NavigationLink(destination: WebView(url: URL(string: "https://www.google.com"))) {
                    Text("WebKit")
                        .font(.title)
                }
                Spacer()
                
                NavigationLink(destination: EmptyView()) {
                    Text("Z.Seckin")
                }
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


