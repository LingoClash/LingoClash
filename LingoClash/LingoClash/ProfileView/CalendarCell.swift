//
//  CalendarCell.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 21/4/22.
//

import Foundation
import UIKit
import FSCalendar

class CalendarCell: FSCalendarCell {
    
    weak var circleImageView: UIImageView!
    weak var selectionLayer: CAShapeLayer!
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundView?.frame = self.bounds.insetBy(dx: 1, dy: 1)
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        if self.isPlaceholder {
            self.titleLabel.textColor = UIColor.lightGray
        }
    }
    
}
