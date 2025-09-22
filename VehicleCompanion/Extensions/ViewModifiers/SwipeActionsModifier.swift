//
//  SwipeActions.swift
//  VehicleCompanion
//

import SwiftUI

struct SwipeActionsModifier: ViewModifier {
    @Binding var disabled: Bool
    let edge: HorizontalEdge
    @ViewBuilder var actions: () -> AnyView
    
    func body(content: Content) -> some View {
        if disabled {
            content
        } else {
            content
                .swipeActions(
                    edge: edge,
                    content: actions
                    
                )
        }
    }
}
