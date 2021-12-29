//
//  TVCell.swift
//  StoreFood
//
//  Created by Kholod Sultan on 22/05/1443 AH.
//

import UIKit

class TabelViewCell: UITableViewCell {
    static let cell = "Cell1"
    
    let cakeImage : UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.image = UIImage(named: "4")!.withConfiguration(UIImage.SymbolConfiguration(pointSize: 9, weight: .bold, scale: .medium))
      return img
    }()
    let CakeName: UILabel = {
        let CN = UILabel()
        CN.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        CN.textAlignment = .center
        CN.textColor = .black
        return CN
    }()
    
    let discrptionCake: UILabel = {
        let cd = UILabel()
        cd.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        cd.textAlignment = .center
        cd.textColor = .black
        return cd
       
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        self.addSubview(cakeImage)
        self.addSubview(CakeName)
        self.addSubview(discrptionCake)

        cakeImage.translatesAutoresizingMaskIntoConstraints = false
        cakeImage.bottomAnchor.constraint(equalTo:CakeName.bottomAnchor, constant: -5).isActive = true
        cakeImage.leadingAnchor.constraint(equalTo: CakeName.leadingAnchor, constant: 20).isActive = true
        cakeImage.topAnchor.constraint(equalTo:CakeName.topAnchor, constant: 20).isActive = true
        cakeImage.trailingAnchor.constraint(equalTo: CakeName.trailingAnchor, constant: -20).isActive = true
        
       CakeName.translatesAutoresizingMaskIntoConstraints = false
        CakeName.bottomAnchor.constraint(equalTo: discrptionCake.bottomAnchor, constant: -10).isActive = true
        CakeName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -10).isActive = true
        CakeName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        
        discrptionCake.translatesAutoresizingMaskIntoConstraints = false
        discrptionCake.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        discrptionCake.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -10).isActive = true
        
    }
    
    
    
    
}

