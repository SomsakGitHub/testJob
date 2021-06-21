//
//  ViewController.swift
//  DTCTest
//
//  Created by somsak on 16/6/2564 BE.
//

import UIKit

class ViewController: BaseViewController {
    
    @IBOutlet var usernameTextField: placeHolderTextField!
    @IBOutlet var passwordTextField: placeHolderTextField!
    
    var userCoreData = UserCoreData()
    var userEntityArray: UserEntity? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.dismissKeyboardOnView()
    }

    @IBAction func loginTouch(_ sender: Any) {
        
        if usernameTextField.text == "" || passwordTextField.text == ""{
            self.alertOneAction(title: "กรุณากรอกให้ครบ") {(isCompletion) in
                
            }
        }else{
            
            var dataArray: [String] = []
            dataArray.append(usernameTextField.text!)
            dataArray.append(passwordTextField.text!)
            checkLogin(data: dataArray)
        }
    }
    
    @IBAction func registerTouch(_ sender: Any) {
        self.performSegue(withIdentifier: "goToRegister", sender: self)
    }
    
    //MARK: Pass data with segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? DetailViewController {
            detailViewController.userEntityArray = self.userEntityArray
        }
    }
    
    func checkLogin(data: [String]){
        
        let datafetchUserEntity = userCoreData.fetchUserEntity()
        print("datafetchUserEntity", datafetchUserEntity)
        
        let username = datafetchUserEntity.filter { (userEntity) -> Bool in
            return userEntity.username == data[0]
        }
        
        print("username", username)
        
        if username.count > 0{
            if username[0].password == data[1] {
                self.userEntityArray = username[0]
                self.alertOneAction(title: "ยินดีต้อนรับ \(username[0].name!)") {(isCompletion) in
                    if isCompletion {
                        self.performSegue(withIdentifier: "goToDetail", sender: self)
                    }
                }
            }else{
                dataNotFound()
            }
        }else{
            dataNotFound()
        }
    }
    
    func dataNotFound(){
        self.alertTwoAction(title: "ไม่พบข้อมูลผู้ใช้ในระบบ", message: "กรุณาสมัครสมาชิก หรือ ติดต่อผู้ดูแลระบบ") {(isLink) in
            if isLink {
                self.performSegue(withIdentifier: "goToRegister", sender: self)
            }else{
                guard let number = URL(string: "tel://" + "1176") else { return }
                    UIApplication.shared.open(number)
            }
        }
    }
}

