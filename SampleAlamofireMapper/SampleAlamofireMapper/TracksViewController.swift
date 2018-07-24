//
//  SearchViewController.swift
//  SampleAlamofireMapper
//
//  Created by Thahir Maheen on 28-9-17.
//  Copyright © 2017 Thahir. All rights reserved.
//

import PromiseKit
import RealmSwift

class Blah: UIViewController {
    
    @IBAction func buttonActionClear(_ sender: UIButton) {
        OffroadingTip.cached().first?.update { (first) in
            first.name?.english = "New Name"
        }
    }
}

class TracksViewController: UITableViewController {

    fileprivate var tracks = [Track]() {
        didSet {
//            tableView?.reloadData()
        }
    }
    
    fileprivate var tips = [OffroadingTip]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        navigationItem.searchController = searchController
        
        // load cached tracks
        tracks = Track.cached()

        OffroadingTip.fetchOffroadingTips().then { [weak self] (fetchResponse) -> Void in
            self?.tips = OffroadingTip.cached()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tips = OffroadingTip.cached()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.reuseIdentifier) as? TrackCell else { return UITableViewCell() }
        cell.tip = tips[indexPath.row]
        return cell
    }
}

extension TracksViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchKey = searchController.searchBar.text else { return }
        
        Track.search(with: searchKey).then { [weak self] tracks -> Void in
            self?.tracks = tracks
            }.catch { error in
                print(error.localizedDescription)
        }
    }
}

extension TracksViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        // load cached tracks
        tracks = Track.cached()
    }
}
