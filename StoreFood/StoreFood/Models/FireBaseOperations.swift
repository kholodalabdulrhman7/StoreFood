//
//  FireBaseOperations.swift
//  StoreFood
//
//  Created by Kholod Sultan on 22/05/1443 AH.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth


let db = Firestore.firestore()

func getCurrentUserFromFirestore(completion: @escaping(String)->()) {
   let docRef = db.collection("profiles").document(Auth.auth().currentUser?.uid ?? "")
    
    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
          
            let type = document.get("type") as? String
            
            print(type ?? "")
            
            completion(type ?? "0")
        } else {
            print("Document does not exist")
        }
    }
}

func uploadImage(image: UIImage, completion: @escaping (_ url: String?) -> Void) {
    let storageRef = Storage.storage().reference().child("img\(Date().millisecondsSince1970).png")
    if let uploadData = image.jpegData(compressionQuality: 0.6){
        storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
            if error != nil {
                print("error")
                completion(nil)
            } else {
                
                storageRef.downloadURL(completion: { (url, error) in
                    
                    print(url?.absoluteString)
                    completion(url?.absoluteString)
                })
            }
        }
    }
}

//func addCategory(image: UIImage, categoryName: String ) {
//
//    uploadImage(image: image) { url in
//
//        db.collection("categories").document().setData([
//            "name": categoryName,
//            "url": url,
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//              //  self.successMessage()
//            }
//        }
//
//    }
//
//}


