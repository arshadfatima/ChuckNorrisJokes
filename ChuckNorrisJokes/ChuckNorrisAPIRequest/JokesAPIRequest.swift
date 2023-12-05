//
//  JokesAPIRequest.swift
//  ChuckNorrisJokes
//
//  Created by Fatima Arshad on 12/4/23.
//

import Foundation

class JokesAPIRequest: NSObject {
    /// Fetching from jokes api
    func fetchJokes(completionBlock: @escaping (Joke) -> Void) -> Void {
        guard let url = URL(string:"https://api.chucknorris.io/jokes/random") else { return }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        // dataTask: Creates a task that retrieves the contents of a URL based on the specified URL request object, and calls a handler upon completion.
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            do {
                let decodeJoke = try JSONDecoder().decode(Joke.self, from: data!)
                completionBlock(decodeJoke)
                
            } catch {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
}
