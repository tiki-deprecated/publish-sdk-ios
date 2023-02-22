/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import SwiftUI

/// A dismissible bottom sheet that shows an *Offer* to the user.
///
/// This bottom sheet is the first UI in the TIKI user flow.
/// There are 4 available actions in this screen:
///  - learnMore: will show the *TextViewer* screen with *learnMoreText* loaded.
///  - deny: will show the *CompletionSheet.backoff*.
///  - allow: will show the *CompletionSheet.awesome*. If *requireTerms* is
///  true, it will show the *TextViewer* with *termsText* for the user accept the
///  terms before the *CompletionSheet.awesome* screen is shown.
struct OfferSheet: View {
    
    let offer: Offer
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
//
//struct OfferSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        // TODO
//    }
//}
