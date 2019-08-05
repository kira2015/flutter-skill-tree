# 天气动画

使用的方法很简单

比如使用太阳动画
```
              WeatherSunny(
                sunnySize: width,
                sunColor: Colors.deepOrange,
                showBorder: true,
              ),
```

可以自定义太阳的大小，颜色，转动周期的时长等



如果使用的是雨、雪动画，也非常简单

```
              WeatherDropping(
                borderDecoration: BoxDecoration(
                  color: Colors.black
                ),
                droppingHeight: width,
                droppingWidth: width,
                droppingColor: Colors.white,
                droppingLevel: DroppingLevel.medium,
                droppingType: DroppingType.snow,
              ),
```

通过 **droppingType** 参数来控制下降的是与还是雪，通过 **droppingLevel** 参数控制雨雪的数量。
也可以通过 **droppingWidget** 参数来自定义下落的控件。