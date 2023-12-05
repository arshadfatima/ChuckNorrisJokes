//
//  ChuckNorrisDataSource.swift
//  ChuckNorrisJokes
//
//  Created by Fatima Arshad on 12/4/23.
//

import Foundation
import UIKit

// MARK: - Value Types
typealias ChuckNorrisDataSource = UITableViewDiffableDataSource<Section, Joke>
typealias ChuckNorrisSnapshot = NSDiffableDataSourceSnapshot<Section, Joke>

class AppDataSource: NSObject {
    var dataSource: ChuckNorrisDataSource!
    var snapshot: ChuckNorrisSnapshot!
    
    /// Configure UITableViewDiffableDataSource
    func configDataSource(tableView: UITableView) {
        dataSource = ChuckNorrisDataSource(tableView: tableView) { (tableView: UITableView, indexPath: IndexPath, joke: Joke) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "JokeCellIdentifier", for: indexPath) as! JokesTableViewCell
            cell.configureCellView(with: joke)
            return cell
        }
    }
    
    /// Configure NSDiffableDataSourceSnapshot
    func createSnapshot(from joke: [Joke], animated: Bool = true) {
        snapshot = ChuckNorrisSnapshot()
        snapshot.appendSections([.main])
        snapshot?.appendItems(joke)
        dataSource?.apply(snapshot!, animatingDifferences: animated)
    }
    
    func removeJoke(_ joke: Joke) {
        snapshot = dataSource.snapshot()
        snapshot?.deleteItems([joke])
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func addJoke(_ joke: Joke) {
        snapshot = dataSource.snapshot()
        snapshot?.appendItems([joke])
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
