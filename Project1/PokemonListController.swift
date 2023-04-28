//
//  PokemonListController.swift
//  Project1
//
//  Created by James Esguerra on 4/28/23.
//

import UIKit


class PokemonListController: UITableViewController {
    
    var pokemon = Array(1...151)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        title = NSLocalizedString("list-title", comment: "haha")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = NSLocalizedString("pokemon-name-\(String(pokemon[indexPath.row]))", comment: "haha")
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pokemonDetailController = storyboard?.instantiateViewController(withIdentifier: "pokemonDetailID") as? PokemonDetailController else { return }
        pokemonDetailController.pokemonID = pokemon[indexPath.row]
        navigationController?.pushViewController(pokemonDetailController, animated: true)
    }

}
