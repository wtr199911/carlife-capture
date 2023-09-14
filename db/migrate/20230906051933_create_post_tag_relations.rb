class CreatePostTagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tag_relations do |t|
      t.references :post_id, null: false, foreign_key: true
      t.references :tag_id, null: false, foreign_key: true

      t.timestamps
    end

    # 同じタグは２回保存出来ない
    add_index :post_tag_relations, [:post_id,:tag_id],unique: true

  end
end
