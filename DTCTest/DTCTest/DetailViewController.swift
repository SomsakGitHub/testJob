//
//  DetailViewController.swift
//  DTCTest
//
//  Created by somsak on 19/6/2564 BE.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var sernameLabel: UILabel!
    @IBOutlet var idCardLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var userImageView: UIImageView!
    
    var userEntityArray: UserEntity? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameLabel.text = "username: \(userEntityArray?.username ?? "")"
        passwordLabel.text = "password: \(userEntityArray?.password ?? "")"
        nameLabel.text = "ชื่อผู้ใช้: \(userEntityArray?.name ?? "")"
        sernameLabel.text = "นามสกุล: \(userEntityArray?.sername ?? "")"
        idCardLabel.text = "เลขบัตรประชาชน: \(userEntityArray?.idCard ?? "")"
        phoneLabel.text = "เบอร์ติดต่อ: \(userEntityArray?.phone ?? "")"
        userImageView.image = UIImage(data: (userEntityArray?.image)!) 
    }
}
