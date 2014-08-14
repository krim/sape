class CreateSapeStorage < ActiveRecord::Migration
  def change
    create_table :sape_configs do |t|
      t.string :name
      t.text :value, limit: 500
    end

    create_table :sape_links do |t|
      t.string :page
      t.string :anchor
      t.string :url
      t.string :host
      t.text :raw_link, limit: 500
      t.string :link_type
    end
    add_index :sape_links, [:link_type, :page]
  end
end