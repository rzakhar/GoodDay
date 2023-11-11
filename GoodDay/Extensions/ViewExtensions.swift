/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Helper extensions to simplify multiplatform development.
*/

import SwiftUI
import UIKit

extension View {    
    /// A debugging function to add a border around a view.
    func debugBorder(color: Color = .red, width: CGFloat = 1.0, opacity: CGFloat = 1.0) -> some View {
        self
            .border(color, width: width)
            .opacity(opacity)
    }
}
