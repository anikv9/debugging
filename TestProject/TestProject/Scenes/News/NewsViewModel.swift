//
//  NewsViewModel.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

protocol NewsViewModelDelegate {
    func newsFetched(_ news: [News])
    func showError(_ error: Error)
}

protocol NewsViewModel {
    var delegate: NewsViewModelDelegate? { get set }
    func viewDidLoad()
}

final class DefaultNewsViewModel: NewsViewModel {
    
    // MARK: - Properties
    private let newsAPI = "https://newsapi.org/v2/everything?q=tesla&from=2021-11-11&sortBy=publishedAt&apiKey=ce67ca95a69542b484f81bebf9ad36d5"
    
    private var newsList = [News]()

    var delegate: NewsViewModelDelegate?

    // MARK: - Public Methods
    func viewDidLoad() {
        //fetchNews()
    }
    
    // MARK: - Private Methods
    
    private func fetchNews() {
        
        //აქ სავარაუდოდ რამენაირად უნდა გავარჩიო და გამოვიძახო არა თვითონ ობიექტი, არამედ მისი ინსტანსი, მაგრამ რაღაც ვერ გავერკვიე
        
        let networkManager = NetworkManager.shared
        let rawValue = networkManager.rawValue    //!!!!!!
        rawValue.get(url: newsAPI) { [weak self] (result: Result<Article, Error>) in
            switch result {
            case .success(let article):
                self?.delegate?.newsFetched([article.articles]) // [] ამ ფრჩხილების დაწერით ერეიდ აღიქვა მონაცემები
                self?.newsList.append(article.articles)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}

