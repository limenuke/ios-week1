//
//  MovieViewController.swift
//  MovieViewer
//
//  Created by Liang Rui on 10/12/16.
//  Copyright © 2016 Etcetera. All rights reserved.
//

import UIKit
import AFNetworking
/* api key
 a07e22bc18f5cb106bfe4cc1f83ad8ed
 */

let apikey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
/*
https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US
 */
class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var movies: [NSDictionary]?
    var endpoint : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //endpoint = "top_rated"
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        networkRequest()
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "Helvetica", size: 20)!
        ]
    }
    
    func networkRequest () {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint!)?api_key=\(apiKey)")
        let request = NSURLRequest(
            url: url!,
            cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest,
                                                        completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(
                    with: data, options:[]) as? NSDictionary {
                        print("response: \(responseDictionary)")
                        self.movies = responseDictionary["results"] as! [NSDictionary]
                        self.tableView.reloadData()
                }
            }
        })
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = self.movies {
            return movies.count
        } else {
            return 0
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        if let posterPath = movie["poster_path"] as? String {
            let imgURL = URL(string: baseUrl + posterPath)
            cell.posterView.setImageWith(imgURL!)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for:cell)
        let movie = movies![indexPath!.row]
        
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.movie = movie
        
    }
    
    func didRefresh() {
        networkRequest()
    }

}
