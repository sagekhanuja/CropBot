/*
 This is a UIStackView class that contains
 a title and subtitle.
 
 Copyright © 2019 Nikolas Ioannou. All rights reserved.
*/

import UIKit

class TitleSubtitleStackView: UIStackView {
    
    // MARK: - Create views
    
    /*
     This is the label for the title.
    */
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /*
     This is the label for the subtitle.
    */
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    /*
     This is init method for this stack
     view.
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    /*
     This is a required init method handling
     edge cases.
    */
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup functions
    
    /*
     This method sets up all the views.
    */
    func setupViews() {
        // Setup
        // Self
        self.axis = .vertical
        self.spacing = 2
        self.distribution = UIStackView.Distribution.fillProportionally
        
        // Add subviews
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(subtitleLabel)
    }
    
}
