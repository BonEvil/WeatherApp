//
//  UnitPickerView.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/21/23.
//

import SwiftUI

struct UnitPickerView: View {
    
    @Binding var unit: Unit
    
    let units = [Unit.imperial, Unit.metric]
    
    var body: some View {
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
    }
}
