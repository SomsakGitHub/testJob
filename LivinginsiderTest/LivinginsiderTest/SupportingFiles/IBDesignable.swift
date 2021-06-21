//
//  IBDesignable.swift
//  LivinginsiderTest
//
//  Created by somsak on 17/6/2564 BE.
//

import UIKit

@IBDesignable class ViewRound : UIView {
    @IBInspectable var CornerRadius:CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = CornerRadius
        }
    }
    
    @IBInspectable var ShadowRadius:CGFloat = 0.0 {
        didSet {
            layer.shadowRadius = ShadowRadius
            layer.shadowOpacity = 1
            layer.shadowOffset = .zero
  
            
        }
    }
    
    @IBInspectable var ShadowColor:UIColor = .black {
        didSet {
            layer.shadowColor = ShadowColor.cgColor
        }
    }
}

@IBDesignable
public class RoundedView: UIView {

    @IBInspectable public var topLeft: Bool = false      { didSet { setNeedsLayout() } }
    @IBInspectable public var topRight: Bool = false     { didSet { setNeedsLayout() } }
    @IBInspectable public var bottomLeft: Bool = false   { didSet { setNeedsLayout() } }
    @IBInspectable public var bottomRight: Bool = false  { didSet { setNeedsLayout() } }
    @IBInspectable public var cornerRadius: CGFloat = 0  { didSet { setNeedsLayout() } }

    public override func layoutSubviews() {
        super.layoutSubviews()

        var options = UIRectCorner()

        if topLeft     { options.formUnion(.topLeft) }
        if topRight    { options.formUnion(.topRight) }
        if bottomLeft  { options.formUnion(.bottomLeft) }
        if bottomRight { options.formUnion(.bottomRight) }

        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: options,
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))

        let maskLayer = CAShapeLayer()

        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}

@IBDesignable
class RoundView: UIImageView {

    @IBInspectable var cornerRadius : CGFloat = 0.0{
        didSet{
            self.applyCornerRadius()
        }
    }

    @IBInspectable var borderColor : UIColor = UIColor.clear{
        didSet{
            self.applyCornerRadius()
        }
    }

    @IBInspectable var borderWidth : Double = 0{
        didSet{
            self.applyCornerRadius()
        }
    }

    @IBInspectable var circular : Bool = false{
        didSet{
            self.applyCornerRadius()
        }
    }

    func applyCornerRadius()
    {
        if(self.circular) {
            self.layer.cornerRadius = self.bounds.size.height/2
            self.layer.masksToBounds = true
            self.layer.borderColor = self.borderColor.cgColor
            self.layer.borderWidth = CGFloat(self.borderWidth)
        }else {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
            self.layer.borderColor = self.borderColor.cgColor
            self.layer.borderWidth = CGFloat(self.borderWidth)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyCornerRadius()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyCornerRadius()
    }

}
