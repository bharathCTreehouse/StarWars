//
//  StarWarsAccessoryDetailView.swift
//  StarWars
//
//  Created by Bharath on 17/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

protocol StarWarsAccessoryButtonProtocol: class {
    func toggleUnitSegmentControl(withSelectedIndex index: Int)
    var  segmentControlTitles: [String] { get }
}


extension StarWarsAccessoryButtonProtocol {
    
    var segmentControlTitles: [String] {
        return ["First", "Second"]
    }
}



class StarWarsAccessoryDetailView: UIView {
    
    @IBOutlet weak private(set) var attributeLabel: UILabel!
    @IBOutlet weak private(set) var attributeValueLabel: UILabel!
    @IBOutlet weak private(set) var unitToggleSegmentControl: UISegmentedControl!
    
    weak var view: UIView? = nil
    weak var accessoryDelegate: StarWarsAccessoryButtonProtocol? = nil

    
    init(withDelegate delegate: StarWarsAccessoryButtonProtocol) {
        
        accessoryDelegate = delegate
        
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        view = (Bundle.main.loadNibNamed("StarWarsAccessoryDetailView", owner: self, options: nil)?.first! as! UIView)
        view!.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view!)
        
        view!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view!.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        view!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @IBAction func segmentControlTapped(sender: UISegmentedControl) {
        
        accessoryDelegate?.toggleUnitSegmentControl(withSelectedIndex: sender.selectedSegmentIndex)
    }
    
    
    
    func updateSegmentControlTitles(withList list: [String]) {
        
        if list.isEmpty == false {
            self.unitToggleSegmentControl.setTitle(list.first!, forSegmentAt: 0)
            self.unitToggleSegmentControl.setTitle(list[1], forSegmentAt: 1)
        }
    }
    
    
    deinit {
        attributeLabel = nil
        attributeValueLabel = nil
        unitToggleSegmentControl = nil
        view = nil
        accessoryDelegate = nil
    }
    
  

}
