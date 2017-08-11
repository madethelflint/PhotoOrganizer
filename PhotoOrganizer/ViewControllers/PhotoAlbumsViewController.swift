//
//  PhotoAlbumsViewController.swift
//  PhotoOrganizer
//
//  Created by Rachel Parsons on 8/10/17.
//  Copyright © 2017 Rachel Parsons. All rights reserved.
//

import UIKit


class PhotoAlbumsViewController: UIViewController {

	let ALBUM_THUMB_CELL_IDENTIFIER = "photoAlbumThumbnailCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension PhotoAlbumsViewController: UICollectionViewDelegate {
	
}

extension PhotoAlbumsViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ALBUM_THUMB_CELL_IDENTIFIER, for: indexPath)
		
		return cell
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}
}
