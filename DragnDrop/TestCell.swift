//
//  TestCell.swift
//  DragnDrop
//
//  Created by QuyetBH on 11/10/2022.
//

import UIKit

class TestCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var xIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.colorView.layer.cornerRadius = 6
        self.colorView.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: 2, blur: 6, spread: 0)
    }
    
    override func dragStateDidChange(_ dragState: UICollectionViewCell.DragState) {
        super.dragStateDidChange(dragState)
        print("#### dragStateDidChange", dragState.rawValue)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alpha: CGFloat = dragState == .none ? 1 : 0
            self.label.alpha = alpha
            self.xIcon.alpha = alpha
        }
    }
    
}

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
