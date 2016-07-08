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
    private(set) var defense: String!
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
                        
                        if json.count > 0 {
                            if let weight = json["weight"].number {
                                self.weight = "\(weight)"
                            } else  {
                                print(json["weight"].error)
                            }
                            
                            if let height = json["height"].number {
                                self.height = "\(height)"
                            } else {
                                print(json["height"].error)
                            }
                            
                            if let attack = json["stats"][4]["base_stat"].number {
                                self.attack = "\(attack)"
                            } else {
                                print(json["stats"][4]["base_stat"].error)
                            }
                            
                            if let defense = json["stats"][3]["base_stat"].number {
                                self.defense = "\(defense)"
                            } else {
                                print(json["stats"][3]["base_stat"].error)
                            }
                            
                            if let types = json["types"].array where types.count > 0 {
                                var typeString = "\(types[0]["type"]["name"])".capitalizedString
                                
                                if types.count > 1 {
                                    for i in 1..<types.count {
                                        typeString += " / \(types[i]["type"]["name"])".capitalizedString
                                    }
                                }
                                
                                self.type = typeString
                                print(self.type)
                            } else {
                                self.type = ""
                                print(json["types"].error)
                            }

                        }
                        
                    }
                case .Failure(let err):
                    print(err)
                }
        }
    }
    
}
