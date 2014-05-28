# Romanesco

[![Gem Version](https://badge.fury.io/rb/romanesco.svg)](http://badge.fury.io/rb/romanesco)

Romanesco allows you to parse simple mathematical expressions, and creates a fully object-oriented expression tree for evaluation.

You can inject variable values at runtime so that formulae can be used, edited and re-saved as part of an application. 

Currently Romanesco supports the four basic operators (addition, subtraction, multiplication, division) as well as parentheses. It supports the use of constants and named variables.

Written by Charlie Ablett and Craig Taube-Schock, Enspiral Craftworks (http://www.enspiral.com).

MIT License.

So named because Romanesco broccoli is neat-looking and has self-repeating patterns, much like the structure of the resulting expression tree. Also, it's tasty.

## Installation

Add this line to your application's Gemfile:

    gem 'romanesco'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install romanesco

## Usage

    tree = Romanesco.parse "1+10*3"
    result = tree.evaluate #=> 31.0
    original_expression = tree.to_s #=> "1 + 10 * 3"

If you have variables, inject them as follows:

    tree = Romanesco.parse("a*(b+c)")
    result = tree.evaluate(a: 5, b: 2, c: 10) # => 100
    original_expression = tree.to_s # => "a * (b + c)"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
