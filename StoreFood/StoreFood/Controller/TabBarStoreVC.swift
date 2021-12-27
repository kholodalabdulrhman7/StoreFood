//
//  TabBarVC.swift
//  StoreFood
//
//  Created by Kholod Sultan on 20/05/1443 AH.
//

import UIKit

class StoreTabBar: UITabBarController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        viewControllers = [
        
      
            barItem(tabBarTitle:"Settings", tabBarImage: UIImage(systemName: "text.badge.plus")!.withTintColor(UIColor( #colorLiteral(red: 0.1595600843, green: 0.810018003, blue: 0.7768369317, alpha: 1)), renderingMode: .alwaysOriginal), viewController: Showstore()),
            
            
            barItem(tabBarTitle:"Donate", tabBarImage: UIImage(systemName: "dollarsign.square.fill")!.withTintColor(UIColor( #colorLiteral(red: 0.1607843137, green: 0.8117647059, blue: 0.7764705882, alpha: 1) ), renderingMode: .alwaysOriginal), viewController:DonateViewController()),
            
            barItem(tabBarTitle:"Cart", tabBarImage: UIImage(systemName: "cart")!.withTintColor(UIColor( #colorLiteral(red: 0.1595600843, green: 0.810018003, blue: 0.7768369317, alpha: 1) ), renderingMode: .alwaysOriginal), viewController:CartViewController()),
            barItem(tabBarTitle:"profile", tabBarImage: UIImage(systemName: "person.circle")!.withTintColor(UIColor( #colorLiteral(red: 0.1595600843, green: 0.810018003, blue: 0.7768369317, alpha: 1) ), renderingMode: .alwaysOriginal), viewController:MenuViewController()),
        
        ]
        
        tabBar.isTranslucent = true
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(#colorLiteral(red: 0.1595600843, green: 0.810018003, blue: 0.7768369317, alpha: 1) )], for: .selected)
        tabBar.unselectedItemTintColor = .gray
    }
    

    private func barItem(tabBarTitle: String, tabBarImage: UIImage, viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]
        navigationController.tabBarItem.title = tabBarTitle
        navigationController.tabBarItem.image = tabBarImage
//        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
}



