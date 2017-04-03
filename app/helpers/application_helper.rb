module ApplicationHelper
  def to_hankaku(str)
    str.tr('A-Za-z')
  end
end
