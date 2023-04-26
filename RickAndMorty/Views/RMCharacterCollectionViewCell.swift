//
//  RMCharacterListViewCell.swift
//  RickAndMorty
//
//  Created by Josue Perez  on 4/18/23.
//

import UIKit

/// Single Cell for a character
class RMCharacterCollectionViewCell: UICollectionViewCell {
    
    // id for instances of this type of cell
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
    // created with anonymous closres that returns
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        // setting up one time properties
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        
        // setting up one time properties
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        
        // setting up one time properties
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        // call the parent init
        super.init(frame: frame)
        
        // contentView: UIView - When configuring a cell, you add any custom views representing your cell’s content to this view. The cell object places the content in this view in front of any background views.
        // add any custom content/views to contentView NOT the UICollectionViewCell
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, nameLabel, statusLabel)
        
        // set constraints
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.heightAnchor.constraint(equalToConstant: 50),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -3),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // reset properties
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    // TODO: - Need to research memory leaks and retain cycles
    public func configure(with viewModel: RMCharacterCollectionViewCellViewModel) {
        
        nameLabel.text = viewModel.characterName
        
        // since the characterStatus is private in the viewModel we are accessing the method that returns the enum's raw value
        statusLabel.text = viewModel.characterStatusText
        
        viewModel.fetchImage { [weak self] result in
            
            switch result {
                case .success(let data):
                    // create an image in the main thread since its a UI update
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        
                        self?.imageView.image = image
                    }
                
                case .failure(let error):
                
                    print(String(describing: error))
                    break
            }
        }
    }
}
