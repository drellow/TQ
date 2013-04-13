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
      when :verb
        title << verb
      end
    end
    final_title = title.join(" ")
    final_title[0] = final_title[0].titlecase
    final_title
  end

  def self.choose_format
    formats = [
              [:the, :adj, :plural, :verb, :the, :adj, :plural]
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
    %w(Monsters Dragons Doom Swelling Teeth Fright Chocolate Cupcakes
       Coffee Airplanes Coding Computers Styrofoam Carpet Beer Waffles
       Dolphins Couches Spoon Forks Magic Name_Brand_Desserts Stillness
       Ice Pork Handshakes Plastic Drainage Neckties Bubble_Gum Pickles
       Stains Swimming_Pools Bees Popcorn Trunks Trampolines Ketchup
       Tea Mountain_Climbing Flat_Tires Sword_Fighting Car_Parts Soup 
       Book_Reading Snacks Charts Presentations Jam).sample.humanize.downcase
  end

  def self.singular
    %w(Monster Dragon Cupcake Airplane LineBreak Styrofoam Carpet
       Beer Waffle Dolphin Couch Spoon Fork Football Sloth Armada
       Wasp Puddle Crate Cardboard_Box Muscle Hamster Wolf Seal
       Cyclone Tornado Bottle Key Germ Seed Duck Peanut Panther
       Monster Book Novel Storm Window Eye Donkey Apple Garlic
       Taco Burrito Cartoon Target Wheel Pipe Portal Peel Desk Monitor
       Torpedo Boy Man Friend Uncle Tailor Baker Mouse Player
       Field Spaceman Dik-Dik Gun).sample.humanize.downcase
  end

  def self.verb
    %w(cried fell dunked cooked_shellfish ate_a_dog built coded painted
       drove rode killed Drinks read licked borrowed twirled_and_twirled
       destroyed created consumed threw clothed fed got_addicted_to
       emailed quilted dunked popped comparmentalized move bought paid piloted
       sold collected grew climbed clubbed struck hugged painted landed
       kissed broke watched heard fixed saw conducted hid_behind).sample.humanize.downcase
  end
  
end
