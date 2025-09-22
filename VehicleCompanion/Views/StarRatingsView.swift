//
//  StarRatingsView.swift
//  VehicleCompanion
//

import SwiftUI

struct StarRatingsView: View {
    let rating: Double
    
    var body: some View {
        ForEach(0..<5) { index in
            starImage(for: index, rating: rating)
                .foregroundStyle(Color.yellow)
        }
    }
    
    private func starImage(for index: Int, rating: Double) -> some View {
        let fullStars = floor(rating)
        let fractionalPart = rating - fullStars
        
        if Double(index) < fullStars {
            return Image(systemName: "star.fill")
        } else if Double(index) == fullStars && fractionalPart >= 0.5 {
            return Image(systemName: "star.lefthalf.fill")
        } else {
            return Image(systemName: "star")
        }
    }
}

#Preview {
    StarRatingsView(rating: 4.5)
}
