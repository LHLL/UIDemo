//
//  DataModule.swift
//  UIDemo
//
//  Created by Xu, Jay on 2/23/17.
//  Copyright © 2017 Wells Fargo. All rights reserved.
//

import Foundation

struct Library {
    static var defaultLibrary = Library()
    var movieList = [Movie](){
        didSet {
            if movieList.count != coverList.count {
                imgLoader()
            }
        }
    }
    var coverList = [UIImage]()
    
    private init() {
        WebServiceHandler().send(r: MovieRequest()) { (result) in
            switch result{
            case .success(let lib):
                Library.defaultLibrary.movieList = lib.movieList
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private mutating func imgLoader(){
        var temp = [UIImage]()
        for movie in movieList {
            let url = URL(string: movie.cover.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
            let imgData = try? Data(contentsOf: url!)
            let img = UIImage(data: imgData!)!
            temp.append(img)
        }
        coverList = temp
    }
}

struct MovieRequest:Request {
    var url: URL = URL(string:"https://itunes.apple.com/us/rss/topmovies/limit=25/genre=4401/json")!
    typealias Response = Library
}

struct Movie:Equatable {
    
    let cover:String
    let name:String
    let priceTag:String
    let post:String
    
    init(jsonObject:[String:Any]){
        let nameDict = jsonObject["im:name"] as! [String:String]
        self.name = nameDict["label"]!
        
        let priceDict = jsonObject["im:price"] as! [String:Any]
        self.priceTag = priceDict["label"] as! String
        
        let postDict = jsonObject["summary"] as! [String:String]
        self.post = postDict["label"]!
        
        let imageDict = jsonObject["im:image"] as! [[String:Any]]
        let highResImgDict = imageDict[2]
        self.cover = highResImgDict["label"] as! String
    }
    
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        if lhs.name == rhs.name && lhs.priceTag == rhs.priceTag {
            return true
        }else {
            return false
        }
    }
}

extension Library:Decodeable {
    static func parse(data: Data)->Library?{
        var lib = Library.defaultLibrary
        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
        let feedDict = jsonObject!["feed"] as! [String:AnyObject]
        let entry = feedDict["entry"]! as! [AnyObject]
        for dict in entry {
            let movie = Movie(jsonObject: dict as! [String : AnyObject])
            lib.movieList.append(movie)
        }
        return lib
    }
}
