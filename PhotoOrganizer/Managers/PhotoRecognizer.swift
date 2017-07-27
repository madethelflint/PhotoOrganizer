//
//  PhotoRecognizer.swift
//  PhotoOrganizer
//
//  Created by Rachel Parsons on 7/26/17.
//  Copyright © 2017 Rachel Parsons. All rights reserved.
//

import Vision
import UIKit

struct PhotoRecognizer {
	
	func executeMachineLearning(onImage image: UIImage) -> String {
		var classification = ""
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
					classification = "1. " + result.identifier + " \n with confiendence of \n \(result.confidence)"
//				case 1:
//					classificationLabel2.text = "2. " + result.identifier + " \n with confiendence of \n \(result.confidence)"
//				case 2:
//					classificationLabel3.text = "3. " + result.identifier + " \n with confiendence of \n \(result.confidence)"
				default:
					break
				}
				counter += 1
			}
			
			
		} catch {
			print("failed to load model")
		}
		return classification
	}
}
