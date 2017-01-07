//
//  LocalAudios.swift
//  SomaIOS
//
//  Created by ali ziwa on 10/11/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import RealmSwift

class LocalAudios: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var audios_array = [String]()
    var audios_names = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchAudiosFromDB()
        self.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "bookshelf-bg-320.png")!)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return audios_array.count
        //return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "audioCell", for: indexPath) as! LocalAudioCollectionViewCell
        cell.image.image = UIImage(named: "kids2")
        cell.label.text = audios_names[indexPath.row]
        cell.image.layer.shadowColor = UIColor.black.cgColor
        cell.image.layer.shadowOffset = CGSize(width: 1, height: 1);
        cell.image.layer.shadowOpacity = 0.5;
        cell.image.layer.shadowRadius = 3.0;
        cell.image.clipsToBounds = false;

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "player", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPaths = self.collectionView!.indexPathsForSelectedItems!
        let indexPath = indexPaths[0] as IndexPath
        
        let navView = segue.destination as! UINavigationController
        let audioPlayer = navView.topViewController as! AudioPlayer
        audioPlayer.songPath = document(getAudioNameFromPath(path: self.audios_array[indexPath.row]))!
        
    }
    
    func fetchAudiosFromDB(){
        let localAudios = try! Realm().objects(AudioModel.self)
        
        for i in 0..<localAudios.count {
            audios_array.append(localAudios[i].filename as String)
            audios_names.append(localAudios[i].title as String)
            print("\(localAudios[i].filename ) ==> local audios")
        }
    }
    
    func getAudioNameFromPath(path: String)->String {
        let pdfLink = path
        
        let index2 = pdfLink.range(of: "/", options: .backwards)?.lowerBound
        
        let substring2 = pdfLink.substring(from: index2!)
        
        print(substring2)
        
        print("\(substring2) file path after removing pdf slashes")
        
        return substring2
    }
    
    fileprivate func document(_ name: String) -> String? {
        //Bundle.init(path: name)
        guard let documentURL = self.getAudiosURL().appendingPathComponent(name)
            else { return nil }
        print(documentURL.path)
        
        return documentURL.path
    }
    
    func getAudiosURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL as NSURL
    }

}
