//
//  View+Extensions.swift
//  VehicleCompanion
//

import SwiftUI

extension View {
    func frame(cgSize: CGSize) -> some View {
        modifier(CGSizeFrameModifier(cgSize: cgSize))
    }
    
    nonisolated
    func swipeActions(
        edge: HorizontalEdge = .trailing,
        disabled: Binding<Bool>,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        modifier(SwipeActionsModifier(
            disabled: disabled,
            edge: edge,
            actions: {
                AnyView(content())
            }
        ))
    }
}
