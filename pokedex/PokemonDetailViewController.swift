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
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon?.name
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
