//
//  RecycleViewController.swift
//  EcologyLife
//
//  Created by Полина on 11/03/2019.
//  Copyright © 2019 Polina. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RecycleViewController: UIViewController {
    
    @IBOutlet weak var recycleCollectionView: UICollectionView!
    
    var itemRecycleArray: [RecycleArticle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        requestForRececleText()
    }
    
    func initCollectionView(){
        recycleCollectionView.dataSource = self
        recycleCollectionView.delegate = self
    }
    
    func requestForRececleText(){
        Alamofire.request("http://127.0.0.1:8282/v1/recycletext").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
            
            self.parseJson(json: JSON(response.result.value!))
        }
    }
    
    private func parseJson(json: JSON){
        print(json)
        print(json["success"])
        print(json["msg"])
        
        let recycleTextJson = json["msg"].array
        var recycleText: [RecycleArticle] = []
        
        recycleTextJson?.forEach { (json) in
            var blankMenu = RecycleArticle()
            blankMenu.recycleName = json["recycleName"].string
            blankMenu.recycleImageName =  json["recycleImageName"].string
            blankMenu.recycleNotificationName =  json["recycleNotificationName"].string
            blankMenu.recycleTextView =  json["recycleTextView"].string
            recycleText.append(blankMenu)
        }
        self.itemRecycleArray = recycleText
        self.recycleCollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTVC" {
            if let tvc = segue.destination as? DetailViewController {
                let menu = sender as? RecycleArticle
                print(menu ?? "nil")
                tvc.menu = menu
            }
        }
    }
}

    extension RecycleViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemRecycleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "recycleCell", for: indexPath) as? RecycleCollectionViewCell {
            itemCell.recycleMenu = itemRecycleArray[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menu = itemRecycleArray[indexPath.row]
        self.performSegue(withIdentifier: "showTVC", sender: menu)
    }
}
