//
//  Pokemon.swift
//  pokedex
//
//  Created by Tonni Hyldgaard on 6/18/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Pokemon {
    private(set) var name: String!
    private(set) var pokedexId: Int!
    private(set) var description: String!
    private(set) var type: String!
    private(set) var defence: String!
    private(set) var height: String!
    private(set) var weight: String!
    private(set) var attack: String!
    private(set) var nextEvolutionText: String!
    private(set) var resourceUrl: String!
    
    init(name: String, pokedexId: Int) {
        self.name = name
        self.pokedexId = pokedexId
        
        self.resourceUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)"
    }
    
    func downloadPokemonDetails(complete: DownloadComplete) {
        guard let url = NSURL(string: self.resourceUrl) else { return }
        Alamofire.request(.GET, url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let jsonData = response.result.value {
                        let json = JSON(jsonData)
                        print(json)
                    }
                    //                    if let dict = response.result.value as? Dictionary<String, AnyObject> {
//                        //print(dict.values)
//                        if let weight = dict["weight"] as? Int {
//                            self.weight = "\(weight)"
//                        }
//                        if let height = dict["height"] as? Int {
//                            self.height = "\(height)"
//                        }
//                      
//                        print(self.weight)
//                        
//                    }
                    
                case .Failure(let err):
                    print(err)
                }
        }
    }
    
}
