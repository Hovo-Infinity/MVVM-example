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
import CoreData


class TestViewController: UIViewController {
    private let disposeBag: DisposeBag
    private let viewModel: TestViewModel
    private var currentPage = 2
    private var selectedFrame = CGRect.zero
    private var selectedImage: UIImage!
    private var customInteractor: CustomInteractor?
    
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
        navigationController?.delegate = self
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
            cell.thumbnailImageView.sd_setImage(with: try? item.thumbnailURL.asURL())
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
                /*
                let mapedValues = groupedVideos.mapValues({
                    $0.map({
                        TestCellModel(name: $0.name, duration: $0.humanReadableDuration, imageURL: try? $0.thumbnailURL.asURL())
                    })
                })
                */
                return groupedVideos.map({
                    TestSectionModel(header: $0.key, items: $0.value )
                })
            })
            .bind(to: tableView.rx.items(dataSource: rxDataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell.bind {[weak self] cell, indexPath in
            guard let weakSelf = self else { return }
            let lastSection = weakSelf.tableView.numberOfSections - 1
            let lastRow = weakSelf.tableView.numberOfRows(inSection: lastSection) - 1
            if indexPath == IndexPath(row: lastRow, section: lastSection) {
                weakSelf.viewModel.fetchDatas(page: weakSelf.currentPage)
                weakSelf.currentPage += 1
            }
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.bind {[weak self] indexPath in
            guard let weakSelf = self else { return }
            let cell = weakSelf.tableView.cellForRow(at: indexPath)! as! TestTableViewCell
            let frameInView = weakSelf.tableView.convert(cell.frame, to: weakSelf.view)
            weakSelf.selectedFrame = frameInView
            weakSelf.selectedImage = cell.thumbnailImageView.image!
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(NSManagedObject.self).bind(onNext: {[weak self] video in
            guard let weakSelf = self,
            let video = video as? Video else { return }
            let previewViewModel = weakSelf.viewModel.previewViewModelFor(video)
            let vc = VidoPreviewViewController.viewControllerFor(previewViewModel)
            weakSelf.navigationController?.pushViewController(vc, animated: true)
        })
        .disposed(by: disposeBag)
        
    }

}

extension TestViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let isPresenting = operation == .push
        if isPresenting {
            self.customInteractor = CustomInteractor(attachTo: toVC)
        }
        return CustomPushTransition(duration: 0.65, isPresenting: isPresenting, originFrame: selectedFrame, image: selectedImage)
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let ci = customInteractor else { return nil }
        return ci.transitionInProgress ? customInteractor : nil
    }
}
