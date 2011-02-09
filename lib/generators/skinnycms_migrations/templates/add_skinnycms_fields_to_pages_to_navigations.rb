class AddSkinnycmsFieldsToPagesToNavigations < ActiveRecord::Migration
  def self.up
    # add_column :pages_to_navigations, :nav_id, :integer
    # add_column :pages_to_navigations, :page_id, :integer
    # add_column :pages_to_navigations, :parent_id, :integer
    # add_column :pages_to_navigations, :position, :integer
    # add_column :pages_to_navigations, :visibility, :string
  end

  def self.down
    # remove_column :pages_to_navigations, :nav_id
    # remove_column :pages_to_navigations, :page_id
    # remove_column :pages_to_navigations, :parent_id
    # remove_column :pages_to_navigations, :position
    # remove_column :pages_to_navigations, :visibility
  end
end