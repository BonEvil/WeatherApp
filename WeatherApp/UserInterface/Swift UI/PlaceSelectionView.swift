//
//  PlaceSelectionView.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/15/23.
//

import SwiftUI

struct PlaceSelectionView: View {
    
    let units = [Unit.imperial, Unit.metric]

    var placeProtocol: PlaceProtocol?
    var lastUnit: Unit?
    var onFinished: (() -> Void)?
    
    @State var locations: [LocationResponse] = [LocationResponse]()
    @State var searchTerm: String = ""
    @State var unit: Unit = .imperial
    
    var body: some View {
        VStack {
            HStack {
                Text("Unit:")
                Picker("Unit", selection: $unit) {
                    ForEach(units, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(EdgeInsets(top: 20.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
            
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
            .onChange(of: searchTerm) { newValue in
                if newValue.count > 2 {
                    doSearch(forPlace: newValue)
                }
            }
            .onAppear {
                if let lastUnit = lastUnit {
                    unit = lastUnit
                }
            }
        }
        
        List(locations) { location in
            SelectionCell(location: location, select: {
                let state = location.state != nil ? ", " + location.state! : ""
                let name = location.name + state
                placeProtocol?.onSelect(Location(name: name, lat: location.lat, lon: location.lon), unit)
                onFinished?()
            })
        }
        
        Spacer()
    }
    
    private func doSearch(forPlace place: String) {
        Task {
            do {
                let searchLocations = try await placeProtocol?.searchForPlace(place)
                if let searchLocations = searchLocations {
                    self.locations = searchLocations
                }
            } catch {
                print("\(error)")
            }
        }
    }
}

struct PlaceSelection_Previews: PreviewProvider {
    static var previews: some View {
        PlaceSelectionView()
    }
}
