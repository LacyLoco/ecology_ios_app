//
//  ArticlesViewController.swift
//  EcologyLife
//
//  Created by Полина on 03/03/2019.
//  Copyright © 2019 Polina. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON

//let cellId = "cellId"
class ArticlesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var itemArticleArray: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        requestForArticles()
    }
    
    func initCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func requestForArticles(){
        Alamofire.request("http://127.0.0.1:8282/v1/articles").responseJSON { response in
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
        
        let articlesJson = json["msg"].array
        var articles: [Article] = []
        
        articlesJson?.forEach { (json) in
            var blankMenu = Article()
            blankMenu.name = json["name"].string
            blankMenu.imageName =  json["imagename"].string
            blankMenu.link =  json["link"].string
            articles.append(blankMenu)
        }
        self.itemArticleArray = articles
        self.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showART" {
            if let tvc = segue.destination as? ArticleViewController {
                let menu = sender as? Article
                print(menu ?? "nil")
                tvc.menu = menu
            }
        }
    }
}

extension ArticlesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArticleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? ArticlesCollectionViewCell {
            itemCell.menu = itemArticleArray[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menu = itemArticleArray[indexPath.row]
        self.performSegue(withIdentifier: "showART", sender: menu)
    }
}

// shadows
extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = true
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius
    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}


