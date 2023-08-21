//
//  CharacterDetailedInfoViewController.swift
//  RickAndMortyTest
//
//  Created by Akai on 18/8/23.
//

import UIKit

class CharacterDetailedInfoViewController: UIViewController {
    
    var episodes: [Episode] = []
    var pageInfo: PageInfo?
    var character: Character?
    
    lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 1200)
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentSize = contentSize
        scrollView.frame = view.bounds
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.bounces = true
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var characterPhotoCustomView: CharacterImageCustomView = {
        let view = CharacterImageCustomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var characterInfoCustomView: CharacterInfoCustomView = {
        let view = CharacterInfoCustomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var characterOriginCustomView: CharacterOriginCustomView = {
        let view = CharacterOriginCustomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var episodesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Episodes"
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
    
    private lazy var episodesCollectionView: UICollectionView = {
        var viewLayout = UICollectionViewFlowLayout()
        viewLayout.itemSize = CGSize(width: 350, height: 86)
        viewLayout.scrollDirection = .vertical
        viewLayout.minimumLineSpacing = 16
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            EpisodesCollectionViewCell.self,
            forCellWithReuseIdentifier: EpisodesCollectionViewCell.reuseID
        )
        collectionView.register(
            LoadingCollectionViewCell.self,
            forCellWithReuseIdentifier: LoadingCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.01332890149, green: 0.04810451716, blue: 0.1187042817, alpha: 1)
        fetchEpisodes(pageURL: "https://rickandmortyapi.com/api/episode")
        fetchCharacterInfo()
        fetchCharacterOrigin()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    func fetchEpisodes(pageURL: String) {
        guard let url = URL(string: pageURL) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  error == nil
            else {
                print("Error fetching data: \(error?.localizedDescription ?? "")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let episodeResponse = try decoder.decode(EpisodeResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self.updateEpisodes(episodeResponse.results)
                    self.pageInfo = episodeResponse.info
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        
        task.resume()
    }
    
    func updateEpisodes(_ episodes: [Episode]) {
        self.episodes = episodes
        DispatchQueue.main.async {
            self.episodesCollectionView.reloadData()
        }
    }
    
    
    func fetchCharacterInfo() {
        guard let characterURL = character?.url else {
            return
        }
        characterPhotoCustomView.fetchCharacterInfo(from: characterURL)
        characterInfoCustomView.fetchCharacterInfo(from: characterURL)
    }
    
    func fetchCharacterOrigin() {
        guard let characterURL = character?.url else {
            return
        }
        
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
                    self.character = character
                    self.characterOriginCustomView.fetchLocationInfo(from: character.origin.url)
                }
            } catch {
                print("Error decoding character data: \(error)")
            }
        }
        
        task.resume()
    }
}

extension CharacterDetailedInfoViewController {
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(characterPhotoCustomView)
        stackView.addArrangedSubview(characterInfoCustomView)
        stackView.addArrangedSubview(characterOriginCustomView)
        stackView.addArrangedSubview(episodesTitleLabel)
        stackView.addArrangedSubview(episodesCollectionView)
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            mainScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            mainScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            mainScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            contentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: 0),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            characterPhotoCustomView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0),
            characterPhotoCustomView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            characterPhotoCustomView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0),
            characterPhotoCustomView.heightAnchor.constraint(equalToConstant: 250),
            
            characterInfoCustomView.topAnchor.constraint(equalTo: characterPhotoCustomView.bottomAnchor, constant: 24),
            characterInfoCustomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            characterInfoCustomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            characterInfoCustomView.heightAnchor.constraint(equalToConstant: 165),
            
            characterOriginCustomView.topAnchor.constraint(equalTo: characterInfoCustomView.bottomAnchor, constant: 24),
            characterOriginCustomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            characterOriginCustomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            characterOriginCustomView.heightAnchor.constraint(equalToConstant: 120),
            
            episodesTitleLabel.topAnchor.constraint(equalTo: characterOriginCustomView.bottomAnchor, constant: 24),
            episodesTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            episodesTitleLabel.widthAnchor.constraint(equalToConstant: 100),
            episodesTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            episodesCollectionView.topAnchor.constraint(equalTo: episodesTitleLabel.bottomAnchor, constant: 16),
            episodesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            episodesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            episodesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

extension CharacterDetailedInfoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodesCollectionViewCell.reuseID, for: indexPath) as! EpisodesCollectionViewCell
        let episode = episodes[indexPath.item]
        cell.displayInfo(episodes: episode)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let lastItemIndex = collectionView.numberOfItems(inSection: 0) - 1
        if indexPath.item == lastItemIndex, let nextPageURL = pageInfo?.next {
            fetchEpisodes(pageURL: nextPageURL)
        }
    }
}

extension CharacterDetailedInfoViewController: UICollectionViewDelegate {
    
}


extension CharacterDetailedInfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 86)
    }
}


