Closes: #

# Goal
What problem does this pull request solve? This should be close to the goal of the issue this pull request addresses.

# Approach
1. **Describe, in numbered steps, the approach you chose** to solve the above problem.
    1. This will help code reviewers get oriented quickly.
    2. It will also document for future maintainers exactly what changed (and why) when this PR was merged.
2. **Add specs** that either *reproduce the bug* or *cover the new feature*. In the former's case, *make sure it fails without the fix!*
3. Document any new public methods using standard RDoc syntax, or update the existing RDoc for any modified public methods. As an example, see the RDoc for `Location.find_or_init`:

```ruby
  # Finds or initializes the Location with the specified attributes.
  #
  # @param attr [Hash] the attributes for the Location
  # @return [Location] the found or initialized Location
  # @example
  #   Location.find_or_init({ la_id: '1', address1: '1261 W 79th Street' })
  def self.find_or_init(attr)
    la_id = attr.delete('id') || attr.delete('c')
    attr.delete('lat-lon') # delete duplicate key
    location = find_by_best_key(la_id: la_id, address1: attr['addr1']) || Location.new(la_id: la_id)
    common_keys = location.attributes.keys & attr.keys
    common_keys.each { |key| location[key] = attr[key] }
    location
  end
```

Signed-off-by: YOUR NAME <YOUR.EMAIL@EXAMPLE.COM>
