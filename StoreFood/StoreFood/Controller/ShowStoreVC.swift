//
//  ShowStoreVC.swift
//  StoreFood
//
//  Created by Kholod Sultan on 20/05/1443 AH.
//


import UIKit
import JGProgressHUD


class Showstore: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    var filteredData: [Cake] = []
    var isFilter = false
    var products: [Cake] = []
    
    var selectedCategoryIndex: Int?
    
    var categories: [Category] = [
        
        var categoriesCollection:UICollectionView!
            
            let hud = JGProgressHUD()
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollection {
            return categories.count
        } else {
            return isFilter ? filteredData.count : products.count

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoriesCollection {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.ID, for: indexPath) as? CategoriesCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.sertCell(category: categories[indexPath.row])
            
         return cell
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.ID, for: indexPath) as? CollectionCell else {
                return UICollectionViewCell()
            }
            
            if isFilter {
                cell.setCell(card:  filteredData[indexPath.row])
            } else {
                cell.setCell(card:  products[indexPath.row])

            }
            
            cell.deleteBtn.addTarget(self, action: #selector(deleteProduct), for: .touchUpInside)
            cell.deleteBtn.tag = indexPath.row
          

            
         return cell
        }
    
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == CategoriesCollectionViewCell {
//            Ret
//        } else {
//
//        }
//    }

    
    @objc func deleteProduct(sender: UIButton) {
        let alert = UIAlertController(title: "تحذير", message: "هل أنت متأكد من حذف المنتج ؟", preferredStyle: UIAlertController.Style.alert)
        
        
        alert.addAction(UIAlertAction(title: "نعم", style: UIAlertAction.Style.default, handler: { action in
            
            if self.isFilter {
                self.remove(child: self.filteredData[sender.tag].uid )
            } else {
                self.remove(child: self.products[sender.tag].uid)
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "إلغاء", style: UIAlertAction.Style.destructive, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func remove(child: String) {

       let ref = db.collection("products").document(child)
        
        ref.delete()
        self.getData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesCollection {
            
        } else {
            let vc = DetailVC()
            
            if isFilter {
                vc.cake = filteredData[indexPath.row]
            } else {
                vc.cake = products[indexPath.row]
            }
           
            self.navigationController?.pushViewController(vc, animated: true)
        }

        
    }
    
    
    
        var collectionView: UICollectionView!
    lazy var searchBar:UISearchBar = UISearchBar()

        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            if #available(iOS 15, *) {
                    let appearance = UINavigationBarAppearance()
                    appearance.configureWithOpaqueBackground()
//                    appearance.backgroundColor = < your tint color >
                    navigationController?.navigationBar.standardAppearance = appearance;
                    navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
                }
            

            
            getCurrentUserFromFirestore { type in
                print("the user type is \(type)")
                if type == "1" {
                    self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addTapped))
                }
            }
            
            configureCollectionView()
            
            view.backgroundColor = UIColor.systemGray6
            self.title = "Cakes"
            self.navigationItem.largeTitleDisplayMode = .always
            
            searchBar.searchBarStyle = UISearchBar.Style.default
            searchBar.placeholder = " Search..."
            searchBar.sizeToFit()
            searchBar.isTranslucent = false
            searchBar.backgroundImage = UIImage()
            searchBar.delegate = self
            navigationItem.titleView = searchBar
            
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getData()

    }
    
    @objc func addTapped() {
        let vc = AddProductViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        if let txt = searchBar.text, txt != "" {
            filteredData = products.filter { $0.name.contains(txt)}
            self.isFilter = true
            print(filteredData.count)
            print(txt)
            collectionView.reloadData()
        } else {
            isFilter = false
            collectionView.reloadData()
        }
    }
    
    
    func getData() {
        self.getProducts { products in
            self.products = products
            self.collectionView.reloadData()
        }
    }
    
    
    private func getProducts(completion: @escaping([Cake])->()) {
        db.collection("products").whereField("type", isEqualTo: "0").getDocuments { (snapshot, err) in
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

                    let product = Cake(name: name, summary: summary, price: price, image: image, cookby: cookby, uid: docId)
                    products.append(product)
                }
                completion(products)
            }
            
        }
    }
    
    private func configureCollectionView(){
        collectionView   = UICollectionView(frame: CGRect.zero, collectionViewLayout: Layout())
//            collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            collectionView.backgroundColor = UIColor(named: "backgroundColor")
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.showsVerticalScrollIndicator = false
            collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.ID)
        
        

        
        let viewForCollection = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        viewForCollection.backgroundColor = .clear
        categoriesCollection = UICollectionView(frame: CGRect.zero, collectionViewLayout: CategoriesLayout())
        view.addSubview(viewForCollection)
        view.addSubview(collectionView)
        viewForCollection.addSubview(categoriesCollection)
    
        

       

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        viewForCollection.translatesAutoresizingMaskIntoConstraints = false
        categoriesCollection.translatesAutoresizingMaskIntoConstraints = false

        let margins = view.layoutMarginsGuide

        let horizontalConstraint = viewForCollection.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0)
        let verticalConstraint = viewForCollection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        let rightConstraint = viewForCollection.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        let heightConstraint = viewForCollection.heightAnchor.constraint(equalToConstant: 50)


        let sHorizontalConstraint = collectionView.topAnchor.constraint(equalTo: viewForCollection.bottomAnchor, constant: 16)
        let sVerticalConstraint = collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        let sRightConstraint = collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        let sBottomConstraint = collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0)

        view.addConstraints([horizontalConstraint, verticalConstraint, rightConstraint, heightConstraint, sHorizontalConstraint, sVerticalConstraint, sRightConstraint, sBottomConstraint])
        
      
        categoriesCollection.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.ID)

        
        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        categoriesCollection.backgroundColor = .clear
        categoriesCollection.showsVerticalScrollIndicator = false
    
        let ccHorizontalConstraint = categoriesCollection.topAnchor.constraint(equalTo: viewForCollection.topAnchor, constant: 0)
        let ccVerticalConstraint = categoriesCollection.leftAnchor.constraint(equalTo: viewForCollection.leftAnchor, constant: 0)
        let ccRightConstraint = categoriesCollection.rightAnchor.constraint(equalTo: viewForCollection.rightAnchor, constant: 0)
        let ccBottomConstraint = categoriesCollection.bottomAnchor.constraint(equalTo: viewForCollection.bottomAnchor, constant: 0)
        
        viewForCollection.addConstraints([ccHorizontalConstraint, ccVerticalConstraint, ccRightConstraint, ccBottomConstraint])
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
    
    private func CategoriesLayout() -> UICollectionViewFlowLayout{
//        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//
//        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
//
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1),
//            heightDimension: .estimated(50)),subitems: [item])
//
//        let section = NSCollectionLayoutSection(group: group)
     
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 130, height: 40)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    }

   
