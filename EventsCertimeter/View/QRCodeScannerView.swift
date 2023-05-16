//
//  QRCodeScannerView.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 15/05/23.
//

import UIKit
import AVFoundation

//MARK: - dovrebe scannerizzare i qrcode, da testare e trasformare in un  mvp con gestione dei dati ecc

class QRCodeScannerView: UIViewController {
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrcodeFrameView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let caputureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("failed to get camera device")
            return
        }
        
        do{
            let input = try AVCaptureDeviceInput(device: caputureDevice)
            captureSession.addInput(input)
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            captureSession.startRunning()
            //visualizza un affare per inquadrare il qr -- non funziona mi sa 
            qrcodeFrameView = UIView()
            if let qrcodeFrameView = qrcodeFrameView {
                qrcodeFrameView.layer.borderColor = UIColor.yellow.cgColor
                qrcodeFrameView.layer.borderWidth = 2
                view.addSubview(qrcodeFrameView)
                view.bringSubviewToFront(qrcodeFrameView)
                
            }
        }catch{
            print(error)
            return
        }
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
            if metadataObjects.count == 0{
                qrcodeFrameView?.frame = .zero
                return
            }
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if metadataObject.type == AVMetadataObject.ObjectType.qr{
                let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject)
                qrcodeFrameView?.frame = barcodeObject!.bounds
                
                if let mo = metadataObject.stringValue {
                }
            }
        }

    }
}
extension QRCodeScannerView: AVCaptureMetadataOutputObjectsDelegate{
    
}
