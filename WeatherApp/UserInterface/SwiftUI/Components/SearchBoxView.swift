//
//  SearchBoxView.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/21/23.
//

import SwiftUI

struct SearchBoxView: View {
    
    @Binding var searchTerm: String
    
    var placeProtocol: LocationSearchProtocol?
    var onFinished: (() -> Void)?
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchTerm)
                .textFieldStyle(.roundedBorder)
                .padding(EdgeInsets(top: 10.0, leading: 16.0, bottom: 8.0, trailing: 16.0))
            
            Button {
                placeProtocol?.getCurrentLocation()
                onFinished?()
            } label: {
                Label("", systemImage: "location")
            }
            .padding(EdgeInsets(top: 10.0, leading: 0.0, bottom: 8.0, trailing: 16.0))
        }
    }
}
