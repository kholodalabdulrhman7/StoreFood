//
//  CollectionCell.swift
//  StoreFood
//
//  Created by Kholod Sultan on 22/05/1443 AH.
//

import UIKit
import FirebaseFirestore
import MOLH

class CollectionCell: UICollectionViewCell {
    static let ID = "CellID"
    let database = Firestore.firestore()
    
    var product: Cake?
    
    private let imageView : UIImageView = {
        let image           = UIImageView()
        
        image.contentMode   = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    private let name : UILabel = {
        let title = UILabel()
        title.textColor =  UIColor.label
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 20, weight: .medium))
        return title
    }()
    private let summary: UILabel = {
        let description = UILabel()
        description.textColor =  UIColor.secondaryLabel
        description.font  = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .regular))
        description.numberOfLines = 4
        description.translatesAutoresizingMaskIntoConstraints = false
//        description.textAlignment = .left
        return description
    }()
    
    private let price: UILabel = {
        let pr = UILabel()
        pr.textColor =  UIColor.label
        pr.font  = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .regular))
        pr.numberOfLines = 1
        pr.translatesAutoresizingMaskIntoConstraints = false

//        pr.textAlignment = .center
        return pr
    }()
    
    
    private let  cookby: UILabel = {
        let ck = UILabel()
        ck.textColor =  UIColor.secondaryLabel
        ck.font  = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .regular))
        ck.numberOfLines = 6
        ck.textAlignment = .right
        ck.translatesAutoresizingMaskIntoConstraints = false
        return ck
    }()
    
    
    let deleteBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .red
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder){fatalError("init(coder:) has not been implemented")}
    override func layoutSubviews() {
        setupSizeForCellContent()
    }
    
    func setCell(card:Cake){
        imageView.contentMode = .scaleAspectFill
        
        let url = URL(string: card.image )
        if let u = url {
            let data = try? Data(contentsOf: u)
            self.imageView.image = UIImage(data: data!)
        }
        
        
        name.text = card.name
        summary.text = card.summary
        cookby.text = card.cookby

        print("this is price: \(card.price)")
        if  card.price != "" {
            price.text = card.price + " SAR"
        } else {
            price.text = "Donate"
        }
    
    }
    private func setupSizeForCellContent() {
//        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height / 2.5)
        
//        name.frame = CGRect(x: 14, y: self.frame.size.height / 2.02, width: self.frame.size.width - 14, height: 30)
        
//        summary.frame = CGRect(x: 14, y: self.frame.size.height / 1.74, width: self.frame.size.width - 24, height: 90)
        
        
//        price.frame = CGRect(x:self.frame.size.width - 100, y: self.frame.size.height - 40, width: 100, height: 30)
//        cookby.frame = CGRect(x:20, y:self.frame.size.height / 2, width: self.frame.size.width - 30, height: 30)
        
        imageView.heightAnchor.constraint(equalToConstant: self.frame.size.height / 2.5).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: self.frame.size.width).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true

        name.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14).isActive = true
//        name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 14).isActive = true

        summary.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
        summary.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14).isActive = true
//        summary.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 14).isActive = true
        
        cookby.topAnchor.constraint(equalTo: summary.bottomAnchor, constant: 10).isActive = true
        cookby.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14).isActive = true
//        cookby.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 14).isActive = true
        
        price.topAnchor.constraint(equalTo: cookby.bottomAnchor, constant: 10).isActive = true
//        price.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14).isActive = true
        price.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14).isActive = true
        

    }
    
    private func setupCell() {
        self.backgroundColor = .systemBackground
        self.addSubview(imageView)
        self.addSubview(name)
        self.addSubview(summary)
        self.addSubview(price)
        self.addSubview(cookby)
        self.layer.cornerRadius = 13
        self.layer.masksToBounds = true
        self.addSubview(self.deleteBtn)
        self.deleteBtn.frame = CGRect(x: MOLHLanguage.isArabic() ? self.frame.size.width - 30 : 20, y:self.frame.size.height - 50, width: 20, height: 25)
        self.deleteBtn.isHidden = true

        
        getCurrentUserFromFirestore { type in
            print("the user type is \(type)")
            if type == "1" {
                self.deleteBtn.isHidden = false
            }
        }
    }
    
    
    
  
    
}
extension UIView {
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}

