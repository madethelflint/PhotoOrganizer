//
//  PhotoDetailsViewController.swift
//  PhotoOrganizer
//
//  Created by Rachel Parsons on 6/8/17.
//  Copyright © 2017 Rachel Parsons. All rights reserved.
//

import UIKit
import Photos

class PhotoDetailsViewController: UIViewController {
	
	@IBOutlet weak var imageView:UIImageView!
	@IBOutlet weak var categoryLabel:UILabel!
	
	var photoAsset: PHAsset?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		if let asset = photoAsset {
			let imageManager = PHImageManager.default()
			
			let size = imageView.frame.size
			
			imageManager.requestImage(for: asset, targetSize: size, contentMode: PHImageContentMode.aspectFit, options: nil, resultHandler: { (image, nil) in
				if let thumbnail = image{
					
					self.imageView.image = thumbnail
				}
			})
			
		}
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