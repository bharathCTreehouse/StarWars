//
//  StarWarsActivityIndicatorView.swift
//  StarWars
//
//  Created by Bharath on 23/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


enum StarWarsActivityViewButtonAttribute {
    case title(String)
    case titleColor(UIColor)
    case titleFont(UIFont)
}

enum StarWarsActivityIndicatorAttribute {
    case style(UIActivityIndicatorView.Style)
    case color(UIColor)
}


protocol StarWarsActivityViewDataSource: class {
    var buttonAttributes: [StarWarsActivityViewButtonAttribute] { get }
    var activityIndicatorAttribute: StarWarsActivityIndicatorAttribute { get }
    var backgroundColor: UIColor { get }
}


extension StarWarsActivityViewDataSource {
    var backgroundColor: UIColor {
        return UIColor.white
    }
}



class StarWarsActivityIndicatorView: UIView {
    
    @IBOutlet private(set) weak var button: UIButton!
    @IBOutlet private(set) weak var activityIndicatorView: UIActivityIndicatorView!
    weak private(set) var view: UIView?
    weak private(set) var dataSource: StarWarsActivityViewDataSource?
    var buttonActionCompletionHandler: (() -> Void)?
    
    
    init(withDataSource dataSource: StarWarsActivityViewDataSource, buttonActionHandler handler: @escaping () -> Void) {
        
        self.dataSource = dataSource
        buttonActionCompletionHandler = handler
        
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        view = Bundle.main.loadNibNamed("StarWarsActivityIndicatorView", owner: self, options: nil)?.first! as? UIView
        view!.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view!)
        view!.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view!.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view!.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view!.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        view!.backgroundColor = dataSource.backgroundColor
        
        configureButton()
        configureActivityView()
        
        animateActivityIndicator(false)
        
        layer.borderWidth = 0.3
        layer.borderColor = button.currentTitleColor.cgColor
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        buttonActionCompletionHandler?()
    }
    
    
    func configureButton() {
        
        for (_, data) in (dataSource?.buttonAttributes.enumerated())! {
            
            switch (data) {
                case .title(let buttonTitle): button.setTitle(buttonTitle, for: .normal)
                case .titleColor(let titleColor): button.setTitleColor(titleColor, for: .normal)
                case .titleFont(let titleFont): button.titleLabel?.font = titleFont
            }
        }
    }
    
    
    func configureActivityView() {
        
        switch (dataSource!.activityIndicatorAttribute) {
            
            case .color(let activityIndicatorColor): activityIndicatorView.color = activityIndicatorColor
            case .style(let activityIndicatorStyle): activityIndicatorView.style = activityIndicatorStyle
        }
    }
    
    
    
    func animateActivityIndicator(_ animate: Bool) {
        
        if animate == true {
            activityIndicatorView.startAnimating()
        }
        else {
            activityIndicatorView.stopAnimating()
        }
        button.isEnabled = !animate
    }
    
    
    
    deinit {
        button = nil
        activityIndicatorView = nil
        view = nil
        dataSource = nil
    }

    
}
