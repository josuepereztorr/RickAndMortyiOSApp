//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Josue Perez  on 4/13/23.
//

import UIKit

/// View that handles showing list of characters etc..
final class RMCharacterListView: UIView {
    
    // INSTANCE OF VIEW MODEL
    // View Model that has the UICollectionView DataSource and Delegate
    private let viewModel = RMCharacterListViewViewModel()
    
    // https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization#Setting-a-Default-Property-Value-with-a-Closure-or-Function
    // DEFAULT PROPERTY BY USING A CLOSURE
    // THE CLOSURE IS CREATED WITH TEMPORARY VALUES WHICH THEN GET RETURNED. FINALLY THE CLOSURE IS EXECUTED AND RETURNS A VALUE.
    // UIActivityIndicatorView - A view that shows that a task is in progress.
    private let spinner: UIActivityIndicatorView = {
        
        // create a new spinner
        let spinner = UIActivityIndicatorView(style: .large)
        
        // A Boolean value that controls whether the activity indicator is hidden when the animation is stopped.
        // We want this to be hidden at creation time
        spinner.hidesWhenStopped = true
        
        // we are setting this to false because we will be specifying the contraints manually without storyboards
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        return spinner
    }()
    
    // UICollectionView
    private let collectionView: UICollectionView = {
        
        // create a new custom layout for the collection view
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        // If the delegate object does not implement the collectionView(_:layout:insetForSectionAt:) method, the flow layout uses the value in this property to set the margins for each section.
        // This adds margins on the UICollectionView
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        // hide the collection view until the data is fetched
        collectionView.isHidden = true
        
        // alpha is opacity, make it invisiable until we get data
        collectionView.alpha = 0
        
        // we are setting this to false because we will be specifying the contraints manually without storyboards
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // the collection view needs to know what type of cell (class) to create and a identifier
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
        
        return collectionView
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // we are setting this to false because we will be specifying the contraints manually without storyboards
        translatesAutoresizingMaskIntoConstraints = false
        
        // custom method to add multiple views in order
        addSubviews(collectionView, spinner)
        
        // adds the spinner and collection view contraints
        addConstraint()
        
        // starts the animation of the progress indicator when the CharacterListView is created
        spinner.startAnimating()
        
        viewModel.delegate = self
        
        // TALKS TO THE VIEW MODEL
        // makes the API request for the data.
        viewModel.fetchCharacters()
        
        //
        setupCollectionView();
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsuppored")
    }
    
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            // sets the width and height of the spinner view to 100
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            
            // sets the spinner to be centered to the parent view (CharacterListView)
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // sets the collection view anchors to match the parent view anchors
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        
        // WHY AREN'T THE DATASOURCE AND DELEGATE SET WHEN THE PROPERTY IS CREATED??
        
        // the object that provides the data to the UICollectionView
        collectionView.dataSource = viewModel
        
        // The delegate object is responsible for managing selection behavior and interactions with individual items.
        collectionView.delegate = viewModel
        
    }
    
}

extension RMCharacterListView: RMCharacterListViewModelVieModelDelegate {
    func didLoadInitialCharacters() {
        
        spinner.stopAnimating()
        
        collectionView.isHidden = false
        collectionView.reloadData() // initial fetch

        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
}
