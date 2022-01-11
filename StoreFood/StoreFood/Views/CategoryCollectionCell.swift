//
//  CategoryCollectionCell.swift
//  StoreFood
//
//  Created by Kholod Sultan on 22/05/1443 AH.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    static let ID = "categoriesCollectionCell"
    
    private let imageView : UIImageView = {
        let image           = UIImageView()
        
        image.contentMode   = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    private let name : UILabel = {
        let title = UILabel()
        title.textColor =  UIColor.label
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 15, weight: .regular))
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupSizeForCellContent()
    }
    
    required init?(coder: NSCoder){fatalError("init(coder:) has not been implemented")}
    
    override func layoutSubviews() {
        setupSizeForCellContent()
    }
    
    func sertCell(category: Category) {
        
        let url = URL(string: category.image )
        if let u = url {
            let data = try? Data(contentsOf: u)
            self.imageView.image = UIImage(data: data!)
        }
        
        name.text = category.name
    }
    
    
    private func setupCell() {
        self.backgroundColor = .systemBackground
        self.contentView.backgroundColor = .systemBackground
        self.addSubview(imageView)
        self.addSubview(name)
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
    
    private func setupSizeForCellContent() {
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        imageView.layer.cornerRadius = 15


        name.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 5).isActive = true
    }
    
}
