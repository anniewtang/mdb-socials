//
//  FeedViewController
//  mdb-socials
//
//  Created by Annie Tang on 9/26/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    var tableView: UITableView!
    
    /* order of images in pokemonImages should be same as in results */
    var socials: [Pokemon]!
    // var pokemonImages: [UIImage]!
    
    var pokemonToPass: Pokemon!
    var pokePicToPass: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    
    /* Initializaing table view, and adding it to view */
    func setupTableView(){
        tableView = UITableView(frame:
            CGRect(x: 0,
                   y: UIApplication.shared.statusBarFrame.maxY + view.frame.height * 0.1 + 10,
                   width: view.frame.width,
                   height: view.frame.height - UIApplication.shared.statusBarFrame.maxY))
        
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50/2, right: 0)
        view.addSubview(tableView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToPokemonDetails" {
            let pokemonDetails = segue.destination as! PokemonProfileViewController
            pokemonDetails.p = pokemonToPass
        }
    }
}



/* extension of TABLEVIEWS */
extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    /* number of sections/types of cells in tableview */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /* number of cells in section of tableview */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    /* dequeue & set up cell at indexPath.row
     pass over the pokemon image, name, and number into the tableview cell */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* dequeue cell and remove/reset from subview; initialize new cell */
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! PokemonTableViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        let p: Pokemon = results[indexPath.row]
        
        cell.pokemonObject = p
        
        cell.awakeFromNib()
        
        Utils.getImage(url: p.imageUrl) { img in
            cell.pokePic.image = img
        }
        if cell.pokePic.image == nil {
            cell.pokePic.image = #imageLiteral(resourceName: "pokeball")
        }
        cell.nameLabel.text = p.name
        cell.numberLabel.text = "# " +  String(p.number)
        return cell
    }
    
    /* action after tableCell is selected
     "passes" the pokemon object over into the PokemonDetailsVC through segue */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemonToPass = results[indexPath.row]
        performSegue(withIdentifier: "segueToPokemonDetails", sender: self)
    }
    
    /* sets each row to be 1/10 of frame view */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 10
    }
    
}

/* EXTENSION OF COLLECTIONVIEW */
extension SearchResultsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    /* number of types of cells in collectionView */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    /* number of cells in a section */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    /* dequeue & setting up collectionView cell
     sets the pokemon's image, name to the collectionView cell */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        /* dequeue cell and remove/reset from subview; initialize new cell */
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! PokemonCollectionViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        let p: Pokemon = results[indexPath.row]
        cell.awakeFromNib()
        
        // cell.pokePic.image = pokemonImages[indexPath.row]
        Utils.getImage(url: p.imageUrl) { img in
            cell.pokePic.image = img
        }
        if cell.pokePic.image == nil {
            cell.pokePic.image = #imageLiteral(resourceName: "pokeball")
        }
        cell.nameLabel.text = p.name
        return cell
    }
    
    /* passes the pokemon into PokemonDetails once cell is clicked upon */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pokemonToPass = results[indexPath.row]
        performSegue(withIdentifier: "segueToPokemonDetails", sender: self)
    }
    
    /* makes it such that the cells are 1/4 of the view width square */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 4, height: view.frame.width / 4)
    }
}
