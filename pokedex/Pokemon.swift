//
//  Pokemon.swift
//  pokedex
//
//  Created by Tonni Hyldgaard on 6/18/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import Foundation

class Pokemon {
    private var _pokedexId: Int!
    private var _name: String!
    
    var name: String {
        get {
            return _name
        }
    }
    
    var pokedexId: Int {
        get {
            return _pokedexId
        }
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
    
}
