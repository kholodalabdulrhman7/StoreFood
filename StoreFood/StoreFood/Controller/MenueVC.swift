//
//  MenueVC.swift
//  StoreFood
//
//  Created by Kholod Sultan on 23/05/1443 AH.
//




import UIKit
import JGProgressHUD
import MOLH

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    

    
    var tableView = UITableView()

    var menuImages:[String] = ["user", "choices", "language","heart", "support", "color-palette"]
    var menuNames:[String] = ["Profile".localized, "Orders Number".localized, "Change Language".localized,"Favourite", "Customer Support".localized, "Change appearance".localized]
    
    var ordersCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        self.view.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.systemGray6
        tableView.backgroundColor = .clear

        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        getCartProducts()

    }
    
    
    func setupTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .singleLine
        
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "menuTableViewCell")
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.menuImageView.image = UIImage(named: menuImages[indexPath.row])!
        cell.name.text = menuNames[indexPath.row]
        
        switch indexPath.row {
        case 0:
            cell.detailsLbl.text = ""
        case 1:
            cell.detailsLbl.text = "\(ordersCount) Order"
        case 2:
            cell.detailsLbl.text = MOLHLanguage.currentAppleLanguage()
        case 3:
            cell.detailsLbl.text = ""
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuNames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = ProfileScreen()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            ChangeLanguage()
        case 3:
            let vc = FavouriteViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = CustomerSupportViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 5 :
            changeAppearance()
        default:
            break
        }
        

    }
    
    func changeAppearance() {
        switch traitCollection.userInterfaceStyle {
        case .light:
            AppDelegate.shared.window?.overrideUserInterfaceStyle = .dark
        case .dark:
            AppDelegate.shared.window?.overrideUserInterfaceStyle = .light
        case .unspecified:
            AppDelegate.shared.window?.overrideUserInterfaceStyle = .light
        @unknown default:
            AppDelegate.shared.window?.overrideUserInterfaceStyle = .dark
        }
    }
    
    
    func ChangeLanguage() {
        if MOLHLanguage.isArabic() {
            
            // create the alert
            let alert = UIAlertController(title: "Change language".localized, message: "Do you whant to change language to English".localized, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes".localized, style: UIAlertAction.Style.default, handler: { action in
                DispatchQueue.main.async {
                    MOLH.setLanguageTo("en")
                    UIView.appearance().semanticContentAttribute = .forceLeftToRight
                    let vc =  WelcomeScreen()

                    AppDelegate.shared.window?.rootViewController = UINavigationController(rootViewController: vc)

                }
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel".localized, style: UIAlertAction.Style.destructive, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            
        } else {
            // create the alert
            let alert = UIAlertController(title: "Change language".localized, message: "Do you whant to change language to Arabic".localized, preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Yes".localized, style: UIAlertAction.Style.default, handler: { action in
                DispatchQueue.main.async {
                MOLH.setLanguageTo("ar")

                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                let vc =  WelcomeScreen()
                AppDelegate.shared.window?.rootViewController = UINavigationController(rootViewController: vc)

                    
                }

            }))
            alert.addAction(UIAlertAction(title: "Cancel".localized, style: UIAlertAction.Style.destructive, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}

extension MenuViewController {
    
    
       private func getCartProducts() {
           db.collection("cart").getDocuments { (snapshot, err) in
               if let error = err {
                   print("error getting documents \(error)")
               } else {
                   var ids:[String] = []
                   
                   for document in snapshot!.documents {
//                       let docId = document.documentID
                       let userId = document.get("userId") as! String
                       let productId = document.get("productId") as! String
                       
                       ids.append(productId)
                       
                       print(userId)
                       print(document)
                   }
                   
                   self.ordersCount = ids.count
                   self.tableView.reloadData()
               }
               
           }
       }
}

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
