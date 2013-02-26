module UsersHelper

  def users_current_answer
    current_user.answers.where('created_at BETWEEN ? AND ?',
    DateTime.now.beginning_of_day, DateTime.now.end_of_day).first
  end

  def new_title
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
      when :desc
        title << descriptor
      end
    end
    final_title = title.join(" ")
    final_title[0] = final_title[0].titlecase
    final_title
  end

  def choose_format
    formats = [
              [:the, :adj, :honorific, :of, :desc],
              [:honorific, :desc]
              # [:the, :adj, :honorific, :desc]
              ]
    formats.sample
  end

  def adjective
    %w(Mighty Brave Boring Wheezy Bald Salty Slippy Holy Patient
       Skinny Once-Great Jolly Imaginary Poor Rich Loud Rogue
       Red White Black Brown Gold Dark New Filthy Energetic Magical
       Supine Prone Pale Frozen).sample
  end

  def honorific
    %w(Doctor Lord Sir Pubah Captain Colonel General Excellency
      Senator Coach Skipper Father Officer Emporer Lamane
      Sultan Prince Duke Pope Archduke Baron Baroness Sir
      Squire Chaplain Rogue Designer Pilot Bride Groom Mayor).sample
  end

  def descriptor
    %w(Monster Dragon Doom Swelling Teeth Fright Chocolate Cupcake
       Coffee Airplanes Coding Computers Styrofoam Carpet Beer Waffles
       Dolphins Couch Spoon Fork Magic Name-Brand-Desserts Stillness
       Ice Pork).sample
  end
end
