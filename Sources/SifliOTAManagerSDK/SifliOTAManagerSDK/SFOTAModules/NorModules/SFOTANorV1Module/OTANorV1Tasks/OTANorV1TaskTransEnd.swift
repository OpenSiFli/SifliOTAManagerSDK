import UIKit

class OTANorV1TaskTransEnd: OTANorV1TaskBase {
    
    /// 固定为0
    private let value:UInt8 = 0
    
    
    let completion:NorV1ResultCompletion?
    
    override func name() -> String {
        return "NorV1ImageTransmissionEnd"
    }
    override func marshalMsgPayloadData() -> Data {
        var v = value
        let vData = Data.init(bytes: &v, count: 1)
        return vData
    }
    
    
    init(completion:NorV1ResultCompletion?) {
        self.completion = completion
        super.init(messageType: .Transmission_End)
        if self.completion != nil {
            self.timeout = 30.0
            self.baseCompletion = {[weak self] (tsk,msg,error) in
                guard let s = self else {
                    return
                }
                if let err = error {
                    s.completion?(s,-1,err)
                    return
                }
                
                let payload = msg!.payloadData
                if payload.count < 1{
                    let err = SFOTAError.InsufficientBytes(expectCount: 2, actualCount: payload.count)
                    s.completion?(s, -1, err)
                    return
                }
                
                let pd = NSData.init(data: payload)
                var result:UInt8 = 0
                pd.getBytes(&result, range: NSRange.init(location: 0, length: 1))
                s.completion?(s,Int(result), nil)
            }
        }
    }
}
