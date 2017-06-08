//
//  ViewController.swift
//  PhotoOrganizer
//
//  Created by Rachel Parsons on 6/7/17.
//  Copyright © 2017 Rachel Parsons. All rights reserved.
//

import UIKit
import Photos

class PhotoListViewController: UIViewController {
	
	@IBOutlet weak var photosCollectionView: UICollectionView!
	var photosList: [PHAsset] = []
	var photoAssets: PHFetchResult<PHAsset>?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		PHPhotoLibrary.requestAuthorization { (authorizationStatus) in
			switch authorizationStatus {
			case .authorized:
				DispatchQueue.main.async {
					self.loadPhotos()
				}
				break
			default:
				print("fail")
				break
			}
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func loadPhotos() {
		
		let options = PHFetchOptions()
		options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
		
//		let assets = PHAsset.fetchAssets(with: .image, options: options)
		photoAssets = PHAsset.fetchAssets(with: .image, options: options)
		
//		assets.enumerateObjects { (asset, count, stop) in
//			self.photosList.append(asset)
//
//			if count == assets.count {
//				DispatchQueue.main.sync {
//					self.photosCollectionView.reloadData()
//				}
//			}
//		}
		photosCollectionView.reloadData()
	}

}

extension PhotoListViewController: UICollectionViewDelegate {
	
}

extension PhotoListViewController: UICollectionViewDataSource {
	@available(iOS 6.0, *)
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if let allAssets = photoAssets {
			return allAssets.count
		}
		
		return 0
	}
	
	@available(iOS 6.0, *)
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoThumbnailCell", for: indexPath)
		
//		let asset = photosList[indexPath.row]
		if let asset = photoAssets?.object(at: indexPath.row) {
			let imageManager = PHImageManager.default()
			let size = CGSize(width: 100.0, height: 100.0)
			
			imageManager.requestImage(for: asset, targetSize: size, contentMode: PHImageContentMode.aspectFit, options: nil, resultHandler: { (image, nil) in
				if let thumbnail = image,
					let imageView = cell.viewWithTag(123) as? UIImageView {
					
					imageView.image = thumbnail
				}
			})
			
		}
		
		return cell
	}
	
	
}
