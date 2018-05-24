//
//  ViewController.swift
//  AppStore-Animation
//
//  Created by MAC on 5/24/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let transition = TransitionAnimator()
    var selectedCell = UICollectionViewCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        transition.dismissCompletion = {
            self.selectedCell.isHidden = false
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCV_Cell", for: indexPath) as! MyCV_Cell
        let stringImageName =  NSString(format: "%ld",indexPath.row)
        cell.myImage.image = UIImage(named: stringImageName as String)
        cell.myImage.layer.cornerRadius = 15
        cell.myImage.layer.masksToBounds = true
        
        cell.myImage.isUserInteractionEnabled = true
        cell.myImage.tag = indexPath.row
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerHandler(_:)))
        tapGesture.numberOfTapsRequired = 1
        cell.myImage .addGestureRecognizer(tapGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognizerHandler(_:)))
        longPressGesture.minimumPressDuration = 1.0
        cell.myImage .addGestureRecognizer(longPressGesture)
        
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let originFrame = selectedCell.superview?.convert(selectedCell.frame, to: nil) else {
            return transition
        }
        transition.originFrame = originFrame
        transition.presenting = true
        selectedCell.isHidden = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
    
    @objc func tapGestureRecognizerHandler(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: collectionView)
        let indexPath = collectionView .indexPathForItem(at: location)
        
        selectedCell = collectionView.cellForItem(at: indexPath!) as! MyCV_Cell
       
        let DetailViewController = storyboard!.instantiateViewController(withIdentifier: "Detail_VC") as! Detail_VC
        DetailViewController.imageName = NSString(format: "%ld",(indexPath?.row)!) as String
        DetailViewController.transitioningDelegate = self
        

        
        UIView.animate(withDuration: 0.5, animations: {
            self.selectedCell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { (Success) in
            UIView.animate(withDuration: 0.5, animations: {
                self.selectedCell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                if(sender.delaysTouchesEnded)
                {
                    self.present(DetailViewController, animated: true, completion: nil)
                }
            })
        })
    }
    
    @objc func longPressGestureRecognizerHandler(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: collectionView)
        let indexPath = collectionView .indexPathForItem(at: location)
        
        selectedCell = collectionView.cellForItem(at: indexPath!) as! MyCV_Cell
        
        let DetailViewController = storyboard!.instantiateViewController(withIdentifier: "Detail_VC") as! Detail_VC
        DetailViewController.imageName = NSString(format: "%ld",(indexPath?.row)!) as String
        DetailViewController.transitioningDelegate = self
        
        UIView.animate(withDuration: 0.5, animations: {
            self.selectedCell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { (Success) in
            UIView.animate(withDuration: 0.5, animations: {
                self.selectedCell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                if(sender.delaysTouchesEnded)
                {
                    self.present(DetailViewController, animated: true, completion: nil)
                }
            })
        })
    }

}

