//
//  MenuTableVC.swift
//  StoreFood
//
//  Created by Kholod Sultan on 24/05/1443 AH.
//


import UIKit
import MOLH

class MenuTableViewCell: UITableViewCell {

    
    let menuImageView : UIImageView = {
        let image           = UIImageView()
        
        image.contentMode   = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let arrowImageView : UIImageView = {
        let image           = UIImageView()
        
        image.contentMode   = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "next")!
        return image
    }()
    
    let name : UILabel = {
        let title = UILabel()
        title.textColor =  UIColor.label
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 15, weight: .regular))
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let detailsLbl : UILabel = {
        let title = UILabel()
        title.textColor =  UIColor( #colorLiteral(red: 0.1595600843, green: 0.810018003, blue: 0.7768369317, alpha: 1) )
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 13, weight: .medium))
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        return title
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        setupSizeForCellContent()
    }
    
    func setCell(category: Category) {
        
        let url = URL(string: category.image )
        if let u = url {
            let data = try? Data(contentsOf: u)
            self.menuImageView.image = UIImage(data: data!)
        }
        
        name.text = category.name
    }
    
    
    private func setupCell() {
        self.selectionStyle = .none
        self.backgroundColor = .systemBackground
        self.addSubview(menuImageView)
        self.addSubview(name)
        self.addSubview(arrowImageView)
        self.addSubview(detailsLbl)
    }
    
    
    private func setupSizeForCellContent() {    
        menuImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        menuImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        menuImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        menuImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        
        name.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: self.menuImageView.trailingAnchor, constant: 10).isActive = true


        arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        arrowImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        if MOLHLanguage.isArabic() {
           let img = arrowImageView.image?.flipIfNeeded()
            self.arrowImageView.image = img
        }
        
        detailsLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        detailsLbl.trailingAnchor.constraint(equalTo: self.arrowImageView.leadingAnchor, constant: -10).isActive = true

        
    }

}
