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
      end
    end
    final_title = title.join(" ")
    final_title[0] = final_title[0].titlecase
    final_title
  end

  def self.choose_format
    formats = [
              [:the, :adj, :honorific, :of, :plural],
              [:honorific, :plural],
              [:the, :adj, :sing]
              ]
    formats.sample
  end

  def self.adjective
    %w(Asthmatic Aging Bald Black Boring Brave Brown Cheery Dark Dorky Energetic
       Filthy Frozen Gold Happy Holy Imaginary Jolly Loud Magical
       Mighty Mighty Miserable New Old Once-Great Pale Patient
       Patronizing Poor Prone Red Rich Rogue Salty Shiny Skinny Slippy
       Supine Threatening Wheezy Whispering White Youngish).sample
  end

  def self.honorific
    %w(Doctor Lord Sir Pubah Captain Colonel General Excellency
      Senator Coach Skipper Father Officer Emporer Lamane
      Sultan Prince Duke Pope Archduke Baron Baroness
      Squire Chaplain Rogue Designer Pilot Bride Groom Mayor
      Senator President Friend Assistant
      Assisstant-to-the-Assistant).sample
  end

  def self.plural
    %w(Monsters Dragons Doom Swelling Teeth Fright Chocolate Cupcakes
       Coffee Airplanes Coding Computers Styrofoam Carpet Beer Waffles
       Dolphins Couches Spoon Forks Magic Name-Brand-Desserts Stillness
       Ice Pork Handshakes Plastic Drainage Neckties Bubble-Gum Pickles
       Stains Swimming-Pools Bees).sample
  end

  def self.singular
    %w(Monster Dragon Cupcake Airplane LineBreak Styrofoam Carpet
       Beer Waffle Dolphin Couch Spoon Fork Football Sloth Armada
       Wasp Puddle Crate Cardboard-Box Muscle Hamster Wolf Seal
       Cyclone Tornado Bottle Key Germ Seed).sample
  end
end
