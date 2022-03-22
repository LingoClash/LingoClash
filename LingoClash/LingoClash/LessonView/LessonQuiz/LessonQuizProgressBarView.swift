//
//  LessonQuizProgressBarView.swift
//  LingoClash
//
//  Created by Sherwin Poh on 21/3/22.
//

import UIKit

class LessonQuizProgressBarView: UIProgressView {
    private let starImage = #imageLiteral(resourceName: "Image")
    func addStarView(at position: Float) {
        print(position)
        let starView = getStarView(at: position)
        addSubview(starView)
    }
    
    private func getStarView(at position: Float) -> UIImageView {
        let starImageView = UIImageView(image: self.starImage)
        let height:CGFloat = 30
        let width = height
        let xPosition = (CGFloat(position) * frame.width) - width / 2
        let yPosition:CGFloat = -15
        starImageView.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        return starImageView
    }
}
