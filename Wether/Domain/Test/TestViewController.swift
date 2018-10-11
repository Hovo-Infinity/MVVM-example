//
//  TestViewController.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/5/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SDWebImage

let cellReuseIdentifier = "lessonsCell"

class TestViewController: UIViewController {
    private let disposeBag: DisposeBag
    private let viewModel: TestViewModel
    private var currentPage = 2
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    
    required init?(coder aDecoder: NSCoder) {
        disposeBag = DisposeBag()
        viewModel = TestViewModel(disposeBag: disposeBag)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TestTableViewCell.nib, forCellReuseIdentifier: TestTableViewCell.reuseIdentifier)
        bindViews()
    }
    
    private func bindViews() {
        bindTableView()
        viewModel.isLoading
            .asDriver(onErrorJustReturn: true)
            .drive(onNext: {
                self.indicator.isLoading = $0
                self.tableView.isHidden = $0
            })
            .disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        let rxDataSource = RxTableViewSectionedReloadDataSource<TestSectionModel> (configureCell: { dataSource, rxTableView, indexPath, item -> TestTableViewCell in
            let cell = rxTableView.dequeueReusableCell(withIdentifier: TestTableViewCell.reuseIdentifier, for: indexPath) as! TestTableViewCell
            cell.nameLabel.text = item.name
            cell.durationLabel.text = item.duration
            cell.thumbnailImageView.sd_setImage(with: item.imageURL)
            return cell
        })
        
        rxDataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
        
        viewModel.model
            .subscribeOn(MainScheduler.instance)
            .map({ videos -> [String: [Video]] in
                Dictionary<String, [Video]>(grouping: videos, by: { $0.creator.name })
            })
            .map ({ groupedVideos -> [TestSectionModel] in
                let mapedValues = groupedVideos.mapValues({
                    $0.map({
                        TestCellModel(name: $0.name, duration: $0.humanReadableDuration, imageURL: try? $0.thumbnailURL.asURL())
                    })
                })
                return mapedValues.map({
                    TestSectionModel(header: $0.key, items: $0.value )
                })
            })
            .bind(to: tableView.rx.items(dataSource: rxDataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.didScroll.subscribe(onNext: { esim in
            let  height = self.tableView.frame.size.height
            let contentYoffset = self.tableView.contentOffset.y
            let distanceFromBottom = self.tableView.contentSize.height - contentYoffset
            if distanceFromBottom < height + 500 {
                self.viewModel.fetchDatas(page: self.currentPage)
                self.currentPage += 1
            }
        })
        .disposed(by: disposeBag)
        
    }

}
