//
//  MovieDetailViewController.swift
//  JeffreyWang_lab4
//
//  Created by Ziqian Wang on 10/27/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var id: Int!
    var movieTitle: String!
    var imagePath: String!
    var date: String!
    var voteCount: Int!
    var voteAvg: Double!
    var overview: String!
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        self.title = movieTitle!
        dateLabel.text = "Released: \(date!)"
        voteLabel.text = "Score: \(voteAvg!) / 10"
        voteCountLabel.text = "Votes: \(voteCount!)"
        
        
        
        fetchImage()
        putIntoHistory()
    }
    
    //buttons
    @IBAction func addtoFavouriteButtonPressed(_ sender: Any) {
        
        let movieDataList = [String(id),
                     imagePath,
                     movieTitle,
                     date,
                     String(voteAvg),
                     overview,
                     String(voteCount)
        ]
        UserDefaults.standard.set(movieDataList, forKey: String(id))
        
        if var idList = UserDefaults.standard.stringArray(forKey: "savedIdList"){
            
            if(!idList.contains(String(id))){
                
                idList.append(String(id))
                UserDefaults.standard.set(idList, forKey: "savedIdList")
            }
            else{
                
                UserDefaults.standard.set(idList, forKey: "savedIdList")
            }
        }
        else{
            
            var idList:[String] = []
            idList.append(String(id))
            UserDefaults.standard.set(idList, forKey: "savedIdList")
        }
        
        print("favorite ID list: ")
        print(UserDefaults.standard.stringArray(forKey: "savedIdList")  ?? [String]())
    }
    
    @IBAction func youtubeSearch(_ sender: Any) {
        launchWebView()
    }
    @IBAction func toOverview(_ sender: Any) {
        goToOverview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //--------functions--------//
    
    func fetchImage(){
        
        let baseURL:String = "https://image.tmdb.org/t/p/w500"
        if let imagePath:String = self.imagePath{
            
            let imageQuery:String = baseURL + imagePath
            let url = URL(string: imageQuery)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data: data!)
            movieImage.image = image
        }
        else{
            movieImage.image = nil
        }
    }
    
    func launchWebView(){
        
        let webView = storyboard!.instantiateViewController(withIdentifier: "webView") as! WebViewController
        
        let baseURL:String = "https://m.youtube.com/results?q="
        let cleanedTitle = movieTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let finalURL:String = baseURL + cleanedTitle!
        let url = URL(string: finalURL)!
        let myURLRequest = URLRequest(url: url)
        webView.myURLRequest = myURLRequest
        
        navigationController?.pushViewController(webView, animated: true)
    }
    
    func goToOverview(){
        
        let overview = storyboard!.instantiateViewController(withIdentifier: "overview") as! overviewController
        
        overview.overviewContent = self.overview
        
        navigationController?.pushViewController(overview, animated: true)
    }
    
    func putIntoHistory(){
        let historyMovDataList = [String(id),
                     imagePath,
                     movieTitle,
                     date,
                     String(voteAvg),
                     overview,
                     String(voteCount)
        ]
        
        let histID = "hist"+String(id)
        
        UserDefaults.standard.set(historyMovDataList, forKey: histID)
        
        if var histIdList = UserDefaults.standard.stringArray(forKey: "historyIdList"){
            
            if(!histIdList.contains(histID)){
                
                histIdList.append(histID)
                UserDefaults.standard.set(histIdList, forKey: "historyIdList")
            }
            else{
                
                UserDefaults.standard.set(histIdList, forKey: "historyIdList")
            }
        }
        else{
            
            var histIdList:[String] = []
            histIdList.append(histID)
            UserDefaults.standard.set(histIdList, forKey: "historyIdList")
        }
        
        print("history ID list: ")
        print(UserDefaults.standard.stringArray(forKey: "historyIdList")  ?? [String]())
    }
    

}
