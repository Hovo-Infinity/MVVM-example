//
//  TestRepo.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/5/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import CoreData

//  http://www.mocky.io/v2
enum TestTargetType {
    case basic(_ version: Int)
}
extension TestTargetType: TargetType {
    internal var baseURL: URL {
        return try! "http://www.mocky.io".asURL()
    }
    
    var path: String {
        switch self {
        case .basic(let page):
            switch page {
            case 1:
                return "/v2/5bbdeed131000083007112a1"
            case 2:
                return "/v2/5bbdf5ed3100007c007112e6"
            default:
                return "adidas"
            }
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "chjoki sik inchi hamar e".utf8Encoded
    }
    
    var task: Task {
        return Task.requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}

class TestRepo: NSObject {
    let apiProvider = MoyaProvider<TestTargetType>()
    let reachibilityService = try? DefaultReachabilityService()
    let disposeBag = DisposeBag()
    var _fetchedResultsController: NSFetchedResultsController<Video>? = nil
    var fetchedResultsController: NSFetchedResultsController<Video> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Video> = Video.fetchRequest()
        fetchRequest.sortDescriptors = []
        
        let aFetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                managedObjectContext: CoreDataManager.sInstance.viewContext,
                                                                sectionNameKeyPath: nil,
                                                                cacheName: nil)
        
        aFetchResultController.delegate = self
        _fetchedResultsController = aFetchResultController
        do {
            // Perform the initial fetch to Core Data.
            // After this step, the fetched results controller
            // will only retrieve more records if necessary.
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    private lazy var fetchRequest: NSFetchRequest<Video> = {
        let fetchRequest = NSFetchRequest<Video>(entityName: "Video")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "videoID", ascending: true)]
        let context = CoreDataManager.sInstance.viewContext
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "Video", in: context)
        return fetchRequest
    }()
    
    func fetchData(forPage page: Int) -> Observable<[Video]> {
        if reachibilityService?._reachability.currentReachabilityStatus != Reachability.NetworkStatus.notReachable {
            return apiProvider.rx
                .request(TestTargetType.basic(page))
                .asObservable()
                .map {
                    let data = $0.data
                    do {
                        let x = try JSONDecoder().decode([Video].self, from: data)
                        return x
                    } catch  {
                        print(error)
                        return []
                    }
                }
                .asObservable()
        } else {
            let context = CoreDataManager.sInstance.viewContext
            let videos = try? context.fetch(fetchRequest)
            return Observable.just(videos.valueOr([]))
        }
    }
}

extension TestRepo: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        // Whenever a change occours on our data, we refresh the table view.
    }
}
