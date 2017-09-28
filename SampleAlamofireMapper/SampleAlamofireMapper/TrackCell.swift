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
    
    static let reuseIdentifier = "kTrackCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    private func configureView() {
        textLabel?.text = track?.trackName
        detailTextLabel?.text = track?.trackCollectionName
    }
}
