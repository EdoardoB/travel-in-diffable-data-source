//
//  Info.swift
//  TravelApp
//
//  Created by Edoardo Benissimo on 27/06/22.
//

import Foundation

struct Info: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var subtitle: String
    let emoticon: String
}
