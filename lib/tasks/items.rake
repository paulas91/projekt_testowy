require_relative '../items_manager'

namespace :items do
  task fix_users_associations: :environment do
    p 'Fixing items associations'
    user = User.find_by_email('paulinka30@poczta.onet.eu')
    ItemsManager.new.fix_items_and_users_associations(user: user)
    p 'Finished'
  end

end
