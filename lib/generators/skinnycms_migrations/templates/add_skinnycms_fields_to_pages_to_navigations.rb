class AddSkinnycmsFieldsToPagesToNavigations < ActiveRecord::Migration
  def self.up
    # add_column :pages_to_navigations, :nav_id, :integer
    # add_column :pages_to_navigations, :page_id, :integer
    # add_column :pages_to_navigations, :parent_id, :integer
    # add_column :pages_to_navigations, :position, :integer
  end

  def self.down
    # remove_column :pages_to_navigations, :nav_id
    # remove_column :pages_to_navigations, :page_id
    # remove_column :pages_to_navigations, :parent_id
    # remove_column :pages_to_navigations, :position
  end
end