//
//  DetialsVC.swift
//  StoreFood
//
//  Created by Kholod Sultan on 22/05/1443 AH.
//
import UIKit
import FirebaseFirestore
import FirebaseAuth

class DetailVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
        
    var cake: Cake?
    let db = Firestore.firestore()

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TabelViewCell.cell, for: indexPath) as! TabelViewCell
        
        cell.cakeImage.image = UIImage(named: "1") ?? UIImage()
        cell.CakeName.text = "name"
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return allimage.count
     
    }
    
    
    
    let TableView : UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(TabelViewCell.self, forCellReuseIdentifier: TabelViewCell.cell)
            $0.translatesAutoresizingMaskIntoConstraints = false
            // set object properties
            return $0
        }(UITableView())
    
    let cakeImage : UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true

      return img
    }()
    
    private let name : UILabel = {
        let title = UILabel()
        title.textColor     =  UIColor.label
        title.font          = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 27, weight: .bold))
        return title
    }()
    
    
    private let summary: UILabel = {
        let description             = UILabel()
        description.textColor       =  UIColor.secondaryLabel
        description.font            = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .regular))
        description.numberOfLines   = 4
        description.textAlignment   = .left
        return description
    }()
    
    private let addToCartButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.systemCyan
        btn.setTitle("اضافة الى السلة", for: .normal)
        
        return btn
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        view.addSubview(TableView)
        view.addSubview(cakeImage)
        view.addSubview(name)
        view.addSubview(summary)
        view.addSubview(addToCartButton)

        view.backgroundColor = .white
//        cakeImage.image = UIImage(named: cake?.image ?? "") ?? UIImage()
        
        let url = URL(string: cake?.image ?? "" )
        if let u = url {
            let data = try? Data(contentsOf: u)
            self.cakeImage.image = UIImage(data: data!)
        }
        
        name.text = cake?.name
        summary.text = cake?.summary
        
//        TableView.backgroundColor = .red
//        TableView.register(TabelViewCell.self, forCellReuseIdentifier: TabelViewCell.cell)

        NSLayoutConstraint.activate([
//            TableView.topAnchor.constraint(equalTo: view.topAnchor, constant:0),
//            TableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:0),
//            TableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant:0),
//            TableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant:0),
            
        ])
        
        let margins = view.layoutMarginsGuide

        cakeImage.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = cakeImage.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0)
        let verticalConstraint = cakeImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        let widthConstraint = cakeImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        let heightConstraint = cakeImage.heightAnchor.constraint(equalToConstant: 300)

        
        
        name.translatesAutoresizingMaskIntoConstraints = false
        let nhorizontalConstraint = name.topAnchor.constraint(equalTo: cakeImage.bottomAnchor, constant: 20)
        let nverticalConstraint = name.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        let nwidthConstraint = name.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        
        summary.translatesAutoresizingMaskIntoConstraints = false
        let shorizontalConstraint = summary.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20)
        let sverticalConstraint = summary.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        let swidthConstraint = summary.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
        let ahorizontalConstraint = addToCartButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -40)
        let averticalConstraint = addToCartButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35)
        let awidthConstraint = addToCartButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35)
        
        view.addConstraints([nhorizontalConstraint, nverticalConstraint, nwidthConstraint, horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint, shorizontalConstraint, sverticalConstraint, swidthConstraint, ahorizontalConstraint, averticalConstraint, awidthConstraint])
        
//        setupTableView()
    }
    
    @objc func addToCartAction() {
        let alert = UIAlertController(title: "نجاح", message: "تم اضافة طلبك بنجاح، سيتم تسليم الطلب خلال ساعتين", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: { action in
            cartArr.append(self.cake!)
            self.addProductToCart()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        TableView.frame = view.bounds
      }
      private func setupTableView() {
          TableView.delegate = self
          TableView.dataSource = self
          TableView.rowHeight = 150
      }
    
    
    func addProductToCart() {
        self.db.collection("cart").document().setData([
            "userId": Auth.auth().currentUser?.uid ?? "",
            "productId": cake?.uid ?? "",
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                
            }
        }
    }
    
    
     
    
}
