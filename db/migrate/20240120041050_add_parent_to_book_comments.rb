class AddParentToBookComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :book_comments, :parent, foreign_key: { to_table: :book_comments }
  end
end
