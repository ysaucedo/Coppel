//
//  ProfileViewController.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 08/02/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let viewModel = ProfileViewModel()
    
    var titleLbl: UILabel!
    var profileImageView: UIImageView!
    var userLbl: UILabel!
    var subTitleLbl: UILabel!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureCollection()
        setupBinding()
        viewModel.getUser()
        viewModel.fetchFavorites()
        
    }
    
    private func configureCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupBinding() {
        viewModel.user.bindTo { [weak self] _ in
            DispatchQueue.main.async { self?.userLbl.text = self?.viewModel.user.value }
        }
        viewModel.arrFavorites.bindTo { [weak self] _ in
            DispatchQueue.main.async { self?.collectionView.reloadData() }
        }
    }
    
    private func setupUI() {
        
        view.backgroundColor = .black
        
        titleLbl = UILabel(styleType: .title)
        titleLbl.text = Text.profile
        userLbl = UILabel(styleType: .normal)
        subTitleLbl = UILabel(styleType: .subtitle)
        subTitleLbl.text = Text.favoriteShows
        
        profileImageView = UIImageView(image: Image.profile?.withTintColor(.lightGray, renderingMode: .alwaysOriginal) )
        profileImageView.layer.cornerRadius = Size.imageProfile/2
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
                
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 24.0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2 - 20, height: 360)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: Constant.moviecell)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLbl)
        userLbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userLbl)
        subTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subTitleLbl)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: margins.topAnchor, constant: Size.spaceElementLarge),
            titleLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: Size.imageProfile),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 1.0),
            profileImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: Size.spaceElementLarge),
            profileImageView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: Size.spaceElementLarge),
            userLbl.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            userLbl.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Size.spaceElement),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 380),
            subTitleLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            subTitleLbl.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -Size.spaceElement)
        ])
        
    }
    
    func makeContextMenu(for index: Int) -> UIMenu {
        let favorites = UIAction(title: Text.deleteFavorites, image: Image.favorite, attributes: .destructive) { action in
            self.viewModel.removeFavorite(by: self.viewModel.getFavorite(at: index).id)
            self.viewModel.fetchFavorites()
        }
        
        return UIMenu(title: Text.actions, children: [favorites])
        
    }

}

extension ProfileViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in

            return self.makeContextMenu(for: indexPath.row)
        })
        
    }
    
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewModel.arrFavorites.value?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.moviecell, for: indexPath) as? MovieCollectionViewCell {
            cell.setupCell(show: viewModel.getFavorite(at: indexPath.item))
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}
