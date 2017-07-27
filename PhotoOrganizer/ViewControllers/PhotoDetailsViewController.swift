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
	@IBOutlet weak var classificationLabel1:UILabel!
	@IBOutlet weak var classificationLabel2: UILabel!
	@IBOutlet weak var classificationLabel3: UILabel!
	
	var photoAsset: PHAsset?
	
	let recognizer = PhotoRecognizer()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		if let asset = photoAsset {
			let imageManager = PHImageManager.default()
			
			let size = imageView.frame.size
			
			imageManager.requestImage(for: asset, targetSize: size, contentMode: PHImageContentMode.aspectFit, options: nil, resultHandler: { (image, nil) in
				if let thumbnail = image{
					
					self.imageView.image = thumbnail
					
					let classification = self.recognizer.executeMachineLearning(onImage: thumbnail)
					self.classificationLabel1.text = classification
				}
			})
			
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
