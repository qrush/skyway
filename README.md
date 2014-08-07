# Skyway

(Unofficial) stats and community site for [Aqueous](http://www.aqueousband.com/).

## Setup (OSX)

Install [Homebrew](http://brew.sh/) and [Pow](http://pow.cx), then:

``` shell
# Add rbenv to bash so that it loads every time you open a terminal
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

# Install Ruby 2.1.2 and set it as the default version
rbenv install 2.1.2
rbenv global 2.1.2
```

Then:

``` shell
git clone git@github.com:qrush/skyway.git
cd skyway
script/setup -v
```

And make sure to link your app with Pow! Assuming you installed it in `~/Dev`:

``` shell
cd ~/.pow
ln -s ~/Dev/skyway
```

## License

MIT. See `LICENSE`.
