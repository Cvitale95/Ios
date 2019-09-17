//
//  PhotosViewController.swift
//  tumblr
//
//  Created by Chris  on 9/16/19.
//  Copyright © 2019 Chris . All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath as IndexPath) as! PhotoCell
        
        let post = posts[indexPath.row]
        // 1.            // 2.          // 3.
        if let photos = post["photos"] as? [[String: Any]] {
            // photos is NOT nil, we can use it!
            // TODO: Get the photo url
            
            
            // 1.
            let photo = photos[0]
            // 2.
            let originalSize = photo["original_size"] as! [String: Any]
            // 3.
            let urlString = originalSize["url"] as! String
            // 4.
            let url = URL(string: urlString)
            cell.imgView.af_setImage(withURL: url!)
            
        }
        
        // Configure YourCustomCell using the outlets that you've defined.
        
        return cell
    }
 
    

    @IBOutlet weak var TableView: UITableView!
    

    
    //   1.       2.             3.
    var posts: [[String: Any]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableView.delegate = self
        self.TableView.dataSource = self
        TableView.rowHeight = 250
        
        // Network request snippet
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(dataDictionary)
                
                // TODO: Get the posts and store in posts property
                // Get the dictionary from the response key
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                
                // TODO: Reload the table view
                
                self.TableView.reloadData()
                
            }
        }
        task.resume()

      
    }
    
   
   

}
