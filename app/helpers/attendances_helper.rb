module AttendancesHelper
  ATTENDED_TRUE_TEXT = "Oops, I wasn't there".freeze
  ATTENDED_FALSE_TEXT = 'I attended this show'.freeze

  def link_to_attend(attended_shows, show)
    return link_to(ATTENDED_FALSE_TEXT, '#', onclick: 'skyway.lock.show()', data: { attended: false }) unless signed_in?

    attended = attended_shows.include?(show)
     link_to attended ? ATTENDED_TRUE_TEXT : ATTENDED_FALSE_TEXT,
       attendances_path(show_id: show.id),
       remote: true, method: :post,
       data: {
         disable_with: 'Remembering that...',
         attended: attended,
         attended_true_text: ATTENDED_TRUE_TEXT,
         attended_false_text: ATTENDED_FALSE_TEXT
       }
  end
end
