//
//  APICaller.swift
//  Netflix Clone
//
//  Created by İsmail Parlak on 8.03.2024.
//

import Foundation

struct Constants{
    static let API_KEY = "03a017898fbf9c4e46790a29a80d7bd7"
    
    static let baseUrl = "https://api.themoviedb.org"
    
    static let YoutubeAPI_KEY = "AIzaSyDvO4ucMEEKD9Bh0kZn9ruvQJKSsT15ZU0"
    
    static let youtubeBaseUrl = "https://youtube.googleapis.com/youtube/v3/search?"
}

class APICaller {
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return} 
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let results =  try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch{
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()

    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                
            }
            
        }
        
        task.resume()
    }
    
    
    func getPopular(completion: @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                
            }
            
        }
        
        task.resume()
    }
    
    
    func getTopRated(completion: @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                
            }
            
        }
        
        task.resume()
    }
    
    
    func getDiscoverMovies(completion: @escaping (Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                
            }
            
        }
        
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title],Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseUrl)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                
            }
            
        }
        
        task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<YoutubeItem, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.youtubeBaseUrl)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {
            return
        }
        
        print(url)
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data else { return completion(.failure(error ?? NSError(domain: "No data received", code: -1, userInfo: nil))) }
            
            if let error = error {
                return completion(.failure(error))
            }
            
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                print(results.items[0])
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

    
    
    
    
    
}
 
