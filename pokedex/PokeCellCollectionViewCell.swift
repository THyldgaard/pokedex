//
//  PokeCellCollectionViewCell.swift
//  pokedex
//
//  Created by Tonni Hyldgaard on 6/19/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import UIKit

class PokeCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
    }
}
