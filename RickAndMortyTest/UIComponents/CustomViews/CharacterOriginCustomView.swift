//
//  CharacterOriginCustomView.swift
//  RickAndMortyTest
//
//  Created by Akai on 18/8/23.
//

import UIKit

class CharacterOriginCustomView: UIView {
    
    private var locationDetailedInfo: Location?
    
    private lazy var originTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Origin"
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
    
    private lazy var originView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = #colorLiteral(red: 0.1501607299, green: 0.1651831865, blue: 0.2201651633, alpha: 1)
        return view
    }()
    
    private lazy var originImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    
    private lazy var planetNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Earth"
        label.textAlignment = .right
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var planetTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Planet"
        label.textAlignment = .right
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = .systemFont(ofSize: 13, weight: .regular)
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
        addSubview(originTitleLabel)
        addSubview(originView)
        originView.addSubview(originImageView)
        originView.addSubview(planetNameLabel)
        originView.addSubview(planetTypeLabel)
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            originTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            originTitleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            originTitleLabel.widthAnchor.constraint(equalToConstant: 50),
            originTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            originView.topAnchor.constraint(equalTo: originTitleLabel.bottomAnchor, constant: 16),
            originView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            originView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            originView.heightAnchor.constraint(equalToConstant: 80),
            
            originImageView.topAnchor.constraint(equalTo: originView.topAnchor, constant: 8),
            originImageView.leadingAnchor.constraint(equalTo: originView.leadingAnchor, constant: 8),
            originImageView.widthAnchor.constraint(equalToConstant: 64),
            originImageView.heightAnchor.constraint(equalToConstant: 64),
            
            planetNameLabel.topAnchor.constraint(equalTo: originView.topAnchor, constant: 16),
            planetNameLabel.trailingAnchor.constraint(equalTo: originView.trailingAnchor, constant: -198),
            planetNameLabel.widthAnchor.constraint(equalToConstant: 50),
            planetNameLabel.heightAnchor.constraint(equalToConstant: 22),
            
            planetTypeLabel.topAnchor.constraint(equalTo: planetNameLabel.bottomAnchor, constant: 8),
            planetTypeLabel.trailingAnchor.constraint(equalTo: originView.trailingAnchor, constant: -201),
            planetTypeLabel.widthAnchor.constraint(equalToConstant: 50),
            planetTypeLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func fetchLocationInfo(from locationURL: String) {
        guard let url = URL(string: locationURL) else {
            return
        }
        
        print("Fetching location info from URL: \(locationURL)")
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  error == nil
            else {
                print("Error fetching location data: \(error?.localizedDescription ?? "")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let location = try decoder.decode(Location.self, from: data)
                
                DispatchQueue.main.async {
                    self.locationDetailedInfo = location
                    self.displayInfo()
                }
            } catch {
                print("Error decoding location data: \(error)")
            }
        }
        
        task.resume()
    }
    
    private func displayInfo() {
        guard let location = locationDetailedInfo else {
            print("No location data available")
            return
        }
        
        print("Displaying location info: \(location)")
        
        
        if let imageURL = URL(string: location.url) {
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let error = error {
                    print("Error downloading image: \(error)")
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.originImageView.image = image
                    }
                }
            }.resume()
        }
        
        planetNameLabel.text = location.name
        planetTypeLabel.text = location.type
    }
}
