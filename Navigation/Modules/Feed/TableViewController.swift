//
//  TableViewController.swift
//  Navigation
//
//  Created by Максим Донских on 08.01.2023.
//

import UIKit
import AVFoundation
import AVKit
import WebKit

class NewController: UIViewController {
    
    init(player: WKWebView, request: URLRequest) {
        super.init(nibName: nil, bundle: nil)
        player.load(request)
        self.view = player
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TableViewController: UITableViewController {
    
    var webPlayer: WKWebView = {
        let player = WKWebView(frame: .zero)
        player.translatesAutoresizingMaskIntoConstraints = false
        return player
    }()
    
    var mediaArray: [String] = [
    "https://www.youtube.com/embed/FSNXhmBxRKE?playsinline=1",
    "https://www.youtube.com/embed/LeqKIzeZel4?playsinline=1",
    "https://www.youtube.com/embed/jwI1j7sslYI?playsinline=1",
    "https://www.youtube.com/embed/RWOHKOCr00U?playsinline=1",
    "https://www.youtube.com/embed/k85mRPqvMbE?playsinline=1",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupPlayer()
    }
    
    func setupTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func setupPlayer() {
        view.addSubview(webPlayer)
        
        NSLayoutConstraint.activate([
            webPlayer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("tableView frame", tableView.frame)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.layoutSubviews()
        print(webPlayer.frame)
        print("view frame", view.frame)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mediaArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .gray
        cell.textLabel?.text = mediaArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let streamURL = URL(string: mediaArray[indexPath.row])!
//        let player = AVPlayer(url: streamURL)
//        let controller = AVPlayerViewController()
//        controller.player = player
        
        let webConfiguration = WKWebViewConfiguration()
                webConfiguration.allowsInlineMediaPlayback = true
                
                    guard let videoURL = URL(string: self.mediaArray[indexPath.row]) else {
                        return }
                    let request = URLRequest(url: videoURL)
//                    self.webPlayer.load(request)
        
        let viewController = NewController(player: webPlayer, request: request)
        present(viewController, animated: true)
        
        
        
//        present(controller, animated: true)

        
        //
//        if let _ = self.someTableView.cellForRow(at: indexPath) as? PhotosTableViewCell {
//            coordinator?.pushPhotosVC()
        }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
