//
//  DeliveryListViewController.swift
//  DeliveryTestApp
//
//  Created by Mahmudul Hasan R@zib on 9/16/18.
//  Copyright © 2018 Matrix Solution Ltd. All rights reserved.
//

import UIKit
import RealmSwift

class DeliveryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var dataSourceArray = [Delivery]()
    private var deliveryListTable: UITableView!
    private var totalRowsWithPages = 0
    private var isLoading = false
    private var offset = 0
    private var limit = 20
    private var isStoredData = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Delivery List"
        self.view.backgroundColor = UIColor.white
        self.setupTableView()
        
        let parameter = ["offset" : offset, "limit" : limit] as [String : Int]
        self.getDeliveryArray(param: parameter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTableView() {
        
        let offset: CGFloat = 10.0
        let navHeight: CGFloat = self.topbarHeight
        
        deliveryListTable = UITableView(frame: CGRect(x: offset, y: offset, width: SCREEN_WIDTH - offset*2, height: SCREEN_HEIGHT - navHeight - offset*2))
        deliveryListTable.register(DeliveryItemTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(DeliveryItemTableViewCell.self))
        deliveryListTable.dataSource = self
        deliveryListTable.delegate = self
        deliveryListTable.separatorStyle = .singleLine
        deliveryListTable.backgroundColor = UIColor.white

        self.view.addSubview(deliveryListTable)
    }
    
    // MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(DeliveryItemTableViewCell.self), for: indexPath) as! DeliveryItemTableViewCell
        let data = dataSourceArray[indexPath.row]
        cell.isStored = isStoredData
        cell.del = data
        
        if ((indexPath.row == dataSourceArray.count - 1) && !isStoredData){
            let parameter = ["offset" : totalRowsWithPages, "limit" : limit] as [String : Int]
            self.requestForDeliveryData(param: parameter)
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = dataSourceArray[indexPath.row]
        let detailsVC = DeliveryDetailsViewController()
        detailsVC.selectedDeliveryItem = selectedItem
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
    private func getDeliveryArray(param: [String : Int]) {
        
        let dataArray = DataManager.sharedManager.getAllObjects()
        if dataArray.count > 0 {
            isStoredData = true
            dataSourceArray = dataArray
            deliveryListTable.reloadData()
        }
        else {
            isStoredData = false
            requestForDeliveryData(param: param)
        }
    }
    
    private func requestForDeliveryData(param: [String : Int]) {
        
        if isLoading {return}
        isLoading = true
        
        if AppManager.isInternetAvailabel() {
            ERProgressHud.show()
            APIManager.sharedManager.makeRequestToGetDeliveryList(param: param) { (isSuccess, dataArray) in
                ERProgressHud.hide()
                self.isLoading = false;

                if(isSuccess) {
                    self.dataSourceArray.append(contentsOf: dataArray as! [Delivery])
                    self.deliveryListTable.reloadData()
                    self.totalRowsWithPages = self.dataSourceArray.count
                }
                else {
                    ERAlertController.showAlert("Error!", message: "No data found, PLease try again later.", isCancel: false, okButtonTitle: "OK", cancelButtonTitle: "")
                }
            }
        }
        else {
            self.isLoading = false;
            ERAlertController.showAlert("Error!", message: "No internet available, Please connect with internet", isCancel: false, okButtonTitle: "OK", cancelButtonTitle: "")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
