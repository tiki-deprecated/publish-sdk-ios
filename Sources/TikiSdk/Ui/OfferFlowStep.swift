//
//  File.swift
//  
//
//  Created by Ricardo on 20/03/23.
//

import Foundation

enum OfferFlowStep{
    case none,
         prompt,
         terms,
         learnMore,
         endingAccepted,
         endingDeclined,
         endingError
}
