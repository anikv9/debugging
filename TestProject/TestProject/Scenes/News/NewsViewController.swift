//
//  NewsViewController.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import UIKit

final class NewsViewController: UIViewController {
    
    // MARK: - Properties
//უდრის მოვაშორე, ტიპს ვუსაზღვრავთ tableview ამ ნაწილში და სინტაქსი იყო გასასწორებელი
//ამასთან ერთად შესწორების გარეშე ეს "ობიექტი" მაშინვე იქმნებოდა და self მიემართებოდა ისეთ რამეს, რაც ჯერ არ იყო შექმნილი
    
    private var tableView: UITableView {
        let tableView = UITableView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }
    
    private var news = [News]()
    private var viewModel: NewsViewModel = DefaultNewViewModel()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Setup TableView
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - TableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    //აქამდე არაფერს არ აბრუნებდა, ასე რომ შევცვალე და დავაბრუნებინებ იმდენ სტრიქონს რამდენი ნიუსიც გვაქვს
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("Could not dequeue NewsCell")
        }
        cell.configure(with: news[indexPath.row])
        return cell
    }
    
}



// MARK: - TableViewDelegate
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        .zero
    }
}

// MARK: - MoviesListViewModelDelegate
extension NewsViewController: NewsViewModelDelegate {
    func newsFetched(_ news: [News]) {
        self.news = news
        tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        print("error")
    }
}

