//
//  PlaceholderView.swift
//  VehicleCompanion
//

import SwiftUI

struct PlaceholderView: View {
    let systemIcon: String
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    
    var body: some View {
        Image(systemName: systemIcon)
            .font(.largeTitle)
        Text(title)
            .font(.title)
        Text(subtitle)
    }
}

#Preview {
    PlaceholderView(
        systemIcon: "mappin.circle",
        title: "No suggestions found",
        subtitle: "Pull to try again"
    )
}
