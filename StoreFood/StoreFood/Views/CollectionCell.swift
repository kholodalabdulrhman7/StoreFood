//
//  CollectionCell.swift
//  StoreFood
//
//  Created by Kholod Sultan on 22/05/1443 AH.
//

import UIKit
import FirebaseFirestore

class CollectionCell: UICollectionViewCell {
    static let ID = "CellID"
    let database = Firestore.firestore()
    
    var product: Cake?
    
    private let imageView : UIImageView = {
        let image           = UIImageView()
        
        image.contentMode   = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private let name : UILabel = {
        let title = UILabel()
        title.textColor =  UIColor.label
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 20, weight: .medium))
        return title
    }()
    private let summary: UILabel = {
        let description = UILabel()
        description.textColor =  UIColor.secondaryLabel
        description.font  = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .regular))
        description.numberOfLines = 4
        description.textAlignment = .left
        return description
    }()
    
    private let price: UILabel = {
        let pr = UILabel()
        pr.textColor =  UIColor.black
        pr.font  = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .regular))
        pr.numberOfLines = 1
        pr.textAlignment = .center
        return pr
    }()
    
    
    private let  cookby: UILabel = {
        let ck = UILabel()
        ck.textColor =  UIColor.secondaryLabel
        ck.font  = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .regular))
        ck.numberOfLines = 6
        ck.textAlignment = .right
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
        price.text = card.price + " SAR"
        cookby.text = card.cookby
        
        
    }
    private func setupSizeForCellContent() {
        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height / 2.5)
        
        name.frame = CGRect(x: 14, y: self.frame.size.height / 2.02, width: self.frame.size.width - 14, height: 30)
        
        summary.frame = CGRect(x: 14, y: self.frame.size.height / 1.74, width: self.frame.size.width - 24, height: 90)
        price.frame = CGRect(x:self.frame.size.width - 100, y: self.frame.size.height - 40, width: 100, height: 30)
        cookby.frame = CGRect(x:20, y:self.frame.size.height / 2, width: self.frame.size.width - 30, height: 30)
        
        
        
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
        self.deleteBtn.frame = CGRect(x:20, y:self.frame.size.height - 40, width: 20, height: 25)
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




