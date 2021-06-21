//
//  HeaderView.swift
//  pantipTest
//
//  Created by somsak on 11/6/2564 BE.
//

import UIKit

class HeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib(){
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func configView(text: String){
        self.titleLabel.text = text
    }

}
