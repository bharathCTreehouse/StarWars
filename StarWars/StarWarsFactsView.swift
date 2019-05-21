//
//  StarWarsFactsView.swift
//  StarWars
//
//  Created by Bharath on 20/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit

protocol StarWarsFactsViewDataSource: class {
    var facts: [ [String: String] ] { get }
}


class StarWarsFactsView: UIView {
    
    @IBOutlet weak var firstAttributeLabel: UILabel!
    @IBOutlet weak var firstValueLabel: UILabel!
    @IBOutlet weak var secondAttributeLabel: UILabel!
    @IBOutlet weak var secondValueLabel: UILabel!
    
    private weak var factsView: UIView? = nil
    weak var factsDataSource: StarWarsFactsViewDataSource? = nil
    
    
    init(withDataSource dataSource: StarWarsFactsViewDataSource) {
        
        factsDataSource = dataSource
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        setupFactsView()
        reloadView()
        
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupFactsView() {
        
        factsView = Bundle.main.loadNibNamed("StarWarsFactsView", owner: self, options: nil)?.first! as? UIView
        factsView!.translatesAutoresizingMaskIntoConstraints = false
        addSubview(factsView!)
        
        factsView!.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        factsView!.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        factsView!.topAnchor.constraint(equalTo: topAnchor).isActive = true
        factsView!.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    func reloadView() {
        
        let firstMappingPair: [String: String] = factsDataSource!.facts.first!
        firstAttributeLabel.text = firstMappingPair.keys.first!
        firstValueLabel.text = firstMappingPair.values.first!
        
        let secondMappingPair: [String: String] = factsDataSource!.facts.last!
        secondAttributeLabel.text = secondMappingPair.keys.first!
        secondValueLabel.text = secondMappingPair.values.first!
        
    }
    
    
    
    
    deinit {
        firstAttributeLabel = nil
        firstValueLabel = nil
        secondAttributeLabel = nil
        secondValueLabel = nil
        factsView = nil
        factsDataSource = nil
    }

    
}
