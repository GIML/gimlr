# gimlr
[![Build Status](https://secure.travis-ci.org/GIML/gimlr.png)](http://travis-ci.org/GIML/gimlr)

Ruby parser for [GIML](https://github.com/GIML/giml).

<a href="https://evilmartians.com/?utm_source=gimlr">
<img src="https://evilmartians.com/badges/sponsored-by-evil-martians.svg" alt="Sponsored by Evil Martians" width="236" height="54">
</a>

## Install

```bash
$: gem install gimlr
```

Or in `Gemfile`

```ruby
gem 'gimlr'
```

## Usage

```ruby
Gimlr.parse_string ":num: num_var\n1234" # => { "num_var" => 1234 }
Gimlr.parse_file file_path
```

## Benchmarks

Small files (which in test folder):

```
Calculating -------------------------------------
                json     8.035k i/100ms
               gimlr     1.487k i/100ms
                yaml   541.000  i/100ms
             toml-rb    73.000  i/100ms
               tomlp    42.000  i/100ms
                toml    12.000  i/100ms
-------------------------------------------------
                json     88.547k (± 2.3%) i/s -    885.206k
               gimlr     15.244k (± 3.7%) i/s -    153.161k
                yaml      5.777k (± 5.1%) i/s -     57.887k
             toml-rb    726.229  (± 3.7%) i/s -      7.300k
               tomlp    422.652  (± 6.2%) i/s -      4.242k
                toml    128.168  (± 3.9%) i/s -      1.284k

Comparison:
                json:    88547.4 i/s - 5.82x faster
               gimlr:    15244.1 i/s
                yaml:     5776.5 i/s - 2.64x slower
             toml-rb:      726.2 i/s - 21.40x slower
               tomlp:      422.7 i/s - 35.09x slower
                toml:      128.2 i/s - 115.72x slower
```

Big files (~43k lines - just replicated data with same structure as test/test_files)

```
Calculating -------------------------------------
                json     1.000  i/100ms
               gimlr     1.000  i/100ms
                yaml     1.000  i/100ms
-------------------------------------------------
                json     43.129  (± 8.7%) i/s -    2136.000
               gimlr     17.822  (±11.2%) i/s -    883.000
                yaml      3.536  (± 0.0%) i/s -    177.000

Comparison:
                json:       43.1 i/s - 2.42x faster
               gimlr:       17.8 i/s
                yaml:        3.5 i/s - 5.04x slower
```
