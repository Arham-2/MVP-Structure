//  Created by Arham MAC on 27/01/2025.
//

import UIKit

class ViewController: UIViewController, PeopleView {
    @IBOutlet var tableView: UITableView!
        
    private var presenter: PeoplePresenter!
//    required init?(coder: NSCoder) {
////        self.presenter = PeoplePresenter(delegate: self)  // Now it's safe to use 'self'
//        super.init(coder: coder)  // Initialize the parent class first
//
//    }

    var people: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = PeoplePresenter(delegate: self)
        
        let nib = UINib(nibName: "PersonCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PersonCell")
     
        tableView.delegate  = self
        tableView.dataSource = self
        
            presenter.fetchPeopleData()
    }
    func showPeople(people: [Person]) {
            self.people = people
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        func showError(error: Error) {
            DispatchQueue.main.async {
                self.showErrorAlert(error: error)
            }
        }
        
        private func showErrorAlert(error: Error) {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me")
    }
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell",
                                                 for: indexPath) as! PersonCell
        
        let person1 = people[indexPath.row]
        
        cell.configureCell(person: person1)
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section: \(section)"
    }
}


