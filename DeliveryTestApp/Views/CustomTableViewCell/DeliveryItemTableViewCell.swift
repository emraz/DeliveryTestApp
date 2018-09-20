//
//  DeliveryItemTableViewCell.swift
//  DeliveryTestApp
//
//  Created by Mahmudul Hasan R@zib on 9/16/18.
//  Copyright © 2018 Matrix Solution Ltd. All rights reserved.
//

import UIKit
import AlamofireImage

class DeliveryItemTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    let padding: CGFloat = 5
    var descriptionLabel: UILabel!
    var imgView: UIImageView!
    var storageStatus: Bool!
    
    var isStored: Bool? {
        didSet {
            storageStatus = isStored
        }
    }
    
    var del: Delivery? {
        didSet {
            if let d = del {
                if let url = URL(string: d.imageUrl) {
                    
                    if isStored == true {
                        let imageData = DataManager.sharedManager.readData(fileName: d.deliveryID+".jpg")
                        let imageUIImage = UIImage(data: imageData)
                        imgView.image = imageUIImage
                    }
                    else {
                        imgView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "place_holder.jpg"))
                    }
                }
                descriptionLabel.text = d.descrption

                setNeedsLayout()
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        selectionStyle = .none
        
        imgView = UIImageView(frame: CGRect.zero)
        imgView.contentMode = UIViewContentMode.scaleAspectFill
        imgView.clipsToBounds = true
        imgView.backgroundColor = UIColor.clear
        contentView.addSubview(imgView)

        descriptionLabel = UILabel(frame: CGRect.zero)
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = UIColor.black
        descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        descriptionLabel.numberOfLines = 0
        contentView.addSubview(descriptionLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.frame = CGRect.init(x: padding, y: padding, width: frame.height - (2 * padding), height: frame.height - (2 * padding))
        descriptionLabel.frame = CGRect.init(x: imgView.frame.maxX + padding * 2, y: padding, width: frame.width - (3 * padding) - imgView.frame.width, height: frame.height - (2 * padding))
    }

}


