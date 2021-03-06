module FeedItemsHelper
  
  def self.bullshit_feed_item
    format = choose_format
    title = []

    format.each do |word|
      case word
      when :adj
        title << adjective
      when :the
        title << "the"
      when :of
        title << "of"
      when :plural
        title << plural
      when :sing
        title << singular
      when :who
        title << "Who"
      when :past
        title << past_verb
      when :present
        title << present_verb
      when :are
        title << "are"
      when :is
        title << "is"
      when :adv
        title << adverb
      when :user
        title << User.all.sample.username
      end
    end
    final_title = title.join(" ")
    final_title[0] = final_title[0].titlecase
    final_title
  end

  def self.choose_format
    formats = [
              [:the, :adj, :plural, :past, :the, :adj, :plural],
              [:the, :adj, :plural, :are, :present],
              [:sing, :is, :present, :adv],
              [:user, :is, :present, :adv]
              ]
    formats.sample
  end

  def self.adjective
    %w(Asthmatic Aging Bald Bashful Beautiful Better Black Boastful Boring
       Brave Breezy Brief Bright Broad Broken Bumpy Burly Brown Bronze
       Cagey Callous Childlike Chubby Cuddly Crabby Cowardly Cool Clumsy
       Cheery  Daft Detailed Determined Draconian Dry Dull Dysfunctional
       Dark Dorky Energetic
       Filthy Frozen Gold Happy Holy Imaginary Jolly Kind Loud Magical
       Mighty Mighty Miserable New Old Once_Great Pale Patient
       Patronizing Poor Prone Red Rich Rogue Salty Shiny Skinny Slippy
       Supine Threatening Wheezy Whispering White Youngish).sample.humanize.downcase
  end

  def self.plural
    %w(Monsters Dragons Teeth Chocolate Cupcakes Presidents ballers
       Airplanes Computers Waffles Melons Clocks sprites players
       Dolphins Couches Spoons Forks Name_Brand_Desserts friends cans
       Handshakes Plastic Neckties Pickles skaters punks kids rats 
       Stains Swimming_Pools Bees Trunks Trampolines Ketchup nerds cowards
       Flat_Tires Car_Parts cowboys anarchists senators dorks heroes beans
       Snacks Charts Presentations).sample.humanize.downcase
  end

  def self.singular
    %w(Monster Dragon Cupcake Airplane LineBreak Styrofoam Carpet
       Beer Waffle Dolphin Couch Spoon Fork Football Sloth Armada
       Wasp Puddle Crate Cardboard_Box Muscle Hamster Wolf Seal
       Cyclone Tornado Bottle Key Germ Seed Duck Peanut Panther
       Monster Book Novel Storm Window Eye Donkey Apple Garlic
       Taco Burrito Cartoon Target Wheel Pipe Portal Peel Desk Monitor
       Torpedo Boy Man Friend Uncle Tailor Baker Mouse Player
       Field Spaceman Dik-Dik Gun Sasquatch).sample.humanize.downcase
  end

  def self.past_verb
    %w(cried fell dunked cooked_shellfish ate drank built coded painted
       drove rode killed Drinks read licked borrowed twirled_and_twirled
       destroyed created consumed threw clothed fed got_addicted_to
       emailed quilted dunked popped comparmentalized move bought paid piloted
       sold collected grew climbed clubbed struck hugged painted landed
       kissed broke watched heard fixed saw conducted hid_behind played
       skinned fought poked prodded kissed hugged smiled_at thanked ran_around
       biked_towards drove_to_see took_photos_of restrung tampered_with
       convinved helped_establish usually_liked).sample.humanize.downcase
  end
  
  def self.present_verb
    %w(pillow_fighting rapping bombing_hills spraypainting feeling_good
       swordfighting drinking_beers reading_books eating sitting_down
       doing_nothing_really smiling picking_up_hitchhikers driving_a_truck
       tuning_a_guitar seeing_something_weird seeing_someone_else making_out
       drinking_port messaging_me answering_questions chatting_on_aim
       being_nice playing_guitar fishing moving_furniture skating_on_thin_ice
       shooting_guns acting_coy opening_the_window sneaking_around 
       parsing_the_meaning_of_it taking_notes).sample.humanize.downcase
  end
  
  def self.adverb
    %w(mournfully direly sadly happily drunkenly boastfully badly
       pitifully powerfully dourly melodically artfully cunningly
       comfortably rudely peacefully painfully regularly stunningly
       loudly kookily oddly clumsily coaxingly coincidentally coldly
       colorfully commonly comfortably compactly daily daintily dangerously        daringly
       darkly dastardly eloquently elegantly elsewhere emotionally endlessly
       energetically enjoyably enormously finally financially finitely
       fluently fondly immensely impatiently impressively inappropriately
       incessantly incorrectly obediently obligingly obnoxiously obviously
       occasionally patiently perfectly periodically perpetually persistently
       personally sadly safely scarcely scarily scientifically searchingly
       secretively securely sedately seemingly seldom selfishly selflessly
       seriously shakily shamelessly sharply sheepishly shoddily shortly
       shrilly significantly silently simply sincerely singularly shyly
       uniformly unilaterally unimpressively unnaturally unnecessarily).sample.humanize.downcase
  end
  
end
