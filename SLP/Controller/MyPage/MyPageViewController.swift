import UIKit

final class MyPageViewController: UIViewController {
    
    var viewModel = MypageViewModel()
    let mainView = MyPageView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    private func bind() {
        
        viewModel.fetch()
        title = viewModel.title
        
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.Title3_M14!
        ]
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
}

extension MyPageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.menus.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 내 정보 셀
        if indexPath.section == 0 {
            guard let cell =  mainView.tableView.dequeueReusableCell(withIdentifier: MyPageCell.identifier, for: indexPath) as? MyPageCell else {
                return UITableViewCell()
            }
            
            cell.title?.text = viewModel.nickName
            cell.icon?.image = UIImage(named: viewModel.icon)
            return cell
            
        } else {
            let cell = mainView.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            let row = indexPath.row
            
            var content = cell.defaultContentConfiguration()
            content.text = viewModel.menus[row].title
            content.image = UIImage(named: viewModel.menus[row].icon)
            cell.contentConfiguration = content
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let viewController = MyPageDetailViewController()
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
