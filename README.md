# GasolinaMX

API for gasoline prices open data provided by the Mexican Government. It's developed in Ruby On Rails.

## Endpoints

### Near Gas Stations

    /api/v1/near?latitude=<LAT>&longitude=<LONG>&qty=<QTY>
    
 **Parameters**
|Param|Description|Optional|Default|
|---|---|---|---|
|latitude|GPS Latitude   |   |   |
|longitude|GPS Longitude   |   |   |
|qty   |How many gas stations|true|5  |

**Returns**

JSON:
```
[
  {"name":"IMPULSORA SAN FELIPE SA DE CV","latitude":"28.63716","longitude":"-106.1226","regular":"22.29","premium":"24.39","diesel":"22.69","last_update":"2022-04-10T01:53:05.628Z","distance":"0.80"},
  {"name":"SERVICIOS GASOLINEROS DE MEXICO, S.A. DE C.V.","latitude":"28.64858","longitude":"-106.1109","regular":"22.09","premium":"24.25","diesel":null,"last_update":"2022-04-10T01:53:05.628Z","distance":"0.93"},
  {"name":"SERVICIOS GASOLINEROS DE MEXICO, S.A. DE C.V.","latitude":"28.63342","longitude":"-106.119","regular":"22.29","premium":"24.39","diesel":null,"last_update":"2022-04-10T01:53:05.628Z","distance":"0.95"},
  {"name":"PRONTOGAS, S.A. DE C.V.","latitude":"28.64582","longitude":"-106.1255","regular":"21.49","premium":"24.29","diesel":null,"last_update":"2022-04-10T01:53:05.628Z","distance":"1.03"},
  {"name":"servicio express sa de cv ","latitude":"28.64613","longitude":"-106.1287","regular":"21.59","premium":"23.99","diesel":"22.39","last_update":"2022-04-10T01:53:05.628Z","distance":"1.33"}
] 
```

## Update prices

Data is loaded from XML files provided by Mexican Government Open Data from this site:

https://datos.gob.mx/busca/dataset/ubicacion-de-gasolineras-y-precios-comerciales-de-gasolina-y-diesel-por-estacion

There is a task for update places and prices, run:

    rake datosabiertos:update


## Test API

I have deployed this API for test at:

[https://gasolinamx.herokuapp.com/api/v1/](https://gasolinamx.herokuapp.com/api/v1/)

And the [simplest client](https://github.com/ionmx/gasolinamx/tree/main/client-sample) for this API at:

[https://suavizado.com/gasolina/](https://suavizado.com/gasolina/)
