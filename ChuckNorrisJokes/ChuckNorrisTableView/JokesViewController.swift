//
//  JokesViewController.swift
//  ChuckNorrisJokes
//
//  Created by Fatima Arshad on 12/4/23.
//

import Combine
import UIKit

class JokesViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var appDataSource = AppDataSource()
    var dataSource: ChuckNorrisDataSource? = nil
    var snapShot: ChuckNorrisSnapshot? = nil
    
    var jokesList: [Joke] = []
    override func viewDidLoad() {
        super.viewDidLoad()
         
        // Setup navigation title and bar button items
        navigationItem.title = "Jokes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask(_:)))
        
        // Configuring tableView
        tableView.dataSource = appDataSource.dataSource
        tableView.delegate = self
        appDataSource.configDataSource(tableView: tableView)
        appDataSource.createSnapshot(from: jokesList)
    }
    
    @objc func addTask(_ sender: UIBarButtonItem) {
        // Make a CN network call
        let request = JokesAPIRequest()
        request.fetchJokes() { (newJoke) in
            self.jokesList.append(newJoke)
            self.appDataSource.addJoke(newJoke)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, actionPerformed: (Bool) -> ()) in
            guard let joke = self.appDataSource.dataSource.itemIdentifier(for: indexPath) else { return }
            self.appDataSource.removeJoke(joke)
            actionPerformed(true)
        }

        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}
