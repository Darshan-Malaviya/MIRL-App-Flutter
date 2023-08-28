<!--
The package is used for the API call handling. 
The package uses Dio for the API and uses shared preference to store data locally.
-->

TODO: Initialize the path provider package in your main.dart
file.[common/service/path_provider.dart]

## Features

1. All API calls are handled with Dio.
2. Manage cache data with dio_cache_interceptor and dio_cache_interceptor_hive_store. If you don't
   have an Internet, then it will take data from hive storage. It is used to enhance the user's
   experience.