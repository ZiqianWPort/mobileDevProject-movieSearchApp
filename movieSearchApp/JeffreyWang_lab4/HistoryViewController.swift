//
//  SettingViewController.swift
//  JeffreyWang_lab4
//
//  Created by Ziqian Wang on 10/27/22.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var movieList:[Movie] = []
    var emptyArray = [String]()
    
    @IBOutlet weak var historyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        self.title = "History"
        
        historyTableView.dataSource = self
        historyTableView.delegate = self
        historyTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        grabFromDB()
        historyTableView.reloadData()
    }
    
    //---------Protocol stubs---------//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel!.text = movieList[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movieDetailPage = storyboard!.instantiateViewController(withIdentifier: "movieDetailView") as! MovieDetailViewController
        
        let movie = movieList[indexPath.row]
        
        movieDetailPage.id = movie.id
        movieDetailPage.movieTitle = movie.title
        movieDetailPage.imagePath = movie.poster_path
        movieDetailPage.date = movie.release_date
        movieDetailPage.voteCount = movie.vote_count
        movieDetailPage.voteAvg = movie.vote_average
        movieDetailPage.overview = movie.overview
        
        navigationController?.pushViewController(movieDetailPage, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if(editingStyle == .delete){
            
            let movieId = movieList[indexPath.row].id!
            let histID = "hist"+String(movieId)
            var tempList = UserDefaults.standard.stringArray(forKey: "historyIdList")
            
            tempList = tempList?.filter(){$0 != histID}
            UserDefaults.standard.set(tempList, forKey: "historyIdList")
            
            UserDefaults.standard.removeObject(forKey: histID)
            movieList.remove(at: indexPath.row)

            print(movieList)
            historyTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func grabFromDB(){
        
        let idList = UserDefaults.standard.stringArray(forKey: "historyIdList")  ?? [String]()
        
        movieList = []
        
        for movieID in idList {
            
            let movieData = UserDefaults.standard.stringArray(forKey: movieID)  ?? [String]()
            
            let movie = Movie(id: Int(movieData[0]), poster_path: movieData[1], title: movieData[2], release_date: movieData[3], vote_average: Double(movieData[4]) ?? 0, overview: movieData[5], vote_count: Int(movieData[6]))
            
            movieList.append(movie)
        }
    }
    
    
    //--------remove all from history--------//
    
    @IBAction func removeAllHistory(_ sender: Any) {
        
        let alertController = UIAlertController(
            title: "Are you sure you want to clear all movies from history list?",
            message: "You cannot undo this action",
            preferredStyle: UIAlertController.Style.alert
        )

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)

        let confirmAction = UIAlertAction(
            title: "OK", style: UIAlertAction.Style.destructive) { (action) in
                
                UserDefaults.standard.set(self.emptyArray, forKey: "historyIdList")
                
                self.movieList = []
                self.historyTableView.reloadData()

        }
    

        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    
    
    
    


}
