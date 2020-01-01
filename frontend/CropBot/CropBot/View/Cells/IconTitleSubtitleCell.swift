/*
 This is a cell for the icon
title subtitle.
 
 Copyright © 2019 Nikolas Ioannou. All rights reserved.
*/

import UIKit

class IconTitleSubtitleCell: UITableViewCell {
    
    // MARK: - Autolayout constraints
    
    /*
     This is a CGFloat for the diameter
     of the iconImageView.
    */
    let iconDiameter: CGFloat = 32
    
    // MARK: - Create views
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.theme.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /*
     This is the imageView which contains the
     icon for the cell.
    */
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /*
     This is a stackView that equally sizes
     the title and subtitle views.
    */
    let titleSubtitleStackView: TitleSubtitleStackView = {
        let stackView = TitleSubtitleStackView()
        stackView.subtitleLabel.numberOfLines = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /*
     This is a view that is the
     divider between cells.
    */
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - DidSet
    
    /*
     This is a didSet method that populates
     the views of this cell.
    */
    var iconTitleSubtitle: IconTitleSubtitle! {
        didSet {
            // Set icon
            iconImageView.image = iconTitleSubtitle.image
            
            // Set title
            titleSubtitleStackView.titleLabel.text = iconTitleSubtitle.title
            
            // Set subtitle
            titleSubtitleStackView.subtitleLabel.text = iconTitleSubtitle.subtitle
        }
    }
    
    /*
     This is a didSet method that populates
     the rightButton of this cell.
    */
    var rightView: UIView! {
        didSet {
            // Add to view
            containerView.addSubview(rightView)
            
            // Add constraints
            rightView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
            rightView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    }
    
    // MARK: - Init
    
    /*
     This is init method for this cell.
    */
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    /*
     This is a required init method handling
     edge cases.
    */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup functions
    
    /*
     This method sets up all the views.
    */
    func setupViews() {
        // Setup
        // Add subviews
        self.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleSubtitleStackView)
        containerView.addSubview(dividerView)
        
        // Add contstraints
        // containerView
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        // iconImageView
        iconImageView.widthAnchor.constraint(equalToConstant: iconDiameter).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: iconDiameter).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        // dividerView
        dividerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        dividerView.leadingAnchor.constraint(equalTo: titleSubtitleStackView.leadingAnchor).isActive = true
        dividerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        // titleSubtitleStackView
        titleSubtitleStackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16).isActive = true
        titleSubtitleStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        titleSubtitleStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
    }
    
    /*
     This is a method that configures the
     corners of the view.
    */
    func configureCornerRadius(indexPath: IndexPath, rowData: [[Any]], withSection: Bool) {
        // Get row and section
        let row = indexPath.row
        let section = indexPath.section
        
        if withSection {
            // Chech cases
            if row == 0 {
                // Set top corner radius
                containerView.layer.cornerRadius = 10
                containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            } else if row == rowData[section].count - 1 {
                // Set bottom corner radius
                containerView.layer.cornerRadius = 10
                containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                
                // Remove divider view
                dividerView.isHidden = true
            }
        } else {
            // Chech cases
            if row == 0 {
                // Set top corner radius
                containerView.layer.cornerRadius = 10
                containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            } else if row == rowData[0].count - 1 {
                // Set bottom corner radius
                containerView.layer.cornerRadius = 10
                containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                
                // Remove divider view
                dividerView.isHidden = true
            }
        }
    }
    
}
