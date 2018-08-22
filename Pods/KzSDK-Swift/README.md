# KzSDK-Swift
## Installation
Cocoapods

    pod 'KzSDK-Swift'
## Getting Started
Initialize with your API and MD5 key.

    KzSetting.initialize(apiKey: "API KEY", md5Key: "MD5 KEY")
Get RSA public key from `ApiAction.GetBasicKey` and `ApiAction.GetKey`, configure with `KzSetting.setBasicKey` and `KzSetting.setPublicKey`

    ApiAction.GetBasicKey().addListener(ApiListener<ApiAction.GetBasicKey.Result>.init(onSuccess: { (result) in
        guard let basicKey = result.body?.data?.basicKeyString else {
            return
        }
        
        KzSetting.setBasicKey(basicKey)
        ApiAction.GetKey().addListener(ApiListener<ApiAction.GetKey.Result>.init(onSuccess: { (result) in
            guard let clientPublicKey = result.body?.data?.publicKeyString else {
                return
            }
            
            //Initialization Completed
            KzSetting.setPublicKey(clientPublicKey)
        }, onFail: self.handleError)).post()
    }, onFail: self.handleError)).post()