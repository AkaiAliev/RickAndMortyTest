//
//  CharactersCollectionViewCell.swift
//  RickAndMortyTest
//
//  Created by Akai on 18/8/23.
//

import UIKit

class CharactersCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = String(describing: CharactersCollectionViewCell.self)
    var characters: Character?
    
    private lazy var characterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.text = "person"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
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
        addSubview(characterView)
        characterView.addSubview(characterImageView)
        characterView.addSubview(characterNameLabel)
    }
    
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            characterView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            characterView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            characterView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            characterView.widthAnchor.constraint(equalTo: self.widthAnchor),
            characterView.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            characterImageView.topAnchor.constraint(equalTo: characterView.topAnchor, constant: 8),
            characterImageView.leadingAnchor.constraint(equalTo: characterView.leadingAnchor, constant: 8),
            characterImageView.trailingAnchor.constraint(equalTo: characterView.trailingAnchor, constant: -8),
            characterImageView.heightAnchor.constraint(equalToConstant: 140),
            
            characterNameLabel.leadingAnchor.constraint(equalTo: characterView.leadingAnchor, constant: 28),
            characterNameLabel.trailingAnchor.constraint(equalTo: characterView.trailingAnchor, constant: -28),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 22),
            characterNameLabel.bottomAnchor.constraint(equalTo: characterView.bottomAnchor, constant: -16)
        ])
    }
    
    func displayInfo(character: Character) {
        characters = character
        characterNameLabel.text = character.name
        
        if let imageURL = URL(string: character.image) {
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let error = error {
                    print("Error downloading image: \(error)")
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.characterImageView.image = image
                    }
                }
            }.resume()
        }
    }
    
}
