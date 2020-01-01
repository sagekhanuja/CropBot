/*
 This is a photo cell for the
 chat.
 
 Copyright © 2019 Nikolas Ioannou. All rights reserved.
*/

import UIKit

class ChatPhotoCell: UITableViewCell {
    
    // MARK: - Autolayout constraints
    
    /*
     This is activated if the message was
     sent by CropBot.
    */
    var leadingConstraint: NSLayoutConstraint!
    
    /*
     This is activated if the message was
     sent by the user.
    */
    var trailingConstraint: NSLayoutConstraint!
    
    /*
     This width of the imageView.
    */
    var widthConstraint: NSLayoutConstraint!
    
    /*
     This height of the imageView.
    */
    var heightConstraint: NSLayoutConstraint!
    
    // MARK: - Create views
    
    /*
     This is view for the bubble background.
    */
    let bubbleBackgroundView = UIView()
    
    /*
     This is image view which contains the
     sent photo.
    */
    let chatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /*
     This is the button that is showed
     when there is no imageView.
    */
    let circleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "camera")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - DidSet
    
    /*
     This is didSet method that handles the
     chatMessage data source and its role
     in this cell.
    */
    var chatPhoto: ChatPhoto! {
        didSet {
            
            // Change masked corners
            bubbleBackgroundView.layer.maskedCorners = chatPhoto.isIncoming ? [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner] : [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner]
            
            // Check cases for position of bubble
            if chatPhoto.isIncoming {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            } else {
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        
            if chatPhoto.photo == nil {
                chatImageView.isHidden = true
            } else {
                chatImageView.isHidden = false
            }
            
            if let photo = chatPhoto.photo {
                
                // Set photo
                chatImageView.image = photo
                // Set imageView height and thus cell height
                // Disactivate both constraints
                widthConstraint.isActive = false
                heightConstraint.isActive = false
                // Get photo sie
                let photoSize = photo.size
                // Check cases
                if photoSize.width > photoSize.height {
                    widthConstraint = chatImageView.widthAnchor.constraint(equalToConstant: 266)
                    heightConstraint = chatImageView.heightAnchor.constraint(equalToConstant: 266 * photoSize.height / photoSize.width)
                } else {
                    widthConstraint = chatImageView.widthAnchor.constraint(equalToConstant: 266 * photoSize.width / photoSize.height)
                    heightConstraint = chatImageView.heightAnchor.constraint(equalToConstant: 266)
                }
                // Activate both constraints
                widthConstraint.isActive = true
                heightConstraint.isActive = true
            }
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
        // Self
        self.backgroundColor = .clear
        
        // bubbleBackgroundView
        bubbleBackgroundView.layer.cornerRadius = 18
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        bubbleBackgroundView.backgroundColor = UIColor.theme.gray
        bubbleBackgroundView.clipsToBounds = true
        
        // Add subviews
        self.addSubview(bubbleBackgroundView)
        bubbleBackgroundView.addSubview(circleImageView)
        bubbleBackgroundView.addSubview(chatImageView)
        
        // Add constraints
        // messageLabel
        chatImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        widthConstraint = chatImageView.widthAnchor.constraint(equalToConstant: 266)
        widthConstraint.isActive = true
        heightConstraint = chatImageView.heightAnchor.constraint(equalToConstant: 64)
        heightConstraint.isActive = true
        
        // bubbleBackgroundView
        bubbleBackgroundView.topAnchor.constraint(equalTo: chatImageView.topAnchor).isActive = true
        bubbleBackgroundView.leadingAnchor.constraint(equalTo: chatImageView.leadingAnchor).isActive = true
        bubbleBackgroundView.bottomAnchor.constraint(equalTo: chatImageView.bottomAnchor).isActive = true
        bubbleBackgroundView.trailingAnchor.constraint(equalTo: chatImageView.trailingAnchor).isActive = true
        
        // circleView
        circleImageView.centerXAnchor.constraint(equalTo: bubbleBackgroundView.centerXAnchor).isActive = true
        circleImageView.centerYAnchor.constraint(equalTo: bubbleBackgroundView.centerYAnchor).isActive = true
        circleImageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        circleImageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
    
        // chatImageView leading
        leadingConstraint = chatImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        leadingConstraint.isActive = false
        // chatImageView trailing
        trailingConstraint = chatImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        trailingConstraint.isActive = true
    }
    
    
}
