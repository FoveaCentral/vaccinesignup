# Vaccine Notifier

[![test](https://github.com/ivanoblomov/vaccine-notifier/actions/workflows/test.yml/badge.svg)](https://github.com/ivanoblomov/vaccine-notifier/actions/workflows/test.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/dad2d32da2d576e4a99a/maintainability)](https://codeclimate.com/github/ivanoblomov/vaccine-notifier/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/ivanoblomov/vaccine-notifier/badge.svg?branch=main)](https://coveralls.io/github/ivanoblomov/vaccine-notifier?branch=main)

This app notifies users who tweet their zip codes to [@vaccinesignup](https://twitter.com/vaccinesignup/) about available vaccine appointments in their area.

## Usage

1. To sync vaccination Locations with LA County's data:
```
rake vaccinesignup:sync_locations
```
2. To read direct messages for zip codes that users follow:
```
rake vaccinesignup:read_dms
```
3. To notify users about new appointments in their zip code:
```
rake vaccinesignup:notify_users
```

## Copyright

Copyright © 2021 Roderick Monje. See [LICENSE](LICENSE) for further details.
