//
//  PlaceSelectionView.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/15/23.
//

import SwiftUI

struct PlaceSelectionView: View {

    var placeProtocol: PlaceProtocol?
    var lastUnit: Unit?
    var onFinished: (() -> Void)?
    
    @State var locations: [LocationResponse] = [LocationResponse]()
    @State var searchTerm: String = ""
    @State var unit: Unit = .imperial
    
    var body: some View {
        VStack {
            UnitPickerView(unit: $unit)
            SearchBoxView(searchTerm: $searchTerm, placeProtocol: placeProtocol, onFinished: onFinished)
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
