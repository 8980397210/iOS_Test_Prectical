//
//  ViewController.swift
//  iOS_Test_Assessment
//
//  Created by Bhargav Bhatti on 25/04/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var model: [JsonModel] = []
    var currentPage = 1
    let pageSize = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        fetchPosts()
    }
    
    func fetchPosts() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts?_page=\(currentPage)&_limit=\(pageSize)")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let newPosts = try decoder.decode([JsonModel].self, from: data)
                self.model.append(contentsOf: newPosts)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        let data = model[indexPath.row]
        cell.textLabel?.text = "ID: \(data.id ?? 0)"
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "Title: \(data.title ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedObjc = model[indexPath.row]
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
                print("Failed to instantiate DetailViewController from storyboard")
                return
            }
        navigationController?.isNavigationBarHidden = false
        detailViewController.model = selectedObjc
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // Pagination
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == model.count - 1 {
            currentPage += 1
            fetchPosts()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

