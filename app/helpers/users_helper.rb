module UsersHelper

  def users_current_answer
    current_user.answers.where('created_at BETWEEN ? AND ?',
    DateTime.now.beginning_of_day, DateTime.now.end_of_day).first
  end

  def self.new_title
    format = choose_format
    title = []

    format.each do |word|
      case word
      when :adj
        title << adjective
      when :honorific
        title << honorific
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
              # [:the, :adj, :honorific, :of, :plural],
              # [:honorific, :plural],
              # [:the, :adj, :sing],
              [:the, :sing, :who, :verb, :plural]
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
       Supine Threatening Wheezy Whispering White Youngish).sample.humanize.titlecase
  end

  def self.honorific
    %w(Doctor Lord Sir Captain Colonel General Major Representative
      Senator Coach Father Officer Emporer Speaker Councillor Governor
      Sultan Prince Duke Pope Archduke Baron Baroness Ambassador
      Squire Rogue Pilot Bride Mayor Secretary Princess Prince Archduke
      Senator President Assistant Private Corporal Sgt Marquis Count Lord
      Assisstant_to_the_Assistant Queen Attorney Judge Brother Sister
      First_Officer Commander Nurse Chief Citizen
      Darth Alpha Journeyman Highwayman Viceroy Master).sample.humanize.titlecase
  end

  def self.plural
    %w(Monsters Dragons Doom Swelling Teeth Fright Chocolate Cupcakes
       Coffee Airplanes Coding Computers Styrofoam Carpet Beer Waffles
       Dolphins Couches Spoon Forks Magic Name_Brand_Desserts Stillness
       Ice Pork Handshakes Plastic Drainage Neckties Bubble_Gum Pickles
       Stains Swimming_Pools Bees Popcorn Trunks Trampolines Ketchup
       Tea Mountain_Climbing Fence_Building Muck_Raking Dog_Sitting
       Tooth_Aching Flat_Tires Unfinished_Novels Sword_Fighting
       Staying_up_late Car_Parts Soup The_Dishes_We_Never_Use
       Fence_Painting Book_Reading Snacks Charts Presentations
       Executive_Summaries).sample.humanize.titlecase
  end

  def self.singular
    %w(Monster Dragon Cupcake Airplane LineBreak Styrofoam Carpet
       Beer Waffle Dolphin Couch Spoon Fork Football Sloth Armada
       Wasp Puddle Crate Cardboard_Box Muscle Hamster Wolf Seal
       Cyclone Tornado Bottle Key Germ Seed Duck Peanut Panther
       Monster Book Novel Storm Window Eye Donkey Apple Garlic
       Taco Burrito Cartoon Target Wheel Pipe Portal Peel Desk Monitor
       Torpedo Boy Man Friend Uncle Tailor Baker Mouse Player
       Field Spaceman Dik-Dik Gun).sample.humanize.titlecase
  end

  def self.verb
    %w(Cries Jumps Visits Saws Chops Cooks Eats Bills Builds
       Drives Rides Kills Makes Drinks Calls Reads Licks Borrows
       Destroys Creates Consumes Throws Clothes Feeds Employs
       Emails Quits Dunks Pops Compartmentalizes Moves Buys Pays
       Sells Tries Collects Grows Climbs Clubs Strikes Hugs Paints
       Kisses Breaks Watches Hears Fixes Sees Conducts).sample.humanize.titlecase
  end
end
