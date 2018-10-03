//
//  ViewController.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/2/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit

class ViewController: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: MinutelyCellListViewModel = MinutelyCellListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel.fetchData()
        registerCell()
        bindViews()
        DataRepository.getInstance().isLoading
            .bind { isLoading in
                self.tableView.isHidden = isLoading
            }
            .disposed(by: disposebag)
    }
    
    private func registerCell() {
        tableView.register(MinutelyCell.nib, forCellReuseIdentifier: MinutelyCell.reuseIdentifier)
    }
    
    private func bindViews() {
        viewModel.minutelyCellModels
            .bind(to: tableView.rx.items(cellIdentifier: MinutelyCell.reuseIdentifier, cellType: MinutelyCell.self)) { (x, viewModel, cell) in
                print("x = \(x)")
                cell.viewModel = viewModel
            }
            .disposed(by: disposebag)
    }
}

