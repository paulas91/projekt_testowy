# frozen_string_literal: true

module ItemsHelper
  def nav_link_path(path)
    ['nav-link', ('active' if current_page?(path))]
  end
end
