//
//  ViewController.swift
//  SecuOTP Application
//
//  Created by Panasan Sinroungrong on 2/24/15.
//  Copyright (c) 2015 SecuOTP. All rights reserved.
//

import UIKit

class StartViewController: UIViewController , UIPageViewControllerDataSource {

    var pageViewController : UIPageViewController!
    
    let color : [UIColor] = [UIColor.blueColor(), UIColor.lightGrayColor(), UIColor.redColor()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as UIPageViewController
        pageViewController?.dataSource = self
        
        let startController : ContentPageViewController = self.viewControllerAtIndex(0)!
        pageViewController?.setViewControllers([startController], direction: .Forward, animated: false, completion: nil)
        
        self.addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController.view!)
        self.pageViewController?.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index : Int = (viewController as ContentPageViewController).pageIndex!
        
        if index == 0 || index == NSNotFound {
            return nil
        }
        return self.viewControllerAtIndex(--index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index : Int = (viewController as ContentPageViewController).pageIndex!

        if index == NSNotFound{
            return nil
        }
        index++
        if index == self.color.count {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index : Int) -> ContentPageViewController? {
        if self.color.count == 0 || index >= self.color.count {
            return nil
        }
        // Create a new view controller and pass suitable data.
        let contentPageViewController : ContentPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentPageViewController") as ContentPageViewController!
        contentPageViewController.color = self.color[index]
        contentPageViewController.pageIndex = index
        return contentPageViewController
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.color.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

