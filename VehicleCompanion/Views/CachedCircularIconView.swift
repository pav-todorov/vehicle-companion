//
//  CachedCircularIconView.swift
//  VehicleCompanion
//

import SwiftUI

struct CachedCircularIconView: View {
    let iconUrl: URL
    
    var body: some View {
        CachedImageView(url: iconUrl)
            .scaledToFill()
            .frame(cgSize: Sizes.smallRowImage)
            .border(Color(.secondarySystemBackground), width: 1)
            .clipShape(
                Circle()
            )
            .overlay {
                Circle()
                    .strokeBorder(.white, lineWidth: 3)
                    .frame(cgSize: Sizes.smallRowImageFrame)
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 3)
    }
}

#Preview {
    CachedCircularIconView(iconUrl: PoiUIModel.mock().iconUrl!)
}
