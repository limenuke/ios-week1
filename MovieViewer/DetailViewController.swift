//
//  DetailViewController.swift
//  MovieViewer
//
//  Created by Liang Rui on 10/15/16.
//  Copyright © 2016 Etcetera. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    var movie: NSDictionary!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = movie["title"] as? String
        titleLabel.text = title
        
        let overview = movie["overview"]
        overviewLabel.text = overview as? String
        overviewLabel.sizeToFit()
        
        infoView.sizeToFit()
        
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        if let posterPath = movie["poster_path"] as? String {
            let imgURL = URL(string: baseUrl + posterPath)
            posterImageView.setImageWith(imgURL!)
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
