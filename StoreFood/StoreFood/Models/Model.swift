//
//  Model.swift
//  StoreFood
//
//  Created by Kholod Sultan on 19/05/1443 AH.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth



struct Cake {
    var name :String
    var summary: String
    var price: String
    var image: String
    var cookby: String
    var uid: String
    var rate:String
}


var cakes: Array<Cake> = []
var purchasedProducts: Array<Cake> = []
var cartArr: [Cake] = []

var allimage: Array<Cake>=[
    
                              ]


struct Category {
    var image: String
    var name: String
    var uid: String
}



