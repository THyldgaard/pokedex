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
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var heightlbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoLbl: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon?.name
        if let pokeId = pokemon?.pokedexId {
            mainImg.image = UIImage(named: "\(pokeId)")
        }
        
        pokemon?.downloadPokemonDetails { () -> Void in
            // This will be called after download is done.
        }
    }

    
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }


}
