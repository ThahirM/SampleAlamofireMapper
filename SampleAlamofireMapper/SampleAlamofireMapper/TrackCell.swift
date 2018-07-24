//
//  TrackCell.swift
//  SampleAlamofireMapper
//
//  Created by Thahir Maheen on 28-9-17.
//  Copyright © 2017 Thahir. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {
    
    var track: Track? {
        didSet {
            configureView()
        }
    }
    
    var tip: OffroadingTip? {
        didSet {
            configureView()
        }
    }
    
    static let reuseIdentifier = "kTrackCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        detailTextLabel?.numberOfLines = 0
        
        configureView()
    }
    
    private func configureView() {
        textLabel?.text = tip?.name?.english
        detailTextLabel?.text = tip?.guides.reduce ("") { $0 + "\n" + ($1.name?.english ?? "") }
    }
}
