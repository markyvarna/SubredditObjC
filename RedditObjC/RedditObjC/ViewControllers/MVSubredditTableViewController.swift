//
//  MVSubredditTableViewController.swift
//  RedditObjC
//
//  Created by Markus Varner on 9/12/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class MVSubredditTableViewController: UITableViewController {

    //MARK: - Outlets
    
    @IBOutlet var subredditSearchBar: UISearchBar!
    
     //MARK: - Properties
    var subreddits: [MVSubreddit]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subredditSearchBar.delegate = self
        

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return subreddits?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subredditCell", for: indexPath) as? MVSubredditTableViewCell
        let subreddit = subreddits?[indexPath.row]
        cell?.subreddit = subreddit
        

        

        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    

    

}

extension MVSubredditTableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text else {return}
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        MVSubredditClient.fetchAllSubreddits(forTitle: searchText) { (subreddits) in
            
            guard let subreddits = subreddits else {return}
            self.subreddits = subreddits
            for subreddit in subreddits {
                
                dispatchGroup.enter()
                MVSubredditClient.fetchImageData(forURL: subreddit.imageURLString, with: { (data) in
                    guard let data = data else {return}
                    let subredditPhoto = UIImage(data: data)
                    subreddit.photo = subredditPhoto
                    dispatchGroup.leave()
                })
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
        
    }
    
}
