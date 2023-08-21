//
//  EpisodesCollectionViewCell.swift
//  RickAndMortyTest
//
//  Created by Akai on 18/8/23.
//

import UIKit

class EpisodesCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = String(describing: EpisodesCollectionViewCell.self)
    
    var episode: Episode?
    
    private lazy var episodeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = #colorLiteral(red: 0.1501607299, green: 0.1651831865, blue: 0.2201651633, alpha: 1)
        return view
    }()
    
    private lazy var episodeNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var episodeNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = .systemFont(ofSize: 13 , weight: .regular)
        label.textColor = .green
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = #colorLiteral(red: 0.5767868161, green: 0.59672755, blue: 0.6135697365, alpha: 1)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = #colorLiteral(red: 0.1501607299, green: 0.1651831865, blue: 0.2201651633, alpha: 1)
        layer.cornerRadius = 16
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        addSubview(episodeView)
        episodeView.addSubview(episodeNameLabel)
        episodeView.addSubview(episodeNumberLabel)
        episodeView.addSubview(dateLabel)
    }
    
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            episodeView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            episodeView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            episodeView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            episodeView.heightAnchor.constraint(equalToConstant: 86),
            
            episodeNameLabel.topAnchor.constraint(equalTo: episodeView.topAnchor, constant: 16),
            episodeNameLabel.leadingAnchor.constraint(equalTo: episodeView.leadingAnchor, constant: 16),
            episodeNameLabel.widthAnchor.constraint(equalToConstant: 150),
            episodeNameLabel.heightAnchor.constraint(equalToConstant: 22),
            
            episodeNumberLabel.topAnchor.constraint(equalTo: episodeNameLabel.bottomAnchor, constant: 16),
            episodeNumberLabel.leadingAnchor.constraint(equalTo: episodeView.leadingAnchor, constant: 16),
            episodeNumberLabel.widthAnchor.constraint(equalToConstant: 150),
            episodeNumberLabel.heightAnchor.constraint(equalToConstant: 18),
            
            dateLabel.topAnchor.constraint(equalTo: episodeView.topAnchor, constant: 54),
            dateLabel.trailingAnchor.constraint(equalTo: episodeView.trailingAnchor, constant: -16),
            dateLabel.widthAnchor.constraint(equalToConstant: 150),
            dateLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func displayInfo(episodes: Episode) {
        episode = episodes
        episodeNameLabel.text = episodes.name
        episodeNumberLabel.text = episodes.episode
        dateLabel.text = episodes.airDate
    }
}
