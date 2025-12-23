# SifliOTAManagerSDK
## 集成方式

 swift package 引入
 
```
https://github.com/OpenSiFli/SifliOTAManagerSDK.git
```

 cocoapod 引入
 
 ```bash
 pod 'SifliOTAManagerSDK','1.3.2'
 ```
## 接口调用
### ota nand

```
// 开启NAND升级
    /// - Parameters:
    ///   - targetDeviceIdentifier: 目标设备的identifier字符串。通过CBPeripheral.identifier.uuidString获取
    ///   - resourcePath: 1.可以输入一个zip格式的资源文件本地路径,sdk将会解压后检索orderFile;2.可以输入资源路径本地根目录,sdk将会在那里检索orderFile,传输过程不可变动目录内容。为nil表示本次升级不涉及资源文件
    ///   - controlImageFilePath: 与Image升级文件对应的control文件的本地路径。
    ///   - imageFileInfos: Image文件本地地址与类型信息。如果controlImageFilePath为nil则忽略该参数
    ///   - tryResume: 是否尝试启用续传功能。
    ///   - 发送Image部分时，设备的回复频率。默认4（即SDK发送20包数据，设备进行一次回复），数值越大理论上速度越快，但超过设备的处理能力反而会因为重发而降低整体的发送速度，因此该值需要依据具体的设备性能而定。
    @objc public func startOTANand(targetDeviceIdentifier:String,resourcePath:URL?, controlImageFilePath:URL?, imageFileInfos:[SFNandImageFileInfo], tryResume:Bool, imageResponseFrequnecy:UInt8 = 4)
```
### ota nor v2

```
 /// 开启NorV2升级
    /// - Parameters:
    ///   - targetDeviceIdentifier: 目标设备的identifier字符串。通过CBPeripheral.identifier.uuidString获取
    ///   - controlImageFilePath: 与Image升级文件对应的control文件的本地路径。
    ///   - imageFileInfos: image文件信息列表。包含image文件本地路径以及image文件类型。
    ///   - tryResume: 是否尝试启用续传功能。
    ///   - 发送Image时，设备的回复频率。默认20（即SDK发送20包数据，设备进行一次回复），数值越大理论上速度越快，但超过设备的处理能力反而会因为重发而降低整体的发送速度，因此该值需要依据具体的设备性能而定。
    @objc public func startOTANorV2(targetDeviceIdentifier:String, controlImageFilePath:URL, imageFileInfos:[SFNorImageFileInfo], tryResume:Bool, responseFrequency:UInt8 = 20)
```

## 更新历史

- 1.2.22 增加nand image id7,8,9,10
- 1.2.24 低于13.0系统不检查ctrl file.
- 1.2.25 ota norv1 最后一包必须回复。处理failToConnect事件。
- 1.2.26 ota norv1 无回复发送增加5毫秒间隔，发送数据超时降低到40秒,可触发超时重传
- 1.2.27 ota norv1 延迟发送提交到主线程串行队列
- 1.2.28 ota norv1 norv2 修复续传问题
- 1.2.29 ota nand 优化
- 1.2.30 ota nor offline
- 1.2.31 ota nand
- 1.2.32 ota nand order najumber 改为UInt16,增加文件超过范围检查
- 1.2.33 适配iOS18，蓝牙工作队列优化
- 1.2.34  ble流控优化
- 1.2.35 sdk-ota nor offline 支持回复频率
- 1.2.36 lose check 重试从timer切换到blequeue