//
//  HomeController.swift
//  ESearchBar
//
//  Created by Asad Khan on 19/10/2022.
//

import UIKit

class HomeController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var headerView: ESearchBar!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        view.backgroundColor = .white
    }
    

//MARK: - Helper Functions
    func animateHeaderView(type:ESearchBarDesignType){
        switch type {
        case .collapse:
            self.headerView.animateSearchBar(searchType: .collapse)
            UIView.animate(withDuration: 0.5, animations: {
                self.headerViewHeightConstraint.constant = 56
                self.view.layoutIfNeeded()
            })
            break
        case .expand:
            self.headerView.animateSearchBar(searchType: .expand)
            UIView.animate(withDuration: 0.5, animations: {
               self.headerViewHeightConstraint.constant = 120
                self.view.layoutIfNeeded()
            })
            break
        }
    }
    //MARK: - UIScrollview Delegate
    /// use same method for tableview and collection view
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let _ = scrollView as? UICollectionView {
            
        }else{
            if (scrollView.contentOffset.y < 5) {
                // move up
                animateHeaderView(type: .expand)
            }
            else  {
                // move down
                animateHeaderView(type: .collapse)
            }
        }
    }

}
