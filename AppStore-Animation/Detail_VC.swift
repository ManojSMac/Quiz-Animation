//
//  Detail_VC.swift
//  AppStore-Animation
//
//  Created by MAC on 5/24/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class Detail_VC: UIViewController {

    @IBOutlet weak var myImage: UIImageView!
    
    var imageName  = String()
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    var initialFrame = CGRect()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.masksToBounds = true
        
        initialFrame = self.view.frame;
        myImage.image = UIImage(named: imageName as String)
    
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureRecognizerHandler(_:)))
       self.view.addGestureRecognizer(panGesture)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
       
        if sender.state == UIGestureRecognizerState.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizerState.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.layer.cornerRadius = (touchPoint.y - initialTouchPoint.y)/2
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
            if touchPoint.y - initialTouchPoint.y > 50 {
                self.view.layer.cornerRadius = 0.0
                self.dismiss(animated: true, completion: nil)
            }
        } else if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            if touchPoint.y - initialTouchPoint.y > 50 {
                self.view.layer.cornerRadius = (touchPoint.y - initialTouchPoint.y)/2
                self.dismiss(animated: true, completion: nil)
            } else {
                self.view.layer.cornerRadius = 0.0
                self.view.frame = initialFrame
            }
        }
    }
    
    // MARK: - Button Action
     @IBAction func actionCloseViewButton(_ sender: UIButton)
     {
       self.dismiss(animated: true, completion: nil)
    }
    
}
