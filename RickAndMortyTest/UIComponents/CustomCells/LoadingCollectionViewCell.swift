//
//  LoadingCollectionViewCell.swift
//  RickAndMortyTest
//
//  Created by Akai on 18/8/23.
//

import UIKit

class LoadingCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier = String(describing: LoadingCollectionViewCell.self)
    
    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        setUpSubviews()
        setupConstraints()
    }
    
    private func setUpSubviews() {
        addSubview(loadingIndicator)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            loadingIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
