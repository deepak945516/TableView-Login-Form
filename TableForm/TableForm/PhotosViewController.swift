//
//  PhotosViewController.swift
//  TableForm
//
//  Created by Deepak Kumar on 17/05/18.
//  Copyright © 2018 Deepak Kumar. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    // MARK: - Variables
    var isExpanded = false
    var backButton: UIBarButtonItem!
    var numberOfRowsColumns: CGFloat = 3
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup Method
    func setup() {
        title = "Gallery"

        self.photosCollectionView.register(UINib.init(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "itemId")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
        
        backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
    }
    
    @objc func logoutButtonTapped() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let loginViewC = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = loginViewC
        }
    }
    
    @objc func backButtonTapped() {
        isExpanded = false
        self.navigationItem.leftBarButtonItem = nil
        numberOfRowsColumns = 3
        if let layout = photosCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        title = "Gallery"

        photosCollectionView.isPagingEnabled = false
        photosCollectionView.reloadData()
    }
    
    // MARK: - IBAction Methods
    
    
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "itemId", for: indexPath) as? PhotosCollectionViewCell {
            cell.imageView.image = photoArray[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isExpanded == false {
            numberOfRowsColumns = 1
            self.navigationItem.leftBarButtonItem = backButton
            isExpanded = true
          
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }
            photosCollectionView.isPagingEnabled = true
            title = nameArray[indexPath.row]
            photosCollectionView.reloadData()
            photosCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
}


extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    //this method is for the size of items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / numberOfRowsColumns
        let height : CGFloat = collectionView.frame.height / numberOfRowsColumns
        return CGSize(width: width, height: height)
    }
    //these methods are to configure the spacing between items

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0,0,0,0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
