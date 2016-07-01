//
//  ViewController.swift
//  pokedex
//
//  Created by Tonni Hyldgaard on 6/18/16.
//  Copyright © 2016 Tonni Hyldgaard. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        
        initAudio()
        parsePokemonCSV()
        
    }
    
    func parsePokemonCSV() {
        guard let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv") else { return }
        
        do {
            let csv = try CSV(contentsOfURL: path)
            
            let rows = csv.rows
            
            for row in rows {
                guard let pokeId = row["id"], let id = Int(pokeId), let name = row["identifier"] else { return }
                pokemon.append(Pokemon(name: name, pokedexId: id))
                
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            
            cell.configureCell(pokemon[indexPath.row])
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 717
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(determineImageSizeDependingOnScreen(), determineImageSizeDependingOnScreen())
    }
    
    func determineImageSizeDependingOnScreen() -> CGFloat {
        return 105
        //return (UIScreen.mainScreen().bounds.width / 4)
    }

    func initAudio() {
        guard let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3") else { return }
        
        do {
            if !path.isEmpty {
                musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            }
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError {
            
        }
        
    }
    
    @IBAction func musicButtonPress(sender: UIButton!) {
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    

}
