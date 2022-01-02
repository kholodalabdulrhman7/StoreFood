//
//  CustomerSupportVC.swift
//  StoreFood
//
//  Created by Kholod Sultan on 23/05/1443 AH.
//



import UIKit
import FirebaseFirestore

class CustomerSupportViewController: UIViewController {

    let db = Firestore.firestore()

    
    let titleTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Message Title"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.returnKeyType = UIReturnKeyType.done
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        return textField
    }()
    
    let messageTextView: UITextView = {
        let textField = UITextView()
        
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.returnKeyType = UIReturnKeyType.done
        
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        
        return textField
    }()
    
    let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupButton(with: "Send Message".localized)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white

        self.navigationController?.navigationBar.topItem?.title = "Customer Support"

        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            navigationController?.navigationBar.standardAppearance = appearance;
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        }
        
        self.navigationController?.navigationBar.isHidden = false
        
        setupViews()
    }
    
    
    func setupViews() {
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.delegate = self
        view.addSubview(titleTextField)
        
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageTextView)
        
        sendMessageButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sendMessageButton)
        
        let margins = view.layoutMarginsGuide
        
        let horizontalConstraint = titleTextField.topAnchor.constraint(equalTo: margins.topAnchor, constant: 30)
        let verticalConstraint = titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        let rightConstraint = titleTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        let heightConstraint = titleTextField.heightAnchor.constraint(equalToConstant: 45)
        
        
        let sHorizontalConstraint = messageTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20)
        let sVerticalConstraint = messageTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        let sRightConstraint = messageTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        let sHeightConstraint = messageTextView.heightAnchor.constraint(equalToConstant: 150)
        
        
        let addHorizontalConstraint = sendMessageButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -30)
        let addVerticalConstraint = sendMessageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        let addRightConstraint = sendMessageButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        let addHeightConstraint = sendMessageButton.heightAnchor.constraint(equalToConstant: 45)
        
        sendMessageButton.addTarget(self, action: #selector(sendMessageAction), for: .touchUpInside)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, rightConstraint, heightConstraint, sHorizontalConstraint, sVerticalConstraint, sRightConstraint, sHeightConstraint, addHorizontalConstraint, addVerticalConstraint, addRightConstraint, addHeightConstraint])
        
    }
    
    
    @objc func sendMessageAction() {
        self.db.collection("support").document().setData([
            "title": self.titleTextField.text ?? "",
            "message": self.messageTextView.text ?? "",
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                self.titleTextField.text = ""
                self.messageTextView.text = ""
                self.successMessage()
            }
        }
    }
    
    func successMessage() {
        let alert = UIAlertController(title: "نجاح", message: "تم ارسال الرسالة بنجاح", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: { action in
         
        }))
        self.present(alert, animated: true, completion: nil)
    }


}

extension CustomerSupportViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        titleTextField.resignFirstResponder()

        return true
    }
}
