//
//  SearchViewController.swift
//  SampleAlamofireMapper
//
//  Created by Thahir Maheen on 28-9-17.
//  Copyright © 2017 Thahir. All rights reserved.
//

import PromiseKit

class TracksViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStoredTracks()
    }
    
    func fetchStoredTracks() {
        tracks = Track.getTracks()
    }
    
    fileprivate var tracks = [Track]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.reuseIdentifier) as? TrackCell else { return UITableViewCell() }
        cell.track = tracks[indexPath.row]
        return cell
    }
    
}

extension TracksViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchKey = searchBar.text else { return }
        
        Track.search(with: searchKey).then { [weak self] tracks -> Void in
            self?.tracks = tracks
            }.catch { error in
                print(error.localizedDescription)
        }
    }
}
