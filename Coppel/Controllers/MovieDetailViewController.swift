//
//  MovieDetailViewController.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 08/02/23.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private let viewModel = MovieDetailViewModel()
    
    var show: Show!
    var backImageView: UIImageView!
    var imageView: UIImageView!
    var titleLbl: UILabel!
    var originalLanguageLbl: UILabel!
    var dateLbl: UILabel!
    var rankingLbl: UILabel!
    var starImageView: UIImageView!
    var descriptionLbl: UILabel!
    var addFavoriteBtn: UIButton!
    
    var companyCollectionView: UICollectionView!
    var videosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupShow()
        configureCollection()
        setupBinding()
        viewModel.fetchShow(id: show.id)
        viewModel.fetchVideos(id: show.id)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        backImageView.bottomCurveS()
    }
    
    private func setupBinding() {
        viewModel.arrCompanies.bindTo { [weak self] _ in
            DispatchQueue.main.async { self?.companyCollectionView.reloadData() }
        }
        viewModel.arrVideos.bindTo { [weak self] _ in
            DispatchQueue.main.async { self?.videosCollectionView.reloadData() }
        }
    }
    
    private func configureCollection() {
        companyCollectionView.dataSource = self
        companyCollectionView.delegate = self
        
        videosCollectionView.dataSource = self
        videosCollectionView.delegate = self
    }
    
    func setupShow() {
        titleLbl.text = show.name
        dateLbl.text = show.first_air_date
        originalLanguageLbl.text = show.original_language
        rankingLbl.text = String(show.vote_average)
        descriptionLbl.text = show.overview
        if let poster = show.poster_path, let url = URL(string: Constant.regularImageBaseURLString + poster)  {
            imageView.kf.setImage(with: url)
        } else { imageView.image = Image.posterDefault?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal) }
        if let backdrop = show.backdrop_path, let url = URL(string: Constant.regularImageBaseURLString + backdrop)  {
            backImageView.kf.setImage(with: url)
        } else { backImageView.image = Image.posterDefault?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal) }
        
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        backImageView = UIImageView()
        backImageView.alpha = 0.4
        backImageView.clipsToBounds = true
        backImageView.contentMode = .scaleAspectFill
        backImageView.image = Image.login
        view.addSubview(backImageView)
        
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Size.cornerRadiusPoster
        
        imageView.image = Image.login
        view.addSubview(imageView)
        
        titleLbl = UILabel(styleType: .subtitle)
        view.addSubview(titleLbl)
        
        dateLbl = UILabel(styleType: .normal)
        view.addSubview(dateLbl)
        
        addFavoriteBtn = UIButton(type: .system)
        addFavoriteBtn.setTitle("Add Favorite", for: .normal)
        addFavoriteBtn.tintColor = .white
        addFavoriteBtn.addTarget(self, action: #selector(favoritePressed(_ :)), for: .touchUpInside)
        view.addSubview(addFavoriteBtn)
        
        originalLanguageLbl = UILabel(styleType: .normal)
        view.addSubview(originalLanguageLbl)
        
        rankingLbl = UILabel(styleType: .normal)
        view.addSubview(rankingLbl)
        
        let configuration = UIImage.SymbolConfiguration(pointSize: Size.fontSmall)
        starImageView = UIImageView()
        starImageView.image = Image.star?.withConfiguration(configuration).withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        view.addSubview(starImageView)
        
        descriptionLbl = UILabel(styleType: .description)
        descriptionLbl.numberOfLines = 0
        view.addSubview(descriptionLbl)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 12.0
        layout.itemSize = CGSize(width: 100.0, height: 120.0)
        layout.scrollDirection = .horizontal
        
        let videoLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        videoLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        videoLayout.minimumInteritemSpacing = 10.0
        videoLayout.minimumLineSpacing = 12.0
        videoLayout.itemSize = CGSize(width: 160.0, height: 120.0)
        videoLayout.scrollDirection = .horizontal
        
        companyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        companyCollectionView.register(CompanyCollectionViewCell.self, forCellWithReuseIdentifier: Constant.companycell)
        companyCollectionView.alwaysBounceHorizontal = true
        companyCollectionView.backgroundColor = .clear
        view.addSubview(companyCollectionView)
        
        videosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: videoLayout)
        
        videosCollectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: Constant.videocell)
        videosCollectionView.alwaysBounceHorizontal = true
        videosCollectionView.backgroundColor = .clear
        view.addSubview(videosCollectionView)
        
        companyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        videosCollectionView.translatesAutoresizingMaskIntoConstraints = false
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        addFavoriteBtn.translatesAutoresizingMaskIntoConstraints = false
        originalLanguageLbl.translatesAutoresizingMaskIntoConstraints = false
        rankingLbl.translatesAutoresizingMaskIntoConstraints = false
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            backImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backImageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.75),
            
            imageView.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: Size.spaceElementMedium),
            imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: Size.spaceElementMedium),
            imageView.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.40),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.3),
            
            companyCollectionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Size.spaceElement),
            companyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            companyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            companyCollectionView.heightAnchor.constraint(equalToConstant: 140.0),

            videosCollectionView.topAnchor.constraint(equalTo: companyCollectionView.bottomAnchor),
            videosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videosCollectionView.heightAnchor.constraint(equalToConstant: 140.0),
            
            titleLbl.topAnchor.constraint(equalTo: margins.topAnchor, constant: Size.spaceElementMedium),
            titleLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: Size.spaceElementMedium),
            titleLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor),

            starImageView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: Size.spaceElement),
            starImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: Size.spaceElementMedium),
            
            rankingLbl.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: Size.spaceElement),
            rankingLbl.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),

            addFavoriteBtn.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            addFavoriteBtn.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            dateLbl.bottomAnchor.constraint(equalTo: addFavoriteBtn.topAnchor, constant: -Size.spaceElement),
            dateLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor),

            originalLanguageLbl.bottomAnchor.constraint(equalTo: dateLbl.topAnchor, constant: -Size.spaceElement),
            originalLanguageLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            descriptionLbl.topAnchor.constraint(equalTo: videosCollectionView.bottomAnchor, constant: 12.0),
            descriptionLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            descriptionLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            descriptionLbl.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
            
        ])
        
    }
    
    @objc func favoritePressed(_ sender: UIButton) {
        viewModel.addFavorite(show: show)
    }

}

extension MovieDetailViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard collectionView == videosCollectionView else { return }
        if let url = URL(string: "\(Constant.youtubeURL)/watch?v=\(viewModel.getVideo(at: indexPath.item).key)") {
            UIApplication.shared.open(url)
        }

    }
    
}

extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == companyCollectionView {
            return viewModel.arrCompanies.value?.count ?? 0
        } else { return viewModel.arrVideos.value?.count ?? 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == companyCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.companycell, for: indexPath) as? CompanyCollectionViewCell {
                
                cell.setupCell(company: viewModel.getCompany(at: indexPath.item))
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.videocell, for: indexPath) as? VideoCollectionViewCell {
                
                cell.setupCell(video: viewModel.getVideo(at: indexPath.item))
                return cell
            }
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}
