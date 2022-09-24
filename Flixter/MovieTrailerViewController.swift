//
//  MovieTrailerViewController.swift
//  Flixter
//
//  Created by lester on 9/23/22.
//

import UIKit
import WebKit
class MovieTrailerViewController: UIViewController, WKUIDelegate {
    
    var movie: [String: Any]!


    @IBOutlet weak var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()

        webView = WKWebView(frame: .zero, configuration: webConfiguration)

        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //print(movie!)
        // Do any additional setup after loading the view.
        
        let movieId = movie["id"] as! Int32
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!

        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                // TODO: Get the array of movies
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                print(dataDictionary)
                
                let movieTrailers = dataDictionary["results"] as! [[String: Any]]
                
                let key = movieTrailers[0]["key"] as! String
                
                let myURL = URL(string: "https://www.youtube.com/watch?v=\(key)")
                let myRequest = URLRequest(url: myURL!)
                self.webView.load(myRequest)
                
                
            }
        }
        task.resume()
    }

}
