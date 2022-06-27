//
//  Destination.swift
//  TravelApp
//
//  Created by Edoardo Benissimo on 27/06/22.
//

import Foundation

struct Destination: Identifiable, Equatable, Hashable {
    let id = UUID()
    var destinationName: String
    var destinationImage: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Destination, rhs: Destination) -> Bool {
        return lhs.id == rhs.id
    }
}
