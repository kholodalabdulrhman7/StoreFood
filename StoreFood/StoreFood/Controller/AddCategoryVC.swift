//
//  AddCategoryVC.swift
//  StoreFood
//
//  Created by Kholod Sultan on 25/05/1443 AH.
//



import UIKit
import FirebaseFirestore
import FirebaseStorage

class AddCategoryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let db = Firestore.firestore()

    
    //imagePicker For category image
    lazy var imagePicker : UIImagePickerController = {
       let imagePicker = UIImagePickerController()
       imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
       imagePicker.allowsEditing = true
       return imagePicker
   }()
    
    
    // category image
    lazy var productImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        return view
    }()
    
    
    // Category name
    let nameTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Category name"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.returnKeyType = UIReturnKeyType.done
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        return textField
    }()
    
    // add category
    let addCategoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupButton(with: "Add Category".localized)
        return button
    }()
    
    let selectImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupButton(with: "Select Image".localized)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.systemGray6
        self.navigationController?.navigationBar.topItem?.title = "Add New Category"

        setupViews()
    }
    
    
    func setupViews() {
        
        productImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(productImage)
        
        selectImageButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectImageButton)
        
        addCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addCategoryButton)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.delegate = self
        view.addSubview(nameTextField)
        
        
        let margins = view.layoutMarginsGuide
        
        let horizontalConstraint = nameTextField.topAnchor.constraint(equalTo: margins.topAnchor, constant: 30)
        let verticalConstraint = nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        let rightConstraint = nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        let heightConstraint = nameTextField.heightAnchor.constraint(equalToConstant: 45)
        
        
        
        let sHorizontalConstraint = selectImageButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30)
        let sVerticalConstraint = selectImageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        let sRightConstraint = selectImageButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        let sHeightConstraint = selectImageButton.heightAnchor.constraint(equalToConstant: 45)
    
        selectImageButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        
        
        let iHorizontalConstraint = productImage.topAnchor.constraint(equalTo: selectImageButton.bottomAnchor, constant: 30)
        let iVerticalConstraint = productImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50)
        let iRightConstraint = productImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        let iHeightConstraint = productImage.heightAnchor.constraint(equalToConstant: 200)
        
        
        let addHorizontalConstraint = addCategoryButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -30)
        let addVerticalConstraint = addCategoryButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        let addRightConstraint = addCategoryButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        let addHeightConstraint = addCategoryButton.heightAnchor.constraint(equalToConstant: 45)
        
        addCategoryButton.addTarget(self, action: #selector(addCategoryAction), for: .touchUpInside)

        
        
        view.addConstraints([horizontalConstraint, verticalConstraint, rightConstraint, heightConstraint, sHorizontalConstraint, sVerticalConstraint, sRightConstraint, sHeightConstraint,  addRightConstraint, addHeightConstraint, addVerticalConstraint, addHorizontalConstraint, iRightConstraint, iHeightConstraint, iVerticalConstraint, iHorizontalConstraint,])
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      let image = info[.editedImage] ?? info[.originalImage] as? UIImage
        productImage.image = image as? UIImage
      dismiss(animated: true)
    }
    
    
    @objc func addImage() {
        present(imagePicker, animated: true)
    }
    
    
    @objc func addCategoryAction() {
        
        uploadImage(image: self.productImage.image ?? UIImage()) { url in
            let ref = self.db.collection("categories").document().documentID

            self.db.collection("categories").document(ref).setData([
                "name": self.nameTextField.text ?? "",
                "uid": ref,
                "image": url ?? "",
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    self.successMessage()
                }
            }

        }
    }
    
    func successMessage() {
        let alert = UIAlertController(title: "نجاح", message: "تم اضافة التصنيف بنجاح", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: { action in
         
        }))
        self.present(alert, animated: true, completion: nil)
    }
    


}

extension AddCategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()

        return true
    }
}
