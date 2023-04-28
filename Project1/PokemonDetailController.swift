//
//  PokemonDetailController.swift
//  Project1
//
//  Created by James Esguerra on 4/28/23.
//
import UIKit
import PokemonAPI


class PokemonDetailController: UIViewController {
    
    var pokemonID = 0
    private var pokemonType = [PKMPokemonType]()

    @IBOutlet weak var typeLabel1: UILabel!
    @IBOutlet weak var typeLabel2: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pokemonName.text = NSLocalizedString("pokemon-name-\(pokemonID)", comment: "haha")
        
        PokemonAPI().pokemonService.fetchPokemon(pokemonID) { [self] result in
            switch result {
                case .success(let pokemon):
                    getImage(for: pokemon)
                    pokemonType = pokemon.types!
                    let typeOne = pokemonType[0].type?.name ?? ""
                
                    DispatchQueue.main.async {
                        self.typeLabel1.text = NSLocalizedString("\(typeOne)-display-text", comment: "haha")
                        self.typeLabel1.backgroundColor = UIColor(named: typeOne)
                        self.typeLabel1.layer.cornerRadius = 8
                        self.typeLabel1.layer.masksToBounds = true
                        self.typeLabel1.widthAnchor.constraint(equalToConstant: self.typeLabel1.intrinsicContentSize.width + 15).isActive = true
                    }
                    
                    if pokemonType.count > 1 {
                        let typeTwo = pokemonType[1].type?.name ?? ""
                        DispatchQueue.main.async {
                            self.typeLabel2.text = NSLocalizedString("\(typeTwo)-display-text", comment: "haha")
                            self.typeLabel2.backgroundColor = UIColor(named: typeTwo)
                            self.typeLabel2.layer.cornerRadius = 8
                            self.typeLabel2.layer.masksToBounds = true
                            self.typeLabel2.widthAnchor.constraint(equalToConstant: self.typeLabel2.intrinsicContentSize.width + 15).isActive = true
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.typeLabel2.isHidden = true
                        }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
        
        title = NSLocalizedString("pokemon-name-\(pokemonID)", comment: "haha")
    }

    private func getImage(for pokemon: PKMPokemon) {
        guard let imageURLString = pokemon.sprites?.frontDefault,
              let imageURL = URL(string: imageURLString)
        else { return }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, _ in
            
            guard let data = data,
                  let image = UIImage(data: data)
            else { return }
            
            print(image)
            
            DispatchQueue.main.async {
                self.pokemonImage.image = image
            }
        }.resume()
    }

}
