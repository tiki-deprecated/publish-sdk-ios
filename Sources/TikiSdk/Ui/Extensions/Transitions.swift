//
//  File.swift
//  
//
//  Created by Ricardo on 20/03/23.
//

import SwiftUI

extension AnyTransition {
    static var navigate: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .trailing))}
    
    
    static var bottomSheet: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .bottom),
            removal: .move(edge: .bottom))}
}
