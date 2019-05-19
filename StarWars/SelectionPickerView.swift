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


class SelectionPickerView: UIView {
    
    private var picketView: UIPickerView = UIPickerView()
    private(set) var titles: [String]
    weak var delegate: SelectionPickerViewProtocol? = nil
    
    
    init(withList list: [String], delegate: SelectionPickerViewProtocol) {
        
        titles = list
        self.delegate = delegate
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupPickerView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupPickerView() {
        
        picketView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(picketView)
        picketView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        picketView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        picketView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        picketView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        picketView.delegate = self
        picketView.dataSource = self
        
        backgroundColor = UIColor.yellow
        
    }
    
    
    func updateTitleList(withList list: [String]) {
        titles = list
        picketView.reloadAllComponents()
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
