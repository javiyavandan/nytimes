import UIKit
import KYDrawerController


class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var tblMenu: UITableView!
    var arrMenu:Array<String> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrMenu = ["Yash Gadani","MOST VIEWED",]
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tblMenu.reloadData()
    }
    
}

//Mark : Tableview datasource/delegate
extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0)
        {
            return UITableView.automaticDimension
        }
        else
        {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as! MenuCell
            
            return cell
        }

        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MenuCell
            cell.lblTitle.text = self.arrMenu[indexPath.row]
            return cell
        }
    }
    
}
