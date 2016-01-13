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

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
