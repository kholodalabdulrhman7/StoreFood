//
//  MenuTableVC.swift
//  StoreFood
//
//  Created by Kholod Sultan on 24/05/1443 AH.
//
import UIKit

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
        self.backgroundColor = .white
        self.addSubview(menuImageView)
        self.addSubview(name)
        self.addSubview(arrowImageView)
        self.addSubview(detailsLbl)
    }
    
    
    private func setupSizeForCellContent() {
        menuImageView.frame = CGRect(x: 10, y: (self.frame.size.height / 2) - 17.5, width: 35, height: 35)

        name.frame = CGRect(x: 58, y:  (self.frame.size.height / 2) - 7, width: self.frame.size.width - 14, height: 15)
        
        arrowImageView.frame = CGRect(x: self.frame.size.width - 20 , y: (self.frame.size.height / 2) - 8, width: 8, height: 16)

        detailsLbl.frame = CGRect(x: self.frame.size.width - 85, y:  (self.frame.size.height / 2) - 7, width: 70, height: 15)

    }

}
