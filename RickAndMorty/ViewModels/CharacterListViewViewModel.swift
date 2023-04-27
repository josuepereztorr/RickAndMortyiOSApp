//
//  RMCharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Josue Perez  on 4/13/23.
//

import Foundation
import UIKit

protocol RMCharacterListViewModelVieModelDelegate: AnyObject {
    func didLoadInitialCharacters()
}

// Datasource and Delegate for our CollectionView as well as our model to fetch data from the API
final class RMCharacterListViewViewModel : NSObject {
    
    public weak var delegate: RMCharacterListViewModelVieModelDelegate?
    
    private var characters: [RMCharacter] = [] {
        // Right before we set the array we want to add a list of models to the cell models area for storage
        didSet {
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image))
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    
    public func fetchCharacters() {
        // 1) RMService.Shared - Access the singleton instance of the RMClass
        // 2) execute(Request, Type) -> (Result<T, Error>) -> Void - will run a closure when the execute method is completed
        // NOTE: Static properties and init() can be called with dot notation ex. .listCharacterRequest
        RMService.shared.execute(
            .listCharactersRequest,
            expecting: RMGetAllCharactersResponse.self) {
                // TODO: - Need to research memory leaks and retain cycles
                /* here we are keeping a weak reference to self to prevent memory leaks.
                   This happens when we don't correctly deallocate our resources.
                   Here self is the CharcterListViewModel
                 */
                [weak self] result in
            
                switch result {
                    // response model
                case .success(let responseModel):
                    // results part of the JSON object
                    let results = responseModel.results
                    self?.characters = results
                    // use DispatchQueue because it will update a view
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadInitialCharacters()
                    }
                    // info part of the JSON object
                    //                let info = responseModel.info
                    
                case .failure(let error):
                    print(String(describing: error))
                }
            }
    }
    
}

extension RMCharacterListViewViewModel : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Use the custom cell view we created
        // we need to use unwrap the cell because we are optionaly casting it as a RMCharacterCollectionViewCell
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
            for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        let viewModel = cellViewModels[indexPath.row]
        // MARK: - Video #8 @ 6:55
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        let height = width * 1.5
        
        return CGSize(width: width, height: height)
    }
}
