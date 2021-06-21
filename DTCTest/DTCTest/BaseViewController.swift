//
//  BaseViewController.swift
//  DTCTest
//
//  Created by somsak on 20/6/2564 BE.
//

import UIKit

class BaseViewController: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func alertOneAction(title: String, completion:@escaping (Bool) -> Void){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (handler) in
            completion(true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertTwoAction(title: String, message: String, completion:@escaping (Bool) -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "สมัครสมาชิก", style: UIAlertAction.Style.cancel, handler: { (handler) in
            completion(true)
        }))
        alert.addAction(UIAlertAction(title: "ติดต่อผู้ดูแลระบบ", style: UIAlertAction.Style.default, handler: { (handler) in
            completion(false)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func startAnimating() {
        strLabel = UILabel(frame: CGRect(x: 55, y: 0, width: 400, height: 66))
        strLabel.text = "Please wait."
        strLabel.font = UIFont(name: "Apple Color Emoji", size: 12)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 170, height: 66)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        // Set up its size (the super view bounds usually)
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 66, height: 66)
        // Start the loading animation
        self.activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(self.activityIndicator)
        effectView.contentView.addSubview(strLabel)
        self.activityIndicator.transform = CGAffineTransform(scaleX: 1.4, y: 1.4);
        effectView.center = view.center
        
        // Add it to the view where you want it to appear
        view.addSubview(effectView)
    }
    
    func stopAnimating() {
        strLabel.removeFromSuperview()
        effectView.removeFromSuperview()
                
        // To remove it, just call removeFromSuperview()
        activityIndicator.removeFromSuperview()
    }
    
    func dismissKeyboardOnView(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
