//
//  Plan.swift
//  TravelApp
//
//  Created by Edoardo Benissimo on 27/06/22.
//

import Foundation

struct Plan: Identifiable, Hashable {
    let id = UUID()
    var steps: [PlanSteps]
}

struct PlanSteps: Hashable {
    var emoticon: String
    var title: String
}
