//
//  BorderedStackView.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 21/11/2020.
//

import UIKit

final class BorderedStackView: UIStackView {
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        let layer = self.layer as! CAShapeLayer
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.bottomLeft, .bottomRight] ,
                                cornerRadii: CGSize(width: 20, height: 20))
        layer.path = path.cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.white.cgColor
        layer.lineWidth = 0.2
    }
}
