# 移动端安装页

这个目录已经包含一个静态安装页，同时支持 iOS OTA 和 Android APK 下载：

- `index.html`: 手机访问的安装页
- `manifest.plist`: iOS OTA 安装清单
- `downloads/App.ipa`: iOS 安装包
- `downloads/app-debug.apk`: Android 安装包
- `assets/icon.png`: 页面和 manifest 使用的图标

## 需要你提供或修改的信息

当前已配置为 GitHub Pages 地址：

```text
https://egeorgm.github.io/ios-ota-install
```

如果你后续换域名或仓库名，可以重新执行：

```bash
./configure.sh https://你的域名/ios-ota-install
```

需要改这些文件：

- `index.html` 里的 `manifest.plist` 链接
- `index.html` 里的 `app-debug.apk` 链接
- `manifest.plist` 里的 `App.ipa`、`icon.png` 链接

## GitHub Pages 发布

1. 在 GitHub 创建仓库 `ios-ota-install`。
2. 把本目录所有文件推到仓库的 `main` 分支。
3. 在仓库 `Settings` -> `Pages` 里选择 `Deploy from a branch`。
4. 分支选择 `main`，目录选择 `/root`。
5. 发布完成后，用手机浏览器打开：

```text
https://egeorgm.github.io/ios-ota-install/
```

## 部署要求

- 必须使用 HTTPS，且证书要被 iPhone 信任。
- 用 iPhone Safari 打开 `index.html`，不要用微信内置浏览器。
- 如果这个包是 Ad Hoc 或 Development 签名，设备 UDID 必须被签名描述文件包含。
- 没加 UDID 的外部用户需要走 TestFlight，不能靠 OTA 页面直接安装普通 Ad Hoc 包。
- Android 下载 APK 后，需要允许当前浏览器安装未知来源应用。

## Nginx MIME 示例

```nginx
types {
  application/octet-stream ipa;
  application/vnd.android.package-archive apk;
  text/xml plist;
}
```
