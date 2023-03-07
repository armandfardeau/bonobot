# Bonobo
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'bonobot'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install bonobot
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## TODO:
Utiliser un initializer pour determiner les fichiers à surveiller
faire un hash sous la forme:
[ chemin => EngineFile]

Au lancement du status faire un match du chemin local avec le fichier de la gem pour déterminer l'override

idées: 
- créer un fichier json dans tmp
- Utiliser des ractors pour les threads et calculer le status
- utiliser des ractors pour déterminer les fichiers et calculer les hashs (Thread pool?)