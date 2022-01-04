# @vaccinesignup

[![test](https://github.com/FoveaCentral/vaccinesignup/actions/workflows/test.yml/badge.svg)](https://github.com/FoveaCentral/vaccinesignup/actions/workflows/test.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/9818a986253d2a477bb8/maintainability)](https://codeclimate.com/github/FoveaCentral/vaccinesignup/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/FoveaCentral/vaccinesignup/badge.svg?branch=main&kill_cache=1)](https://coveralls.io/github/FoveaCentral/vaccinesignup?branch=main)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/5405/badge)](https://bestpractices.coreinfrastructure.org/projects/5405)

This Twitter bot notifies users who DM their zip codes to [@vaccinesignup](https://twitter.com/vaccinesignup/) about available vaccine-appointment Locations in their area. Our current data source only supports LA County.

## Usage

### Users

1. Follow [@vaccinesignup](https://twitter.com/vaccinesignup/).

2. DM [@vaccinesignup](https://twitter.com/vaccinesignup/) a zip code only:

   ![zip](https://user-images.githubusercontent.com/113809/111058905-b2b68e00-845f-11eb-99d1-3aa0b4adcaad.png)

3. The bot will DM you available Locations in that zip:

   ![appointments](https://user-images.githubusercontent.com/113809/111059071-bc8cc100-8460-11eb-9148-74998844b8e9.png)

4. To stop all notifications, DM `stop` to [@vaccinesignup](https://twitter.com/vaccinesignup/).

### Developers

#### Installation

1. Set your Twitter API keys as environment variables:

    ```bash
    export POSTGRES_USER=[postgres user]
    export POSTGRES_PASSWORD=[postgres password]
    export TWITTER_CONSUMER_KEY=[your key]
    export TWITTER_CONSUMER_SECRET=[your secret]
    export TWITTER_ACCESS_TOKEN=[your access token]
    export TWITTER_ACCESS_SECRET=[your access secret]
    ```

2. Install dependencies with Bundler:

    ```ruby
    bundle install
    ```

#### Available Tasks

```bash
$ rake -T|grep vacc
rake vaccinesignup:back_up              # Back-up production data and restore to the local environment
rake vaccinesignup:delete_real_users    # Delete real (non-test) users from development environment
rake vaccinesignup:read_and_notify      # Read DMs and, if there are subscribed zip codes, notify users
rake vaccinesignup:reset_staging        # Back-up production, restore locally, and delete real users for testing
rake vaccinesignup:sync_and_notify      # Sync Locations and, if there are changes, notify users
```
When configuring tasks for production, the timing on both should be optimized depending on how often Locations are updated and DMs are tweeted, respectively.

#### Mirror Production Locally

1. Configure environment variables:
    ```bash
    export TWITTER_CONSUMER_KEY=[your key]
    export TWITTER_CONSUMER_SECRET=[your secret]
    export TWITTER_ACCESS_TOKEN=[your token]
    export TWITTER_ACCESS_SECRET=[your access secret]
    ```
2. Reset local database to a known state:
    ```bash
    bundle ex rake db:reset
    ```
3. Back-up production data and restore to the local environment:
    ```bash
    bundle ex rake vaccinesignup:back_up
    ```

#### Release Testing

1. Reset local/staging environment:
    ```bash
    bundle ex rake vaccinesignup:reset_staging
    ```
2. Test location syncing/notification:
    ```bash
    bundle ex rake vaccinesignup:sync_and_notify
    ```
3. Test reading DMs/notification:
    ```bash
    bundle ex rake vaccinesignup:read_and_notify
    ```

## [Contributing to @vaccinesignup](.github/CONTRIBUTING.md)

## Cheers!

<a href="https://www.buymeacoffee.com/oblomov" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-green.png" alt="Buy Me A Coffee" height="41" width="174" ></a>

## Copyright

Copyright © 2021-2022 Roderick Monje. See [LICENSE](LICENSE) for further details.
