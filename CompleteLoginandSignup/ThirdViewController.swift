//
//  ThirdViewController.swift
//  CompleteLoginandSignup
//
//  Created by Pranoti Kulkarni on 5/6/18.
//  Copyright © 2018 Pranoti Kulkarni. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, URLSessionDownloadDelegate {

    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var photoView: UIImageView!
    
    var downloadTask: URLSessionDownloadTask!
    var backgroundSession: URLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundConfig = URLSessionConfiguration.background(withIdentifier: "background")
        
        backgroundSession = URLSession(configuration: backgroundConfig, delegate: self, delegateQueue: OperationQueue())
        
        progressView.setProgress(0.0, animated: false)
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Download finish success")
        let data = try? Data(contentsOf: location)
        DispatchQueue.main.async { //the ui should run on main thread
            if let data = data{
                self.photoView.image = UIImage(data: data)
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite totalBytesExpectedtoWrite: Int64){
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedtoWrite)
        DispatchQueue.main.async {
            self.progressView.setProgress(progress, animated: true)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        downloadTask = nil
        DispatchQueue.main.async {
            self.progressView.setProgress(0.0, animated: false)
        }
        if error != nil{
            print(error?.localizedDescription)
        }else{
            print("the task was completed successfully")
        }
    }
    
    @IBAction func play(_ sender: Any) {
        let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg")
        if let url = url{
            downloadTask = backgroundSession.downloadTask(with: url)
            downloadTask.resume()
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        if downloadTask != nil{
            downloadTask.cancel()
        }
    }
    
    @IBAction func pause(_ sender: Any) {
        if downloadTask != nil{
            downloadTask.suspend()
        }
    }
    
    @IBAction func resume(_ sender: Any) {
        if downloadTask != nil{
            downloadTask.resume()
        }
    }
    
}
