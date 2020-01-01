/*
 This is a message cell for the
 chat.
 
 Copyright © 2019 Nikolas Ioannou. All rights reserved.
*/

import UIKit

class ChatTextCell: UITableViewCell {
    
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
    
    // MARK: - Create views
    
    /*
     This is label for the message.
    */
    let messageLabel = UILabel()
    
    /*
     This is view for the bubble background.
    */
    let bubbleBackgroundView = UIView()
    
    // MARK: - DidSet
    
    /*
     This is didSet method that handles the
     chatMessage data source and its role
     in this cell.
    */
    var chatText: ChatText! {
        didSet {
            // Set text
            messageLabel.text = chatText.text
            
            // Change background color accordingly
            bubbleBackgroundView.backgroundColor = chatText.isIncoming ? UIColor.theme.gray : UIColor.theme.blue
            
            // Change text color
            messageLabel.textColor = chatText.isIncoming ? .black : .white
            
            // Change masked corners
            bubbleBackgroundView.layer.maskedCorners = chatText.isIncoming ? [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner] : [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner]
            
            // Check cases for position of bubble
            if chatText.isIncoming {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            } else {
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
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
        
        // messageLabel
        messageLabel.font = UIFont.systemFont(ofSize: 18)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        
        // Add subviews
        self.addSubview(bubbleBackgroundView)
        self.addSubview(messageLabel)
        
        // Add constraints
        // messageLabel
        messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14).isActive = true
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        // bubbleBackgroundView
        bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8).isActive = true
        bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16).isActive = true
        bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8).isActive = true
        bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16).isActive = true
        
        // messageLabel leading
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstraint.isActive = false
        
        // messageLabel trailing
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingConstraint.isActive = true
    }
    
    
}
