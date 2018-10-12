//
//  VidoPreviewViewController.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/12/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class VidoPreviewViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var creatorLabel: UILabel!
    private var viewModel: VideoPreviewViewModel!
    private let disposeBag = DisposeBag()

    
    static func viewControllerFor(_ viewModel: VideoPreviewViewModel) -> VidoPreviewViewController {
        let vc = VidoPreviewViewController(nibName: "VidoPreviewViewController", bundle: nil)
        vc.viewModel = viewModel
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
        // Do any additional setup after loading the view.
    }

    private func bindViews() {
        viewModel.model.bind(onNext: {[weak self] video in
            guard let weakSelf = self else { return }
            weakSelf.imageView.sd_setImage(with: try? video.thumbnailURL.asURL())
            weakSelf.nameLabel.text = video.name
            weakSelf.creatorLabel.text = video.creator.name
        })
        .disposed(by: disposeBag)
    }
}
