//
//  ViewController.swift
//  InternetNetworkingApp
//
//  Created by Porter, Tyler on 1/8/20.
//  Copyright © 2020 CTEC. All rights reserved.
//

import UIKit
import WebKit
import PDFKit

class InternetDetailViewController: UIViewController, InternetDetailDelegate
{
    //MARK:- Data members and properties
    
    var webViewer: WKWebView!
    var pdfViewer: PDFView!
    
    var currentDetailTitle : String?
    {
        didSet
        {
            updateView()
        }
    }
    
    var currentDetailAddress : String?
    {
        didSet
        {
            updateView()
        }
    }
    
    private func updateView() -> Void
    {
        if (currentDetailTitle != nil && currentDetailAddress != nil)
        {
            loadViewIfNeeded()
            if (currentDetailAddress?.range(of: "http", options: .caseInsensitive) != nil)
            {
                loadURL(webAddress: currentDetailAddress!)
            }
            else if (pdfViewer != nil)
            {
                loadPDF(named: currentDetailAddress!)
            }
            
            self.title = currentDetailTitle
        }
    }
    
    //MARK:- Required method to conform to InternetDetailDelegate protocol
    
    func dataUpdate(title: String, address: String)
    {
        currentDetailTitle = title
        currentDetailAddress = address
    }
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() -> Void
    {
        super.viewDidLoad()
        //Explicit initialization of the WKWebView and PDFView objects since they are not outlets
        pdfViewer = PDFView()
        webViewer = WKWebView()
        self.title = "Empty Screen"
        view.backgroundColor = .purple
    }
    
    //MARK:- Data loading methods
    
    private func loadPDF(named: String) -> Void
    {
        webViewer?.isHidden = true
        webViewer?.isHidden = false
        if let documentURL = Bundle.main.url(forResource: named, withExtension: "pdf")
        {
            if let requestedPDF = PDFDocument(url: documentURL)
            {
                pdfViewer.document = requestedPDF
                pdfViewer.autoScales = true
                pdfViewer.displayDirection = .horizontal
                view = pdfViewer
            }
        }
        view.backgroundColor = .magenta
    }
    
    private func loadURL(webAddress: String) -> Void
    {
        pdfViewer?.isHidden = true
        webViewer?.isHidden = false
        view = webViewer
        let currentURL = URL(string: webAddress)
        let currentWebRequest = URLRequest(url: currentURL!)
        webViewer.load(currentWebRequest)
    }
    


}

