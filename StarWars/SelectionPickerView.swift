//
//  SelectionPickerView.swift
//  StarWars
//
//  Created by Bharath on 19/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


protocol SelectionPickerViewProtocol: class {
    func selectedPickerIndex(index: Int)
}

protocol SelectionPickerAdditionalViewProtocol: class {
    func additionalViewTapped()
}


class SelectionPickerView: UIView {
    
    private var picketView: UIPickerView = UIPickerView()
    private(set) var titles: [String]
    weak var delegate: SelectionPickerViewProtocol? = nil
    
    weak var additionalViewDataSource: StarWarsActivityViewDataSource? = nil
    weak var additionalViewDelegate: SelectionPickerAdditionalViewProtocol? = nil
    var activityView: StarWarsActivityIndicatorView? = nil

    
    
    init(withList list: [String], delegate: SelectionPickerViewProtocol?, additionalViewDataSource: StarWarsActivityViewDataSource?, additionalViewDelegate: SelectionPickerAdditionalViewProtocol?) {
        
        titles = list
        self.delegate = delegate
        self.additionalViewDataSource = additionalViewDataSource
        self.additionalViewDelegate = additionalViewDelegate
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSubviews() {
        
        picketView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(picketView)
        
        if let additionalViewDataSource = additionalViewDataSource {
            
            activityView = StarWarsActivityIndicatorView (withDataSource: additionalViewDataSource, buttonActionHandler: { [unowned self] () -> Void in
                
                self.additionalViewDelegate?.additionalViewTapped()
            })
            
            addSubview(activityView!)
            activityView!.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            activityView!.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            activityView!.topAnchor.constraint(equalTo: topAnchor).isActive = true
            
            picketView.topAnchor.constraint(equalTo: activityView!.bottomAnchor).isActive = true
            
        }
        else {
            picketView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        }
        
        picketView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        picketView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        picketView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        picketView.delegate = self
        picketView.dataSource = self
        
        backgroundColor = UIColor.white
        
    }
    
    
    func updateTitleList(withList list: [String]) {
        titles = list
        picketView.reloadAllComponents()
    }
    
    
    func toggleAdditionalViewToInProgressState(_ inProgress: Bool) {
        self.activityView?.animateActivityIndicator(inProgress)
    }
    
    
    deinit {
        additionalViewDataSource = nil
        delegate = nil
        additionalViewDelegate = nil
    }
}


extension SelectionPickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.titles.count
        
    }
}



extension SelectionPickerView: UIPickerViewDelegate {
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return titles[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        delegate?.selectedPickerIndex(index: row)
    }

    
}
