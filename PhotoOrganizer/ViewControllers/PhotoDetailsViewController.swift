//
//  PhotoDetailsViewController.swift
//  PhotoOrganizer
//
//  Created by Rachel Parsons on 6/8/17.
//  Copyright © 2017 Rachel Parsons. All rights reserved.
//

import UIKit
import Photos
import Vision

class PhotoDetailsViewController: UIViewController {
	
	@IBOutlet weak var imageView:UIImageView!
	@IBOutlet weak var classificationLabel1:UILabel!
	@IBOutlet weak var classificationLabel2: UILabel!
	@IBOutlet weak var classificationLabel3: UILabel!
	
	var photoAsset: PHAsset?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		if let asset = photoAsset {
			let imageManager = PHImageManager.default()
			
			let size = imageView.frame.size
			
			imageManager.requestImage(for: asset, targetSize: size, contentMode: PHImageContentMode.aspectFit, options: nil, resultHandler: { (image, nil) in
				if let thumbnail = image{
					
					self.imageView.image = thumbnail
					
					self.executeMachineLearning(onImage: thumbnail)
				}
			})
			
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func executeMachineLearning(onImage image: UIImage) {
		do {
			let model = try VNCoreMLModel(for: Resnet50().model)
			
			let ciImage = CIImage(cgImage: image.cgImage!)
			let imageHandler = VNImageRequestHandler(ciImage: ciImage)
			
			let request = VNCoreMLRequest(model: model)
			
			try imageHandler.perform([request])
			
			let results = request.results as! [VNClassificationObservation]
			var counter = 0
			for result in results {
				
				switch counter {
				case 0:
					classificationLabel1.text = "1. " + result.identifier + " \n with confiendence of \n \(result.confidence)"
				case 1:
					classificationLabel2.text = "2. " + result.identifier + " \n with confiendence of \n \(result.confidence)"
				case 2:
					classificationLabel3.text = "3. " + result.identifier + " \n with confiendence of \n \(result.confidence)"
				default:
					return
				}
				counter += 1
			}
			

		} catch {
			print("failed to load model")
		}
		
	}
	
	func handleClassification(request: VNRequest, error: Error?) {
		
	}
	
	func handleRectangle() {
		
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
