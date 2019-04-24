//
//  TipsViewController.swift
//  EcologyLife
//
//  Created by Полина on 11/03/2019.
//  Copyright © 2019 Polina. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TipsViewController: UIViewController {

    @IBOutlet weak var tipsCollectionView: UICollectionView!
    
    var itemTipsArray: [Tip] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        requestForTips()
    }

    func initCollectionView(){
    tipsCollectionView.dataSource = self
    tipsCollectionView.delegate = self
    }
    
    func requestForTips(){
    Alamofire.request("http://127.0.0.1:8282/v1/tips").responseJSON { response in
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
        
        let tipsJson = json["msg"].array
        var tips: [Tip] = []
        
        tipsJson?.forEach { (json) in
            var blankMenu = Tip()
            blankMenu.tipsName = json["tipsName"].string
            blankMenu.tipsImageName =  json["tipsImageName"].string
            tips.append(blankMenu)
        }
        self.itemTipsArray = tips
        self.tipsCollectionView.reloadData()
    }
}

    extension TipsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemTipsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tipsCell", for: indexPath) as? TipsCollectionViewCell {
            itemCell.tipsMenu = itemTipsArray[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
