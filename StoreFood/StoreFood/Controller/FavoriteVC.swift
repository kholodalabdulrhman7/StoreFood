//
//  FavoriteVC.swift
//  StoreFood
//
//  Created by Kholod Sultan on 07/06/1443 AH.
//

import UIKit
import JGProgressHUD
import FirebaseAuth
import FirebaseFirestore


class FavouriteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    var filteredData: [Cake] = []
    var isFilter = false
    var productsData: [Cake] = []
    var docIds: [String] = []

    let hud = JGProgressHUD()

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.ID, for: indexPath) as? CollectionCell else {
            return UICollectionViewCell()
        }
        

        cell.setCell(card:  self.productsData[indexPath.row])

        
        cell.isDeleteHidden = true

        
        cell.favBtn.addTarget(self, action: #selector(deleteFromFav), for: .touchUpInside)
        cell.favBtn.tag = indexPath.row

        
        
     return cell
    }

    
    @objc func deleteFromFav(sender: UIButton) {
        let alert = UIAlertController(title: "تحذير", message: "هل أنت متأكد من حذف المنتج من المفضلة ؟", preferredStyle: UIAlertController.Style.alert)
        
        
        alert.addAction(UIAlertAction(title: "نعم", style: UIAlertAction.Style.default, handler: { action in
            
            self.deleteCartProduct(uid: self.docIds[sender.tag])
        }))
        
        alert.addAction(UIAlertAction(title: "إلغاء", style: UIAlertAction.Style.destructive, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @objc func deleteProduct(sender: UIButton) {
        let alert = UIAlertController(title: "تحذير", message: "هل أنت متأكد من حذف المنتج من المفضلة ؟", preferredStyle: UIAlertController.Style.alert)
        
        
        alert.addAction(UIAlertAction(title: "نعم", style: UIAlertAction.Style.default, handler: { action in

            self.deleteCartProduct(uid: self.docIds[sender.tag])
        }))
        
        alert.addAction(UIAlertAction(title: "إلغاء", style: UIAlertAction.Style.destructive, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailVC()
        

            vc.cake = productsData[indexPath.row]
        
       
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
        var collectionView: UICollectionView!
    lazy var searchBar:UISearchBar = UISearchBar()

        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            if #available(iOS 15, *) {
                    let appearance = UINavigationBarAppearance()
                    appearance.configureWithOpaqueBackground()
                    navigationController?.navigationBar.standardAppearance = appearance;
                    navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
                }
            
            self.navigationController?.navigationBar.topItem?.title = "Favourite"

            
            configureCollectionView()
            
            view.backgroundColor = UIColor.systemGray6
//            self.navigationItem.largeTitleDisplayMode = .always
            
//            self.collectionView.reloadData()
            print(cartArr.count)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        getCartProducts()
        print(cartArr.count)
    }
    
    @objc func addTapped() {
        let vc = AddProductViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func configureCollectionView(){
            collectionView   = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), collectionViewLayout: Layout())
            collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            collectionView.backgroundColor = UIColor(named: "backgroundColor")
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.showsVerticalScrollIndicator = false
            collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.ID)
            view.addSubview(collectionView)
        }
    
    
        private func Layout() -> UICollectionViewCompositionalLayout{

        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 19, bottom: 30, trailing: 19)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(300)),subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
     
        
        section.contentInsets.top = 25
        return UICollectionViewCompositionalLayout(section: section)
        
        }
    


    private func deleteCartProduct(uid: String) {

        db.collection("favourite").document(uid).delete()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.getCartProducts()
        }
    }
 
    private func getCartProducts() {
        self.productsData.removeAll()
        self.hud.show(in: self.view)
        hud.textLabel.text = "Loading"
        
        db.collection("favourite").whereField("userId", isEqualTo: Auth.auth().currentUser?.uid ?? "").getDocuments { (snapshot, err) in
            if let error = err {
                print("error getting documents \(error)")
                self.hud.dismiss()
            } else {
                var ids:[String] = []
                
                for document in snapshot!.documents {
                    let docId = document.documentID
                    let userId = document.get("userId") as! String
                    let productId = document.get("productId") as! String
                    
                    ids.append(productId)
                    self.docIds.append(docId)
                    print(userId)
                    print(document)
                }
                
                if ids.count > 0 {
                    self.getProducts(ids: ids)
                }else {
                    self.hud.dismiss()
                }

            }
            
        }
    }
    
    private func getProducts(ids: [String]) {
        
        db.collection("products").whereField("uid", in: ids).getDocuments { (snapshot, err) in
            if let error = err {
                print("error getting documents \(error)")
            } else {
                var products:[Cake] = []
               
                for document in snapshot!.documents {
                    let docId = document.documentID
                    let name = document.get("name") as! String
                    let summary = document.get("summary") as! String
                    let price = document.get("price") as! String
                    let image = document.get("image") as! String
                    let cookby = document.get("cookby") as! String
                    let rate = document.get("rate") as? String

                    let product = Cake(name: name, summary: summary, price: price, image: image, cookby: cookby, uid: docId, rate: rate ?? "")
                    products.append(product)
                }
                
                DispatchQueue.main.async {
                    self.productsData.append(contentsOf: products)
                    self.collectionView.reloadData()
                    self.hud.dismiss()
                }
            }
            
        }
    }
    

}
