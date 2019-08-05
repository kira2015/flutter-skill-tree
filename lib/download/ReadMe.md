
[flutter_downloader](https://pub.flutter-io.cn/packages/flutter_downloader)

1. 申请权限 ： 网络权限，文件储存权限
2. 获取下载路径
3. 设置下载回调 （监听下载进度）

###依赖
$$ 
   flutter_downloader: ^1.1.7
   path_provider: 1.1.2
   permission_handler: ^3.1.0
   **progress_dialog: ^1.1.0+1**  or **percent_indicator: "^2.1.1"**  两者都是进度条显示

   fluttertoast: ^3.1.0
$$


###配置下载参数
$$
   final taskId = await FlutterDownloader.enqueue(
     url: 'your download link',
     savedDir: 'the path of directory where you want to save downloaded files',
     showNotification: true, // show download progress in status bar (for Android)
     openFileFromNotification: true, // click on notification to open downloaded file (for Android)
   );
$$

###监听下载情况
$$
    FlutterDownloader.registerCallback((id, status, progress) {
     // code to update your UI
   });
$$

###开始执行下载任务
final tasks = await FlutterDownloader.loadTasksWithRawQuery(query: query);


###删除任务
FlutterDownloader.remove(taskId: taskId, shouldDeleteContent:false);


**Note: retry() will return a new taskId (like resume())**
