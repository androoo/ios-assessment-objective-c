//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Andrew Ervin Gierke on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, UISearchBarDelegate {
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK: - Properties
    
    var movies: [DMNMovie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return MovieTableViewCell() }
        
        let movie = movies[indexPath.row]
        cell.movies = movie
        
        return cell
    }
    
    
    //MARK: - Search Button Method
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        DMNMovieController.fetchMovie(forSearchTerm: searchTerm) { (movies) in
            guard let movies = movies as? [DMNMovie] else { return }
            self.movies = movies
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.searchBar.resignFirstResponder()
            }
        }
    }
}
