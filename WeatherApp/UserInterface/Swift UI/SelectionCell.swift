//
//  SelectionCell.swift
//  WeatherApp
//
//  Created by Daniel Person on 6/15/23.
//

import SwiftUI

struct SelectionCell: View {
    
    var location: LocationResponse
    var select: (() -> Void)?
    
    var body: some View {
        let state = location.state != nil ? ", " + location.state! : ""
        let name = location.name + state
        
        Button {
            select?()
        } label: {
            Text(name)
                .multilineTextAlignment(.leading)
        }
    }
}
