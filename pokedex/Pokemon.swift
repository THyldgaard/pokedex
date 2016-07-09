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
                            if let weight = json["weight"].string {
                                self.weight = "\(weight)"
                            } else  {
                                print(json["weight"].error)
                            }
                            
                            if let height = json["height"].string {
                                self.height = "\(height)"
                            } else {
                                print(json["height"].error)
                            }
                            
                            if let attack = json["attack"].number {
                                self.attack = "\(attack)"
                            } else {
                                print(json["attack"].error)
                            }
                            
                            if let defense = json["defense"].number {
                                self.defense = "\(defense)"
                            } else {
                                print(json["defense"].error)
                            }
//                            if let attack = json["stats"][4]["base_stat"].number {
//                                self.attack = "\(attack)"
//                            } else {
//                                print(json["stats"][4]["base_stat"].error)
//                            }
//                            
//                            if let defense = json["stats"][3]["base_stat"].number {
//                                self.defense = "\(defense)"
//                            } else {
//                                print(json["stats"][3]["base_stat"].error)
//                            }
                            
                            if let types = json["types"].array where types.count > 0 {
                                var typeString = "\(types[0]["name"])".capitalizedString
                                
                                if types.count > 1 {
                                    for i in 1..<types.count {
                                        typeString += " / \(types[i]["name"])".capitalizedString
                                    }
                                }
                                
                                self.type = typeString
                                print(self.type)
                            } else {
                                self.type = ""
                                print(json["types"].error)
                            }
                            
                            //print(json)
                            print(self.height)
                            print(self.weight)
                            print(self.attack)
                            print(self.defense)
                            if let descriptions = json["descriptions"].array where descriptions.count > 0 {
                                if let url = descriptions[0]["resource_uri"].string {
                                    guard let nsUrl = NSURL(string: "\(URL_BASE)\(url)") else { return }
                                    Alamofire.request(.GET, nsUrl)
                                        .validate()
                                        .responseJSON() { descResponse in
                                            switch descResponse.result {
                                            case .Success:
                                                if let responseValue = descResponse.result.value {
                                                    let descriptionJson = JSON(responseValue)
                                                    if let description = descriptionJson["description"].string {
                                                        self.description = description
                                                    } else {
                                                        print(descriptionJson["description"].error)
                                                    }
                                                }
                                            case .Failure(let err):
                                                print(err)
                                                
                                            }
                                    }
                                }
                            } else {
                                self.description = ""
                            }
                            
                            if let evolution = json["evolutions"].array where evolution.count > 0 {
                                if let evovleTo = evolution[0]["to"].string {
                                    // support some, but not all mega pokemon yet.
                                    if evovleTo.rangeOfString("mega") == nil {
                                        
                                    } else {
                                        if evovleTo.containsString("meganium") || evovleTo.containsString("yanmega") {
                                            
                                        } else {
                                            return
                                        }
                                    }
                                } else  {
                                    print(evolution[0]["to"].error)
                                }
                            } else {
                                return
                            }
                        }
                    }
                case .Failure(let err):
                    print(err)
                }
        }
    }
    
}
