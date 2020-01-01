/*
 This is a UIView class that contains
 a title view. It is used for the
 settings section view.
 
 Copyright © 2019 Nikolas Ioannou. All rights reserved.
*/

import UIKit

class TitleSectionView: UIView {
    
    // MARK: - Init
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    /*
     This is init method for this view.
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Add subviews
        self.addSubview(titleLabel)
        // Constraints
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
    }
    
    /*
     This is a required init method handling
     edge cases.
    */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
