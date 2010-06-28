# PITBOSS

The bmoreonrails poker game runner. Dreamed over lunch on day 4 of RailsConf, conceived at the [June open source hack night](http://www.meetup.com/bmore-on-rails/calendar/13566036/).

## Thoughts

* Each contestant will build their own bot, and submit it to the game
* The game is Texas Hold 'em ([Rules](http://poker.about.com/od/poker101/ht/holdem101.htm))
* Contestants host their own bot on their own server and write it in their language of choice (rails, sinatra, node.js, mod_perl, cold fusion, etc)
* We will run the server once a week at a certain time for a certain number of games, and see who wins the most tournaments/"money".
* Results will be published. Poor implementations will be ridiculed.
* Tweak your bot. Resubmit. Good luck!

## Contribute! What's next:

* Our first goal is to get the game loop running in ruby
* We need ranking of hands. Some movement was done integrating [ruby_poker](http://rubyforge.org/projects/rubypoker/)
* We need to keep track of the pot. Also side pots
* Define the communication between the server and the bots. Stateless - the entire state of the current hand should be passed. The bot can respond with *fold* or *bet* (a bet can be a call or a raise)
* Then we build bots (players). Starting with some reference bots to get folks started.
* The communication between game and bots could be over HTTP (there were some some rumblings of XMPP)

## Thanks

Thanks to @subelsky for the name. Thanks to @flipsasser and @nerdEd for their intense excitement about the idea. Thanks to @flipsasser for the prodigious amount of code/specs produced at the June OSHN. *Contribute - we'll thank you next.*