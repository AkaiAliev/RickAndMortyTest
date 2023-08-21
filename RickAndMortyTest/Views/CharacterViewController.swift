//
//  CharacterViewController.swift
//  RickAndMortyTest
//
//  Created by Akai on 18/8/23.
//

import UIKit

class CharacterViewController: UIViewController {
    
    var characters: [Character] = []
    var pageInfo: PageInfo?
    
    private lazy var charactersCollectionView: UICollectionView = {
        var viewLayout = UICollectionViewFlowLayout()
        viewLayout.itemSize = CGSize(width: 156, height: 202)
        viewLayout.scrollDirection = .vertical
        viewLayout.minimumLineSpacing = 16
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            CharactersCollectionViewCell.self,
            forCellWithReuseIdentifier: CharactersCollectionViewCell.reuseID
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
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.01332890149, green: 0.04810451716, blue: 0.1187042817, alpha: 1)
        self.navigationItem.title = "Characters"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        fetchCharacters(pageURL: "https://rickandmortyapi.com/api/character")
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    func fetchCharacters(pageURL: String) {
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
                let characterResponse = try decoder.decode(CharacterResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self.characters += characterResponse.results
                    self.pageInfo = characterResponse.info
                    self.charactersCollectionView.reloadData()
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        
        task.resume()
    }
}

extension CharacterViewController {
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        view.addSubview(charactersCollectionView)
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            charactersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            charactersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            charactersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            charactersCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}

extension CharacterViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.reuseID, for: indexPath) as! CharactersCollectionViewCell
        let character = characters[indexPath.item]
        cell.displayInfo(character: character)
        return cell
    }
}

extension CharacterViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCharacter = characters[indexPath.item]
        let detailVC = CharacterDetailedInfoViewController()
        detailVC.character = selectedCharacter
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItemIndex = collectionView.numberOfItems(inSection: 0) - 1
        if indexPath.item == lastItemIndex, let nextPageURL = pageInfo?.next {
            fetchCharacters(pageURL: nextPageURL)
        }
    }
}

extension CharacterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 156, height: 202)
    }
}
