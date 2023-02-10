//
//  MoviesViewController.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 07/02/23.
//

import UIKit

class MoviesViewController: UIViewController {
    
    private let viewModel = MoviesViewModel()

    var categorySegmented: UISegmentedControl!
    var collectionView: UICollectionView!
    var showLoader: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationBar()
        configureCollection()
        setupBinding()
        if showLoader { viewModel.loaderProtocol = self }
        viewModel.typeShow = .popular
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func setupBinding() {
        viewModel.arrShows.bindTo { [weak self] _ in
            DispatchQueue.main.async { self?.collectionView.reloadData() }
        }
    }
    
    private func configureCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupUI() {
        
        navigationController?.setNavigationBarHidden(false, animated: false)

        self.title = Text.tvShows
        view.backgroundColor = .black

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Image.list?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(menuOptions(_ :)))

        
        categorySegmented = UISegmentedControl(items: [Text.popular, Text.topRated, Text.onTV, Text.airing])
        categorySegmented.addTarget(self, action: #selector(categoryValueChanged(_:)), for: .valueChanged)
        //loginBtn.addTarget(self, action: #selector(loginBtnPressed(_ :)), for: .touchUpInside)
        
        categorySegmented.selectedSegmentIndex = 0
        categorySegmented.selectedSegmentTintColor = .darkGray
        categorySegmented.backgroundColor = .darkGray.withAlphaComponent(0.2)
        categorySegmented.setTitleTextAttributes([.foregroundColor: UIColor.systemGray4], for: .selected)
        categorySegmented.setTitleTextAttributes([.foregroundColor: UIColor.systemGray4], for: .normal)
        
        view.addSubview(categorySegmented)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 24.0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2 - 20, height: 360)
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: Constant.moviecell)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        categorySegmented.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([

            categorySegmented.topAnchor.constraint(equalTo: margins.topAnchor, constant: Size.spaceElementMedium),
            categorySegmented.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            categorySegmented.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: categorySegmented.bottomAnchor, constant: Size.spaceElement),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
    }
    
    private func setupNavigationBar() {
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            appearance.backgroundColor = UIColor.init(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    @objc private func categoryValueChanged(_ sender: UISegmentedControl!) {
        switch sender.selectedSegmentIndex {
        case 0: viewModel.typeShow = .popular
        case 1: viewModel.typeShow = .topRated
        case 2: viewModel.typeShow = .onTV
        case 3: viewModel.typeShow = .airingToday
        default: viewModel.typeShow = .popular
        }
    }
            
    @objc private func menuOptions(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "", message: Text.whatDo, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Text.viewProfile, style: .default, handler: { [weak self] _ in
            
            guard let self = self else { return }
            
            let vc = self.viewModel.instanciateProfile()
            self.present(vc, animated: true, completion: nil)

        }))
        alert.addAction(UIAlertAction(title: Text.logout, style: .destructive, handler: { [weak self] _ in
            
            guard let self = self else { return }
            
            self.navigationController?.popToRootViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: Text.cancel, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func makeContextMenu(for index: Int) -> UIMenu {
        let favorites = UIAction(title: Text.addFavorites, image: Image.favorite) { [weak self] action in
            guard let self = self else { return }
            self.viewModel.addFavorite(show: self.viewModel.getShow(at: index))
        }
        
        return UIMenu(title: Text.actions, children: [favorites])
        
    }

}

// MARK: - UIScrollViewDelegate Conformance
extension MoviesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height {
            if !viewModel.scrollActivate {
                viewModel.service.nextPage()
                viewModel.fetchShows()
            }
        }
    }
}

extension MoviesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let vc = viewModel.instanciateDetail() as! MovieDetailViewController
        vc.show = viewModel.getShow(at: indexPath.item)
        self.present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in

            return self.makeContextMenu(for: indexPath.row)
        })
        
    }
    
}

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewModel.arrShows.value?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.moviecell, for: indexPath) as? MovieCollectionViewCell {
            cell.setupCell(show: viewModel.getShow(at: indexPath.item))
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}

extension MoviesViewController: LoaderProtocol {
    func startLoading() {
        let vc = viewModel.instanciateLoader()
        present(vc, animated: false, completion: nil)
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            if let vc = self.navigationController?.visibleViewController {
                if vc.isKind(of: LoaderViewController.self) {         self.navigationController?.visibleViewController?.dismiss(animated: false)
                }
            }
        }
    }
    
}
