//
//  CategoryCollectionCell.swift
//  StoreFood
//
//  Created by Kholod Sultan on 22/05/1443 AH.
//

import UIKit


class CategoriesCollectionViewCell:UICollectionViewCell {
    static let ID = "categoriesCollectionCell"
    
    private let imageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    private let name :UILabel = {
        let title = UILabel ()
        title.textColor = UIColor.label
        title.font = UIFontMetrics.default.scaledFont(for:UIFont.systemFont(ofSize: 15, weight: .regular))
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")}
    override func layoutSubviews() {
        setupSizeForCellContent()
    }
    func sertCell(category:Category) {
        imageView.image = category.image
        name.text = category.name
    }
    private func setupCell (){
        self.backgroundColor = .white
        self.addSubview(imageView)
        self.addSubview(name)
        self.layer.cornerRadius = 13
        self.layer.masksToBounds = true
    }
    private func  setupSizeForCellContent() {
        imageView.frame = CGRect(x: 10, y: (self.frame.size.height / 2) - 15, width: 30, height: 30)
        imageView.layer.cornerRadius = 15
        
        name.frame = CGRect(x: 48, y:  (self.frame.size.height / 2) - 7, width: self.frame.size.width - 14, height: 15)
        
    }
    
}
    


