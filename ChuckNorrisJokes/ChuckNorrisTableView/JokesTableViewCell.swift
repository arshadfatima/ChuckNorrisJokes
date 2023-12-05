//
//  JokesTableViewCell.swift
//  ChuckNorrisJokes
//
//  Created by Fatima Arshad on 12/4/23.
//

import Foundation
import UIKit

class JokesTableViewCell: UITableViewCell {
    @IBOutlet weak var jokeLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func configureCellView(with joke: Joke) {
        jokeLabel?.text = joke.value
    }
}
