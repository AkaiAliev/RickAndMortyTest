//
//  CharacterInfoCustomView.swift
//  RickAndMortyTest
//
//  Created by Akai on 18/8/23.
//

import UIKit

class CharacterInfoCustomView: UIView {
    
    private var charactersDetailedInfo: Character?
    
    private lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Info"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = #colorLiteral(red: 0.1501607299, green: 0.1651831865, blue: 0.2201651633, alpha: 1)
        return view
    }()
    
    private lazy var speciesLabel: UILabel = {
        let label = UILabel()
        label.text = "Species:"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = #colorLiteral(red: 0.76896137, green: 0.7888869643, blue: 0.8057363033, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type:"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = #colorLiteral(red: 0.76896137, green: 0.7888869643, blue: 0.8057363033, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender:"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = #colorLiteral(red: 0.76896137, green: 0.7888869643, blue: 0.8057363033, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var speciesInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Human"
        label.textAlignment = .right
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var typeInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "None"
        label.textAlignment = .right
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genderInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "None"
        label.textAlignment = .right
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
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
        addSubview(infoTitleLabel)
        addSubview(characterView)
        characterView.addSubview(speciesLabel)
        characterView.addSubview(typeLabel)
        characterView.addSubview(genderLabel)
        characterView.addSubview(speciesInfoLabel)
        characterView.addSubview(typeInfoLabel)
        characterView.addSubview(genderInfoLabel)
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            infoTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            infoTitleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            infoTitleLabel.widthAnchor.constraint(equalToConstant: 50),
            infoTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            characterView.topAnchor.constraint(equalTo: infoTitleLabel.bottomAnchor, constant: 16),
            characterView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            characterView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            characterView.heightAnchor.constraint(equalToConstant: 124),
            
            speciesLabel.topAnchor.constraint(equalTo: characterView.topAnchor, constant: 16),
            speciesLabel.leadingAnchor.constraint(equalTo: characterView.leadingAnchor, constant: 16),
            speciesLabel.widthAnchor.constraint(equalToConstant: 65),
            speciesLabel.heightAnchor.constraint(equalToConstant: 20),
            
            typeLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 16),
            typeLabel.leadingAnchor.constraint(equalTo: characterView.leadingAnchor, constant: 16),
            typeLabel.widthAnchor.constraint(equalToConstant: 65),
            typeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            genderLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 16),
            genderLabel.leadingAnchor.constraint(equalTo: characterView.leadingAnchor, constant: 16),
            genderLabel.widthAnchor.constraint(equalToConstant: 65),
            genderLabel.heightAnchor.constraint(equalToConstant: 20),
            
            speciesInfoLabel.topAnchor.constraint(equalTo: characterView.topAnchor, constant: 16),
            speciesInfoLabel.trailingAnchor.constraint(equalTo: characterView.trailingAnchor, constant: -16),
            speciesInfoLabel.widthAnchor.constraint(equalToConstant: 65),
            speciesInfoLabel.heightAnchor.constraint(equalToConstant: 20),
            
            typeInfoLabel.topAnchor.constraint(equalTo: speciesInfoLabel.bottomAnchor, constant: 16),
            typeInfoLabel.trailingAnchor.constraint(equalTo: characterView.trailingAnchor, constant: -16),
            typeInfoLabel.widthAnchor.constraint(equalToConstant: 65),
            typeInfoLabel.heightAnchor.constraint(equalToConstant: 20),
            
            genderInfoLabel.topAnchor.constraint(equalTo: typeInfoLabel.bottomAnchor, constant: 16),
            genderInfoLabel.trailingAnchor.constraint(equalTo: characterView.trailingAnchor, constant: -16),
            genderInfoLabel.widthAnchor.constraint(equalToConstant: 65),
            genderInfoLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func fetchCharacterInfo(from characterURL: String) {
        guard let url = URL(string: characterURL) else {
            return
        }
        
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
                    self.charactersDetailedInfo = character
                    self.displayInfo()
                }
            } catch {
                print("Error decoding character data: \(error)")
            }
        }
        
        task.resume()
    }
    
    private func displayInfo() {
        guard let character = charactersDetailedInfo else {
            return
        }
        typeInfoLabel.text = character.type
        genderInfoLabel.text = character.gender.rawValue
    }
}
