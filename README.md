# WeatherApp

____

## Описание 

Приложение для просмотра погоды. Данные о погоде взяты из [Weather Api - OpenWeatherMap](https://openweathermap.org/api).

![screen1](/Images/WeatherApp1.png) ![screen2](/Images/WeatherApp2.png) 

____

## Функционал
+ При запуске запрашивается разрешение на отслеживание текущий геопозиции, чтобы отобразить погоду для вашего региона.
+ В приложении есть возможность отобразить погоду в интересующем вас месте. 
+ Изменение цветовой схемы при смене дневного и ночного режима.

![screen3](/Images/WeatherApp3.png) ![screen4](/Images/WeatherApp4.png) 

____

## Используемые технологии

+ Swift 5.2 (iOS 15 >)
+ Архитектура MVC + сервисный слой для работы с сетью
+ Интерфейс реализован при помощи storyboards
+ Используемы фреймворки: UIKit, CoreLocation
+ Работа с сетью: URLSession

____

## Дополнительная информация

+ Приложение написано на основе курса c портала swiftbook [Работа С API](https://swiftbook.ru/content/36-index/).
+ Для данной API требуется ключ, для получения собственного ключа необходимо зарегистрироваться [здесь](https://openweathermap.org).
+ Для того, чтобы отобразить данные для местоположения на симуляторе, можно воспользоваться дебагером.

![screen3](/Images/WeatherApp5.png)
