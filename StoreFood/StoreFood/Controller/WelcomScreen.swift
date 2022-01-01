//
//  ViewController.swift
//  StoreFood
//
//  Created by Kholod Sultan on 19/05/1443 AH.
//

import UIKit
import FirebaseAuth

class WelcomeScreen: UIViewController {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(#colorLiteral(red: 0.6816496253, green: 0.8040371537, blue: 0.8295541406, alpha: 1))
        view.layer.borderWidth = 0.25
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    let illustrationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Cake1")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 30
        return image
    }()
    
    let titleLabel: UILabel = {
      let title = UILabel()
        title.backgroundColor = .clear
        title.text = NSLocalizedString( "Welcome", comment: "")
        title.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        title.textColor = .black
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    let subTitle: UILabel = {
      let subTitle = UILabel()
        subTitle.backgroundColor = .clear
        subTitle.text = NSLocalizedString("share your moments with one pices Cake🧁", comment: "")
        subTitle.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        subTitle.textColor = UIColor( #colorLiteral(red: 0.05837889761, green: 0.04676074535, blue: 0.0519445911, alpha: 1))
        subTitle.textAlignment = .center
        subTitle.numberOfLines = 0
        return subTitle
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupButton(with: NSLocalizedString("Sign up", comment: ""))
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupButton(with:NSLocalizedString("Log in", comment: ""))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor (#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) )
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        if isUserSignedIn() {
            self.dismiss(animated: true, completion: nil)
        }
       
    }
    
    private func setupViews() {
        
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints                                                     = false
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                                = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive                                = true
        containerView.widthAnchor.constraint(equalToConstant: 325).isActive                                         = true
        containerView.heightAnchor.constraint(equalToConstant: 395).isActive                                        = true
        
        
        let vStack = UIStackView(arrangedSubviews: [signInButton, loginButton])
        containerView.addSubview(vStack)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.distribution = .fillEqually
        vStack.spacing      = 10
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive                 = true
        vStack.heightAnchor.constraint(equalToConstant: 40).isActive                                                = true
        vStack.widthAnchor.constraint(equalToConstant: 190).isActive                                                = true
        vStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive            = true
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        
        containerView.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints                                                          = false
        subTitle.bottomAnchor.constraint(equalTo: vStack.topAnchor, constant: -30).isActive                         = true
        subTitle.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive                            = true
        subTitle.widthAnchor.constraint(equalToConstant: 305).isActive                                              = true
        
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints                                                        = false
        titleLabel.bottomAnchor.constraint(equalTo: subTitle.topAnchor, constant: -40).isActive                     = true
        titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive                          = true
        
        
        containerView.addSubview(illustrationImage)
        illustrationImage.translatesAutoresizingMaskIntoConstraints = false
        illustrationImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -30).isActive             = true
        illustrationImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive     = true
        illustrationImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive  = true
        illustrationImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15).isActive             = true
        
    }
    
    @objc private func loginButtonTapped() {
        navigationController?.pushViewController(LoginScreen(), animated: true)
    }
    @objc private func signInButtonTapped() {
        navigationController?.pushViewController(SignupScreen(), animated: true)
    }
    private func isUserSignedIn() -> Bool {
      return Auth.auth().currentUser != nil
    }
}

extension String {
    func locaz() -> String {
        return NSLocalizedString(self, tableName: "localized", bundle: .main, value: self, comment: self)
    }
    
    
}




