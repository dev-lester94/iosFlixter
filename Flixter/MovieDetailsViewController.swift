//
//  MovieDetailsViewController.swift
//  Flixter
//
//  Created by lester on 9/19/22.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var backDropView: UIImageView!
    
    @IBOutlet weak var posterView: UIImageView!
    

    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var sypnopsisLabel: UILabel!
    
    var movie: [String: Any]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapBackDropView(_:)))
        
        backDropView.isUserInteractionEnabled = true
        backDropView.addGestureRecognizer(tapGestureRecognizer)
        

        // Do any additional setup after loading the view.
        
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        sypnopsisLabel.text = movie["overview"] as? String
        sypnopsisLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        posterView.af.setImage(withURL: posterUrl)
        
        let backdropPath = movie["backdrop_path"] as! String
        
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!
        
        backDropView.af.setImage(withURL: backdropUrl)
    }
    
    @IBAction func tapBackDropView(_ sender: Any) {
        
        //print("got tapped")
        
        performSegue(withIdentifier: "watchMovieTrailer", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //print("prepared")
        
        let movieTrailerViewController = segue.destination as! MovieTrailerViewController
        
        movieTrailerViewController.movie = movie
        
        
    }
}
