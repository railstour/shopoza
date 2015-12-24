module ApplicationHelper
  def money_amount(amount)
    number_to_currency(amount, unit: 'Rp.')
  end

  def short_summary(words, length, link)
    summary = words.truncate(length, separator: ' ')
    "#{summary} #{link_to('see more', link)}".html_safe
  end

  def active_link(path)
    'active' if request.fullpath == path
  end
end
