//
//  PhotosDetailsViewController.swift
//  tumblr
//
//  Created by Chris  on 9/23/19.
//  Copyright © 2019 Chris . All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosDetailsViewController: UIViewController {
    
    
    var photoUrlString: String = ""

    @IBOutlet weak var ImgDetails: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: photoUrlString)
        ImgDetails.af_setImage(withURL : url!)
        
    }
    

    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        
    }
    

}
