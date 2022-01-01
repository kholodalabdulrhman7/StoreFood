//
//  ProfileVC.swift
//  StoreFood
//
//  Created by Kholod Sultan on 20/05/1443 AH.
//

import FirebaseAuth
import FirebaseFirestore
import Firebase
import FirebaseStorage

class ProfileScreen: UIViewController {
    let db = Firestore.firestore()
    let imagePicker = UIImagePickerController()
    let storage = Storage.storage()

    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(#colorLiteral(red: 0.6816496253, green: 0.8040371537, blue: 0.8295541406, alpha: 1))
        view.layer.borderWidth = 0.25
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    let profileImage: UIImageView = {
        let pI = UIImageView()
        pI.contentMode = .scaleAspectFill
        pI.clipsToBounds = true
        pI.layer.cornerRadius = 80
        pI.layer.borderColor = UIColor.white.cgColor
        pI.layer.borderWidth = 1
        return pI
    }()
    
    let userNameLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        name.textColor = UIColor(#colorLiteral(red: 0.1595600843, green: 0.810018003, blue: 0.7768369317, alpha: 1))
        name.textAlignment = .center
        
        return name
    }()
    
   

    
    let signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupButton(with: "Sign out")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //UIColor( #colorLiteral(red: 1, green: 0.8937570453, blue: 0.9861807227, alpha: 1) )
        
        title = "Profile"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            navigationController?.navigationBar.standardAppearance = appearance;
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        }
        
        self.navigationController?.navigationBar.isHidden = false

        setUpLabels()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchCurrentUsers()
        readImageFromFirestore()


    }
    
    
    func setUpLabels() {
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                                = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive                                = true
        containerView.widthAnchor.constraint(equalToConstant: 325).isActive                                         = true
        containerView.heightAnchor.constraint(equalToConstant: 375).isActive                                        = true
        
        profileImage.tintColor  = .white
        profileImage.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImage.addGestureRecognizer(tapRecognizer)
        
        containerView.addSubview(profileImage)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 160).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 160).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(userNameLabel)
        userNameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20).isActive = true
        userNameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        containerView.addSubview(signOutButton)
        
      
        containerView.addSubview(signOutButton)
        
        signOutButton.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 20).isActive = true
        signOutButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        signOutButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        signOutButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
    }
    
    @objc func signOutButtonTapped() {
        guard let currentUser = Auth.auth().currentUser else {return}
        db.collection("Profiles").document(currentUser.uid).setData([
            "status": "no",
        ], merge: true) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                try? Auth.auth().signOut()
                self.dismiss(animated: true, completion: nil)
                print("ChangedUserStatus")
            }
        }
    }
    func setupImagePicker() {
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    @objc func imageTapped() {
        print("Image tapped")
        setupImagePicker()
    }
    
    func saveImageToFirestore(url: String, userId: String) {
        
        db.collection("profiles").document(userId).setData([
            "userImageURL": url,
        ], merge: true) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }

    private func readImageFromFirestore(){
        guard let currentUser = Auth.auth().currentUser else {return}
        print(currentUser.email)
        db.collection("profiles").whereField("email", isEqualTo: String(currentUser.email!))
            .addSnapshotListener { (querySnapshot, error) in
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {

                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()

                            if let imageURL = data["userImageURL"] as? String
                            {

                                let httpsReference = self.storage.reference(forURL: imageURL)


                                httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                                    if let error = error {

                                        print("ERROR GETTING DATA \(error.localizedDescription)")
                                    } else {


                                        DispatchQueue.main.async {
                                            self.profileImage.image = UIImage(data: data!)
                                        }

                                    }
                                }

                            } else {

                                print("error converting data")
                                DispatchQueue.main.async {
                                    self.profileImage.image = UIImage(systemName: "person.fill.badge.plus")
                                }

                            }


                        }
                    }
                }
            }
    }



    private func fetchCurrentUsers() {
        guard let currentUserName = FirebaseAuth.Auth.auth().currentUser else {return}
        db.collection("Profiles").whereField("email", isEqualTo: String(currentUserName.email!))
            .addSnapshotListener { (querySnapshot, error) in

                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let userName = data["name"] as? String,
                               let userIsOnline = data["status"] as? String,
                               let userEmail = data["email"] as? String
                            {


                                DispatchQueue.main.async {
//                                 b
                                }


                            }
                        }
                    }
                }

            }
    }

}



extension ProfileScreen: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        
        guard let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        guard let d: Data = userPickedImage.jpegData(compressionQuality: 0.5) else { return }
        let img = info[.editedImage] ?? info[.originalImage] as? UIImage
        self.profileImage.image = img as? UIImage
        guard let currentUser = Auth.auth().currentUser else {return}
        
        
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        let ref = storage.reference().child("UserProfileImages/\(currentUser.email!)/\(currentUser.uid).jpg")
        
        ref.putData(d, metadata: metadata) { (metadata, error) in
            if error == nil {
                ref.downloadURL(completion: { (url, error) in
                    self.saveImageToFirestore(url: "\(url!)", userId: currentUser.uid)
                    
                })
            }else{
                print("error \(String(describing: error))")
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
}



