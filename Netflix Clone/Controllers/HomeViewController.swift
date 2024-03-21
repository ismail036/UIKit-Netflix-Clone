//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by İsmail Parlak on 7.03.2024.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv     = 1
    case Poppular       = 2
    case Upcoming       = 3
    case TopRated       = 4
}

class HomeViewController: UIViewController {
    
    let sectionTitles : [String] = ["Trending Movies" , "Trending Tv" , "Popular" , "Upcoming Movies" , "Top reted"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero,style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifer)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        
        configureNavbar()
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        
        APICaller.shared.getMovie(with: "Harry Potter   ")
    }
    
    private func configureNavbar() {

        let customLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30)) // Adjust width and height as needed
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.frame = customLeftView.bounds
        customLeftView.addSubview(logoImageView)
        
        // Assign the custom view to the left bar button item
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customLeftView)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    

    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifer, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    let arrayTitles = Array(titles)
                    cell.configure(with: arrayTitles)
                case .failure(let error):
                    // Handle error
                    print("Error: \(error)")
                }
            }
        case Sections.Poppular.rawValue:
            APICaller.shared.getPopular{ result in
                switch result {
                case .success(let titles):
                    let arrayTitles = Array(titles)
                    cell.configure(with: arrayTitles)
                case .failure(let error):
                    // Handle error
                    print("Error: \(error)")
                }
            }
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTvs{ result in
                switch result {
                case .success(let titles):
                    let arrayTitles = Array(titles)
                    cell.configure(with: arrayTitles)
                case .failure(let error):
                    // Handle error
                    print("Error: \(error)")
                }
            }
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpcomingMovies{ result in
                switch result {
                case .success(let titles):
                    let arrayTitles = Array(titles)
                    cell.configure(with: arrayTitles)
                case .failure(let error):
                    // Handle error
                    print("Error: \(error)")
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRated{ result in
                switch result {
                case .success(let titles):
                    let arrayTitles = Array(titles)
                    cell.configure(with: arrayTitles)
                case .failure(let error):
                    // Handle error
                    print("Error: \(error)")
                }
            }
        default:
            break
            
        }


        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18,weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitializeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y +  defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
}

