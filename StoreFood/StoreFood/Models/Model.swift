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
}


var cakes: Array<Cake> = []
var purchasedProducts: Array<Cake> = []
var cartArr: [Cake] = []

var allimage: Array<Cake>=[
//    Cake(name: "Tart Lemon", summary: "كيك الحامض الطبيعي بشرائح الحامض بالسكّر ",price: "50",image: "1",cookby: "YaraBakery                     ⭐️⭐️⭐️", uid: ""),
//    Cake(name: "BlackJack bites", summary: "كيك الشوكولاته بغاناش الشوكولاته ", price: "150", image: "2", cookby:  "Cake.Nora                      ⭐️⭐️⭐️", uid: ""),
//    Cake(name: "French Mile View desssert", summary: "رقائق البف  مع حشوة الكاسترد ", price: "70", image:"3", cookby:  "YaraBakery               ⭐️⭐️⭐️", uid: ""),
//    Cake(name: "BoobChocolte", summary: "كيكة التشوكلت بحشوه صوص التوتوحبات التوت الطازجة ", price: "50", image: "4", cookby: "salwa.kitchen        ⭐️⭐️⭐️", uid: ""),
//    Cake(name: "Pikachu", summary: " كيكة مجسمه أنمي بيكاتشو ،الكمية تكفي  ١٠ أشخاص ", price: "500", image: "5", cookby:  "cake.oclock.jed", uid: ""),
//    Cake(name: "CrushCake", summary: " كيكة مجسمه أنمي كراش   ،الكمية تكفي ١٠ أشخاص   ", price: "600", image: "6", cookby:  "cake.oclock.jed", uid: ""),
//    Cake(name: "Raspberry tart", summary:" بوكس مكون من ٦قطع تارت بالتوت الطازج ", price: "70", image: "7", cookby:  "cake.oclock.jed             ⭐️⭐️⭐️", uid: ""),
//    Cake(name: "CaramelCake", summary: " كيكة مجسمه أنمي،العدد ١٠ أشخاص   ", price: "150", image: "8", cookby:  "cake.oclock.jed           ⭐️⭐️⭐️", uid: ""),
//    Cake(name: "RoseCake", summary: "بوكس مكّون من ٦ قطع  ", price: "100", image: "9", cookby:"YaraBakery     ⭐️⭐️⭐️", uid: ""),
//    Cake(name: "RasbaryCake", summary:" كيكة  ", price: "100", image: "10", cookby:  "cake.oclock.jed             ⭐️⭐️⭐️", uid: "")

]


struct Category {
    var image: String
    var name: String
    var uid: String
}



