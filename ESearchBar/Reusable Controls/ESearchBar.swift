//
//  ESearchBar.swift
//  ESearchBar
//
//  Created by Asad Khan on 19/10/2022.
//

import UIKit
enum ESearchBarDesignType{
    case expand,collapse
}
protocol ESearchBarDelegate {
    func headerSearchBtnTapped()
    func headerBackBtnTapped()
    func headerProfileBtnTapped()
    func headerCartBtnTapped()
    func headerAlaCartBtnTapped()
}
class ESearchBar: UIView {
    @IBInspectable var headerColor: UIColor? {
         get {
             return self.backgroundColor
         }
         set {
            self.backgroundColor = newValue
         }
    }
    @IBInspectable var headerTextColor: UIColor? {
         get {
             return self.headingLabel.textColor
         }
         set {
            self.headingLabel.textColor = newValue
         }
    }
    @IBInspectable var counterColor: UIColor? {
         get {
             return self.cartCountLabel.backgroundColor
         }
         set {
            self.cartCountLabel.backgroundColor = newValue
         }
    }
    @IBInspectable var counterTextColor: UIColor? {
         get {
             return self.cartCountLabel.textColor
         }
         set {
            self.cartCountLabel.textColor = newValue
         }
    }
    @IBInspectable var searchBarColor: UIColor? {
         get {
             return self.searchView.backgroundColor
         }
         set {
             self.searchView.backgroundColor = newValue
         }
    }
    @IBInspectable var searchTextColor: UIColor? {
         get {
             return self.searchLabel.textColor
         }
         set {
             self.searchLabel.textColor = newValue
         }
    }
    @IBInspectable var headerFont: UIFont {
         get {
             return self.headingLabel.font
         }
         set {
             self.headingLabel.font = newValue
         }
    }
    @IBInspectable var counterFont: UIFont? {
         get {
             return self.cartCountLabel.font
         }
         set {
             self.cartCountLabel.font = newValue
         }
    }
    @IBInspectable var searchCornerRadius: Double {
         get {
             return Double(self.searchView.layer.cornerRadius)
         }set {
             self.searchView.layer.cornerRadius = CGFloat(newValue)
         }
    }
    @IBInspectable var searchBorderWidth: Double {
          get {
              return Double(self.searchView.layer.borderWidth)
          }
          set {
              self.searchView.layer.borderWidth = CGFloat(newValue)
          }
    }
    @IBInspectable var searchBorderColor: UIColor? {
         get {
             return UIColor(cgColor: self.searchView.layer.borderColor!)
         }
         set {
             self.searchView.layer.borderColor = newValue?.cgColor
         }
    }
    @IBInspectable var searchShadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.searchView.layer.shadowColor!)
        }
        set {
            self.searchView.layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var searchShadowOpacity: Float {
        get {
            return self.searchView.layer.shadowOpacity
        }
        set {
            self.searchView.layer.shadowOpacity = newValue
       }
    }
    @IBInspectable var backImage: UIImage? {
        get {
            return self.backBtn.imageView?.image
        }
        set {
            self.backBtn.setImage(newValue, for: .normal)
       }
    }
    @IBInspectable var accountImage: UIImage? {
        get {
            return self.accountBtn.imageView?.image
        }
        set {
            self.accountBtn.setImage(newValue, for: .normal)
       }
    }
    @IBInspectable var cartImage: UIImage? {
        get {
            return self.cartBtn.imageView?.image
        }
        set {
            self.cartBtn.setImage(newValue, for: .normal)
       }
    }
    @IBInspectable var searchImage: UIImage? {
        get {
            return self.searchIconView.image
        }
        set {
            self.searchIconView.image = newValue
       }
    }
    @IBInspectable var headerText: String? {
        get {
            return self.headingLabel.text
        }
        set {
            self.headingLabel.text = newValue
       }
    }
    @IBInspectable var searchText: String? {
        get {
            return self.searchLabel.text
        }
        set {
            self.searchLabel.text = newValue
       }
    }
    @IBInspectable var counterText: String? {
        get {
            return self.cartCountLabel.text
        }
        set {
            if let counter = Int(newValue ?? "0"){
                if counter > 0 {
                    self.cartCountLabel.isHidden = false
                    self.cartCountLabel.text = newValue
                }else{
                    self.cartCountLabel.isHidden = true
                }
            }else{
                self.cartCountLabel.isHidden = true
            }
            
       }
    }
    
    
    @IBOutlet weak private var searchIconView: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var accountBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak private var headingLabel: UILabel!
    @IBOutlet weak private var profileBtn: UIButton!
    @IBOutlet weak private var cartCountLabel: UILabel!
    @IBOutlet weak private var searchLabel: UILabel!
    @IBOutlet weak private var searchView: UIView!
    
    @IBOutlet weak private var searchImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak private var profileBtnTrallingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var searchImageTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var searchImageLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var searchLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var searchViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var searchViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak private var searchViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var searchViewTopToLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak private var searchViewTopConstraint: NSLayoutConstraint!
    
    var delegate : ESearchBarDelegate?
    private var isExpanded = true
    var searchCollapseFont: UIFont? = UIFont.systemFont(ofSize: 10, weight: .regular)
    var searchExpandFont: UIFont? = UIFont.systemFont(ofSize: 19, weight: .medium)
    let nibName = "ESearchBar"
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    override func layoutSubviews() {
        self.searchView.layer.cornerRadius = self.searchView.frame.size.height/2
        self.searchView.clipsToBounds = true
        self.cartCountLabel.layer.cornerRadius = self.cartCountLabel.frame.size.height/2
        self.cartCountLabel.clipsToBounds = true
    }
    
    //MARK: - Helper Functions
    func animateSearchBar(searchType:ESearchBarDesignType){
        switch searchType {
        case .collapse:
            collapseSearchView()
            isExpanded = false
            break
        default:
            expandSearchView()
            isExpanded = true
            break
        }
    }
    
    private func collapseSearchView(){
        UIView.animate(withDuration: 0.5, animations: {
            self.searchViewTopToLabelConstraint.priority = UILayoutPriority(rawValue: 750)
            self.searchViewTopConstraint.priority = UILayoutPriority(rawValue: 1000)
            self.searchViewLeadingConstraint.priority = UILayoutPriority(rawValue: 750)
            self.searchViewWidthConstraint.priority = UILayoutPriority(rawValue: 1000)
            self.searchViewHeightConstraint.constant = 24
            self.searchView.layer.cornerRadius = 12
            self.searchView.clipsToBounds = true
            self.searchView.backgroundColor = self.searchBarColor
            self.searchIconView.image = self.searchImage
            self.searchLabel.font = self.searchCollapseFont
            self.searchLabel.textAlignment = .right
            self.searchLabel.text = self.searchText
            self.searchImageTrailingConstraint.priority = UILayoutPriority(rawValue: 750)
            self.searchImageLeadingConstraint.priority = UILayoutPriority(rawValue: 1000)
            self.searchImageViewWidthConstraint.constant = 15
            self.profileBtnTrallingConstraint.constant = 140
            self.headingLabel.text = self.headerText
            self.headingLabel.isHidden = true
            self.layoutIfNeeded()
        })
        
    }
    private func expandSearchView(){
        
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
            self.searchViewTopConstraint.priority = UILayoutPriority(rawValue: 750)
            self.searchViewTopToLabelConstraint.priority = UILayoutPriority(rawValue: 1000)
            self.searchViewWidthConstraint.priority = UILayoutPriority(rawValue: 750)
            self.searchViewLeadingConstraint.priority = UILayoutPriority(rawValue: 1000)
            self.searchViewHeightConstraint.constant = 48
            self.searchView.layer.cornerRadius = 24
            self.searchView.clipsToBounds = true
            self.searchView.backgroundColor = self.searchBarColor
            self.searchIconView.image = self.searchImage
            self.searchLabel.textAlignment = .left
            self.searchLabel.font = self.searchExpandFont
            self.searchLabel.text = self.searchText
            self.searchImageLeadingConstraint.priority = UILayoutPriority(rawValue: 750)
            self.searchImageTrailingConstraint.priority = UILayoutPriority(rawValue: 1000)
            self.searchImageViewWidthConstraint.constant = 24
            self.profileBtnTrallingConstraint.constant = 16
            self.headingLabel.font = self.headerFont
            self.headingLabel.text = self.headerText
            self.headingLabel.isHidden = false
            self.layoutIfNeeded()
        })
    }
    
    
    //MARK: IBACtions
    @IBAction func backBtnTapped(_ sender: Any) {
        delegate?.headerBackBtnTapped()
    }
    @IBAction func profileBtnTapped(_ sender: Any) {
        delegate?.headerProfileBtnTapped()
    }
    @IBAction func searchBtnTapped(_ sender: Any) {
        delegate?.headerSearchBtnTapped()
    }
    @IBAction func cartBtnTapped(_ sender: Any) {
        delegate?.headerCartBtnTapped()
    }
}
