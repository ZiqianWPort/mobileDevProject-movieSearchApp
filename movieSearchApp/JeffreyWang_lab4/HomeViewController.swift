//
//  HomeViewController.swift
//  JeffreyWang_lab4
//
//  Created by Ziqian Wang on 10/27/22.
//
/*
 Image References:
 History icon:
 https://www.flaticon.com/free-icon/clock_465684
 Favorite icon:
 https://www.flaticon.com/free-icon/star_149763
 Search icon:
 https://www.flaticon.com/free-icon/magnifier_2311526
 */

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    
    var fetchResult:[APIResults] = []
    var theImageCache:[UIImage] = []
    var lang:String = "en"
    var adult:Bool = false
    
    //extra credit
    var id: Int!
    var movieTitle: String!
    var imagePath: String!
    var date: String!
    var voteCount: Int!
    var voteAvg: Double!
    var overview: String!
    
    //---------Protocol stubs---------//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return theImageCache.count
    }
    
    //collection cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MyCollectionViewCell
        
        let movie = fetchResult[0].results[indexPath.section * 3 + indexPath.row]
        
        if(theImageCache.count == 0){
            cell.movieCover.image = nil
            cell.movieName.text = nil
        }
        
        cell.movieCover.image = theImageCache[indexPath.row]
        cell.movieName.text = movie.title
        
        return cell
    }
    
    //connect to movieDetailViewController
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let movieDetailPage = storyboard!.instantiateViewController(withIdentifier: "movieDetailView") as! MovieDetailViewController
        
        let movie = fetchResult[0].results[indexPath.section * 3 + indexPath.row]
        
        movieDetailPage.id = movie.id
        movieDetailPage.movieTitle = movie.title
        
        movieDetailPage.imagePath = movie.poster_path
        movieDetailPage.date = movie.release_date
        movieDetailPage.voteAvg = movie.vote_average
        movieDetailPage.voteCount = movie.vote_count
        movieDetailPage.overview = movie.overview
        
        navigationController?.pushViewController(movieDetailPage, animated: true)
    }
    
    //extra credit
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(
            identifier: nil, previewProvider: nil
        ){ _ in
        
            let open = UIAction(
            
                title: "Favorite",
                image: UIImage(systemName: "star.fill"),
                identifier: nil,
                discoverabilityTitle: nil,
                state: .off
            ){ _ in
                
                let movie = self.fetchResult[0].results[indexPath.section * 3 + indexPath.row]
                
                self.id = movie.id
                self.movieTitle = movie.title
                self.imagePath = movie.poster_path
                self.date = movie.release_date
                self.voteAvg = movie.vote_average
                self.voteCount = movie.vote_count
                self.overview = movie.overview
                
                self.putToFavorite()
            }
            
            return UIMenu(
                
                title:"",
                image:nil,
                identifier:nil,
                options:UIMenu.Options.displayInline,
                children: [open]
            )
        }
        
        return config
        
    }
    
    //---------Override---------//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellSize = UIScreen.main.bounds.width/3 - 10
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        layout.itemSize = CGSize(width: cellSize, height: cellSize + cellSize / 2)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        movieCollectionView.collectionViewLayout = layout
        
        searchBar.delegate = self
        setupCollectionView()
        loading.isHidden = true
        
        print("favorite ID list: ")
        print(UserDefaults.standard.stringArray(forKey: "savedIdList")  ?? [String]())
        
        print("history ID list: ")
        print(UserDefaults.standard.stringArray(forKey: "historyIdList")  ?? [String]())

        //clear userdefaults
        
//        let domain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: domain)
//        UserDefaults.standard.synchronize()
//        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    }
    
    //---------set up---------//
    func setupCollectionView(){
        
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        theImageCache = []
        movieCollectionView.reloadData()
        searchBar.resignFirstResponder()
        
        loading.isHidden = false
        loading.startAnimating()
        let searchWord = searchBar.text!
        
        DispatchQueue.global().async {
            
            self.fetchDataForCollectionView(keyword: searchWord)
            
            DispatchQueue.main.async {
                
                self.loading.stopAnimating()
                self.loading.isHidden = true
                self.movieCollectionView.reloadData()
            }
        }
    }
    
    //fetch from TMDb
    func fetchDataForCollectionView(keyword: String){
        
        let apiKey:String = "8e5c0ba57969c8b51671cf65713d9d80"
        let cleanedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let dataQuery:String = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=\(lang)&query=\(cleanedKeyword!)&include_adult=\(adult)"
        
        let url = URL(string: dataQuery)
        
        if(url != nil){
            let data = try! Data(contentsOf: url!)
            fetchResult = [try! JSONDecoder().decode(APIResults.self, from: data)]
            var isEmpty:Bool = false
            
            if(fetchResult[0].results.count == 0){
                
                isEmpty = true
                DispatchQueue.main.async {
                 
                    let alert = UIAlertController(title: "Alert", message: "No Result Found", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.loading.isHidden = true
                }
            }
            theImageCache = []
            cacheImage(isEmpty: isEmpty)
        }
    }
    
    //fetch image
    func cacheImage(isEmpty: Bool){
        
        if(isEmpty == false){
            
            let baseURL:String = "https://image.tmdb.org/t/p/w154"
            for i in 0..<fetchResult[0].results.count{
                
                if(fetchResult[0].results[i].poster_path != nil){
                    
                    let imagePath:String = fetchResult[0].results[i].poster_path!
                    let imageQuery:String = baseURL + imagePath
                    let url = URL(string: imageQuery)
                    let data = try? Data(contentsOf: url!)
                    let image = UIImage(data: data!)
                    theImageCache.append(image!)
                }
            }
        }
    }
    
    //extra credit: put into favorite
    func putToFavorite(){
        let movieDataList = [
                    String(id),
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
