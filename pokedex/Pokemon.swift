//
//  Pokemon.swift
//  pokedex
//
//  Created by Tonni Hyldgaard on 6/18/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import Foundation

class Pokemon {
    private(set) var name: String!
    private(set) var pokedexId: Int!
    
    init(name: String, pokedexId: Int) {
        self.name = name
        self.pokedexId = pokedexId
    }
    
}
