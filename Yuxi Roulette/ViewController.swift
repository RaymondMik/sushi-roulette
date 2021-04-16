//
//  ViewController.swift
//  Yuxi Roulette
//
//  Created by Ramón Miklus on 14/04/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var yuxiPreviewImage: UIImageView!
    @IBOutlet weak var itemsScrollView: UIScrollView!
    @IBOutlet weak var itemsCounter: UILabel!
    @IBOutlet weak var addPreviewButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var scrollView: UIScrollView!
    var images = [UIImageView]()
    var selectedItem = 0
    var totalItems = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPreviewButton.isHidden = true
        
        // Set the scrollView's frame to be the size of the screen
        scrollView = UIScrollView(frame: CGRect(x: 10, y: 505, width: view.frame.width, height: view.frame.height))
        // scrollView.backgroundColor = .systemTeal
        // Set the contentSize to 5 times the height of the phone's screen so that
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width-10, height: UIScreen.main.bounds.height*5)
        view.addSubview(scrollView)
        
    }

    @IBAction func spinYuxiPreview(_ sender: Any) {
        let randomIndex = Int.random(in: 2...157)
        
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            let randomNumber = Int.random(in: 2...157)
            self.yuxiPreviewImage.image = UIImage(named: "image-\(randomNumber)")

            if randomNumber == randomIndex {
                timer.invalidate()
                self.selectedItem = randomNumber
                if (self.addPreviewButton.isHidden) {
                    self.addPreviewButton.isHidden = false
                }
            }
        }
    }
    
    @IBAction func addPreviewToTheList(_ sender: Any) {
        if (self.selectedItem == 0) {
            return
        }
      
        images.append(UIImageView(image: UIImage(named:  "image-\(self.selectedItem)")))
        images[self.totalItems].contentMode = .center
        let topSpacing: Int = 10
        let yCoord: Int = self.totalItems != 0 ? Int(200 * self.totalItems + topSpacing) : topSpacing
        images[self.totalItems].frame = CGRect(x: 0, y: yCoord, width: Int(self.view.frame.width), height: 200)
        scrollView.addSubview(images[self.totalItems])
        
        self.totalItems = self.totalItems + 1
        itemsCounter.text = String(self.totalItems)
    }
    
    @IBAction func resetItemsState(_ sender: Any) {
        self.totalItems = 0
        self.selectedItem = 0
        self.addPreviewButton.isHidden = true
        self.yuxiPreviewImage.image = UIImage(named: "image-1")
        images = [UIImageView]()
        itemsCounter.text = String(self.totalItems)
        let subViews = self.scrollView.subviews
        for subview in subViews{
            subview.removeFromSuperview()
        }
    }
}

