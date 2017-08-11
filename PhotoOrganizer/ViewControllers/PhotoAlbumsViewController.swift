//
//  PhotoAlbumsViewController.swift
//  PhotoOrganizer
//
//  Created by Rachel Parsons on 8/10/17.
//  Copyright © 2017 Rachel Parsons. All rights reserved.
//

import UIKit
import Photos

class PhotoAlbumsViewController: UIViewController {

	let ALBUM_THUMB_CELL_IDENTIFIER = "photoAlbumThumbnailCell"

	@IBOutlet weak var albumsCollectionView: UICollectionView!
	
	var albums: PHFetchResult<PHCollectionList>?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		PHPhotoLibrary.requestAuthorization { (authorizationStatus) in
			switch authorizationStatus {
			case .authorized:
				DispatchQueue.main.async {
					self.loadAlbums()
				}
				break
			default:
				print("failure")
				break
			}
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	private func loadAlbums() {
		
		let options = PHFetchOptions()
//		options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
		
		albums = PHCollectionList.fetchCollectionLists(with: .folder, subtype: .any, options: options)
		
		albumsCollectionView.reloadData()
	}
}

extension PhotoAlbumsViewController: UICollectionViewDelegate {
	
}

extension PhotoAlbumsViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ALBUM_THUMB_CELL_IDENTIFIER, for: indexPath)
		if let label = cell.viewWithTag(121) as? UILabel {
			label.text = "Album \(indexPath.row)"
		}
		return cell
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if let allAlbums = albums {
			return allAlbums.count
		}
		return 0
	}
}
