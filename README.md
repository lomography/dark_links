Provides concerns to find broken urls in blobs of markup and markdown.

# dark_links

Dark_links provides a module to find broken urls in blobs of html and markdown markup.
Original code was written by [@srecnig](https://github.com/srecnig), gemification by [@michaelem](https://github.com/michaelem). If you're wondering, the name dark_links is a [reference](http://zeldawiki.org/Dark_Link).

## Usage

Include ```DarkLinks::LinkValidator``` in your model or plain class and call the provided methods with the text you want to check for broken links.

```ruby
check_links("The Zelda series has a website: http://www.zelda.com/")
```

You will reccive a hash containing all the found links as keys and ```true``` (works) or ```false``` (broken) as values.

```ruby
{ "http://www.zelda.com/" => true }
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lomography/dark_links. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
