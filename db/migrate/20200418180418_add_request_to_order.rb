class AddRequestToOrder < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :requests, null: true, foreign_key: true
  end
end