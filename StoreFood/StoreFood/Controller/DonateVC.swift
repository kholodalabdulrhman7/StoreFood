//
//  DonateVC.swift
//  StoreFood
//
//  Created by Kholod Sultan on 20/05/1443 AH.
//



import UIKit
import JGProgressHUD

class DonateViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!

    var products: [Cake] = []
    
    let hud = JGProgressHUD()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.systemGray6
        self.navigationController?.navigationBar.topItem?.title = "Donated Products"
        configureCollectionView()
        if #available(iOS 15, *) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                navigationController?.navigationBar.standardAppearance = appearance;
                navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
            }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    func getData() {
        self.getProducts { products in
            self.products = products
            self.hud.dismiss()
            self.collectionView.reloadData()
        }
    }
    
    
    private func getProducts(completion: @escaping([Cake])->()) {
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        db.collection("products").whereField("type", isEqualTo: "1").getDocuments { (snapshot, err) in
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
                completion(products)
            }
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.ID, for: indexPath) as? CollectionCell else {
            return UICollectionViewCell()
        }
        

        cell.setCell(card:  products[indexPath.row])



        
     return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = DetailVC()
        
        vc.cake = products[indexPath.row]
        
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

}
