//
//  CharacterImageCustomView.swift
//  RickAndMortyTest
//
//  Created by Akai on 18/8/23.
//

import UIKit

class CharacterImageCustomView: UIView {
    
    private var characterDetailedInfo: Character?
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
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
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Alive"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        addSubview(characterImageView)
        addSubview(characterNameLabel)
        addSubview(characterStatusLabel)
        
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            characterImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            characterImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            characterImageView.widthAnchor.constraint(equalToConstant: 148),
            characterImageView.heightAnchor.constraint(equalToConstant: 148),
            
            characterNameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 24),
            characterNameLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            characterStatusLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 8),
            characterStatusLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            characterStatusLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func fetchCharacterInfo(from characterURL: String) {
        guard let url = URL(string: characterURL) else {
            return
        }
        
        print("Fetching character origin from URL: \(characterURL)")
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  error == nil
            else {
                print("Error fetching character data: \(error?.localizedDescription ?? "")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let character = try decoder.decode(Character.self, from: data)
                
                DispatchQueue.main.async {
                    self.characterDetailedInfo = character
                    self.displayInfo()
                }
            } catch {
                print("Error decoding character data: \(error)")
            }
        }
        
        task.resume()
    }
    
    private func displayInfo() {
        guard let character = characterDetailedInfo else {
            return
        }
        
        characterNameLabel.text = character.name
        characterStatusLabel.text = character.status.rawValue
        
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

