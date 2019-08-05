#依赖：
path_provider: ^1.1.2

#引用
import 'package:path_provider/path_provider.dart';
import 'dart:io';

#####使用：

Directory tempDir = await getTemporaryDirectory();
String tempPath = tempDir.path;
## iOS => Library/Caches
## 安卓=> /data/user/0/com.example.skill_tree/cache

Directory appDocDir = await getApplicationDocumentsDirectory();
String appDocPath = appDocDir.path; 
# iOS => Documents
# 安卓 => Directory: '/data/user/0/com.example.skill_tree/app_flutter'


##########   注意：安卓的需要申请文件权限才能操作