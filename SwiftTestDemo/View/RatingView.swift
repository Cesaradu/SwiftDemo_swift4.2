//
//  RatingView.swift
//  SwiftTestDemo
//
//  Created by user on 2019/3/25.
//  Copyright © 2019 adu. All rights reserved.
//

import UIKit

class RatingView: UIView {
    
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    var spacing: Int = 5
    var stars: Int = 5
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        for i in 0..<stars {
            let button = UIButton()
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchDown)
            button.setImage(UIImage(named: "emptyStar"), for: .normal)
            button.setImage(UIImage(named: "fullStar"), for: .selected)
            button.setImage(UIImage(named: "fullStar"), for: .highlighted)
            button.adjustsImageWhenHighlighted = false
            button.tag = 1000 + i
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.width - 20)/spacing
        var buttonFrame = CGRect(x: 0, y: (Int(frame.size.height) - buttonSize)/2, width: buttonSize, height: buttonSize)
        
        for i in 0..<ratingButtons.count {
            let button = ratingButtons[i]
            buttonFrame.origin.x = CGFloat(i * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
    }
    
    @objc func ratingButtonTapped(button: UIButton) {
        rating = button.tag - 1000 + 1
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for i in 0..<ratingButtons.count {
            let button = ratingButtons[i]
            button.isSelected = i < rating
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
