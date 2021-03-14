# Vaccine Notifier

[![test](https://github.com/ivanoblomov/vaccine-notifier/actions/workflows/test.yml/badge.svg)](https://github.com/ivanoblomov/vaccine-notifier/actions/workflows/test.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/dad2d32da2d576e4a99a/maintainability)](https://codeclimate.com/github/ivanoblomov/vaccine-notifier/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/ivanoblomov/vaccine-notifier/badge.svg?branch=main&kill_cache=1)](https://coveralls.io/github/ivanoblomov/vaccine-notifier?branch=main)

This app notifies users who tweet their zip codes to [@vaccinesignup](https://twitter.com/vaccinesignup/) about available vaccine appointments in their area.

## Usage

### Users

1. Follow [@vaccinesignup](https://twitter.com/vaccinesignup/).

2. DM [@vaccinesignup](https://twitter.com/vaccinesignup/) a zip code only:
```
90210
```

3. The bot will DM you available appointments in that zip:
```
Appointments now available at:

Rite Aid Pharmacy #5461 (463 North Bedford Drive, Beverly Hills, CA 90210). Check eligibility and sign-up at https://riteaid.com/pharmacy/covid-qualifier…

Rite Aid Pharmacy #5462 (300 North Canon Drive, Beverly Hills, CA 90210). Check eligibility and sign-up at https://riteaid.com/pharmacy/covid-qualifier…
```

### Developers

1. To sync Locations and, if there are changes, notify users:
```
rake vaccinesignup:sync_and_notify
```
2. To read DMs and, if there are subscribed zip codes, notify users:
```
rake vaccinesignup:read_and_notify
```

When configuring bots for production, the timing on both should be optimized depending on how often Locations are updated and DMs are tweeted, respectively.

## Copyright

Copyright © 2021 Roderick Monje. See [LICENSE](LICENSE) for further details.
