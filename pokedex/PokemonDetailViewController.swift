//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Tonni Hyldgaard on 7/3/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightlbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    var pokemon: Pokemon?
    
    func updateUI() {
        guard let description = pokemon?.description else { return }
        guard let type = pokemon?.type else { return }
        guard let defense = pokemon?.defense else { return }
        guard let height = pokemon?.height else { return }
        guard let id = pokemon?.pokedexId else { return }
        guard let weight = pokemon?.weight else { return }
        guard let baseAttack = pokemon?.attack else { return }
        guard let nextEvolutionText = pokemon?.nextEvolutionText else { return }
        guard let nextEvolutionId = pokemon?.nextEvolutionId else { return }
        
        self.descriptionLbl.text = description
        self.typeLbl.text = type
        self.defenseLbl.text = defense
        self.heightlbl.text = height
        self.pokedexLbl.text = "\(id)"
        self.weightLbl.text = weight
        self.baseAttackLbl.text = baseAttack
        
        if nextEvolutionId == "" {
            self.evoLbl.text = "No further evolution possible"
            self.nextEvoImg.hidden = true
        } else {
            self.nextEvoImg.hidden = false
            self.nextEvoImg.image = UIImage(named: nextEvolutionId)
            var nextEvoTxt = "Next Evolution: \(nextEvolutionText)"
            if let nextEvolutionLvl = pokemon?.nextEvolutionLevel {
                if nextEvolutionLvl != "" {
                    nextEvoTxt += " - Level: \(nextEvolutionLvl)"
                }
            }
            self.evoLbl.text = nextEvoTxt
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon?.name
        if let pokeId = pokemon?.pokedexId {
            mainImg.image = UIImage(named: "\(pokeId)")
            currentEvoImg.image = mainImg.image
        }
        
        pokemon?.downloadPokemonDetails { () -> Void in
            // This will be called after download is done.
            self.updateUI()
        }
                
    }
    
    
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
