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
    private(set) var nextEvolutionId: String!
    private(set) var nextEvolutionLevel: String!
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
                        
                        if !json.isEmpty {
                            guard let weight = json["weight"].string else  {
                                print(json["weight"].error)
                                return
                            }
                            
                            guard let height = json["height"].string else {
                                print(json["height"].error)
                                return
                            }
                            
                            guard let attack = json["attack"].number else {
                                print(json["attack"].error)
                                return
                            }
                            
                            guard let defense = json["defense"].number else {
                                print(json["attack"].error)
                                return
                            }
                            
                            guard let types = json["types"].array where types.count > 0 else {return}
                            var typeString = types[0]["name"].stringValue.capitalizedString
                            for i in 1..<types.count where types.count > 1 {
                                typeString += " / \(types[i]["name"])".capitalizedString
                            }
                            
                            guard let evolution = json["evolutions"].array where evolution.count > 0,
                                let evovleTo = evolution[0]["to"].string,
                                let level = evolution[0]["level"].number
                                else { return }
                            
                            self.weight = "\(weight)"
                            self.height = "\(height)"
                            self.attack = "\(attack)"
                            self.defense = "\(defense)"
                            self.type = typeString
                            self.nextEvolutionText = evovleTo
                            self.nextEvolutionLevel = "\(level)"
                            
                            // support some, but not all mega pokemon yet.
                            if evovleTo.rangeOfString("mega") == nil {
                                self.nextEvolutionId = self.determineNextEvolutionId(evolution[0]["resource_uri"].string)
                            } else {
                                if evovleTo.containsString("meganium") || evovleTo.containsString("yanmega") {
                                    self.determineNextEvolutionId(evolution[0]["resource_uri"].string)
                                } else {
                                    self.nextEvolutionId = ""
                                }
                            }
                            
                            guard let descriptions = json["descriptions"].array where descriptions.count > 0,
                                let url = descriptions[0]["resource_uri"].string,
                                let nsUrl = NSURL(string: "\(URL_BASE)\(url)")
                                else { return }
                            Alamofire.request(.GET, nsUrl)
                                .validate()
                                .responseJSON() { descriptionResponse in
                                    switch descriptionResponse.result {
                                    case .Success:
                                        guard let responseValue = descriptionResponse.result.value else { return }
                                        let descriptionJson = JSON(responseValue)
                                        guard let description = descriptionJson["description"].string else { return }
                                        self.description = description
                                    case .Failure(let err):
                                        print(err)
                                    }
                            }
                        }
                    }
                case .Failure(let err):
                    print(err)
                }
        }
    }
    
    func determineNextEvolutionId(levelURILink: String?) -> String {
        guard let uri = levelURILink else { return "" }
        let preNum = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
        return preNum.stringByReplacingOccurrencesOfString("/", withString: "")
    }
    
}