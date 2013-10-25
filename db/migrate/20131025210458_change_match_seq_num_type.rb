class ChangeMatchSeqNumType < ActiveRecord::Migration
  def up
    change_column :matches, :match_seq_num, :bigint
  end

  def down
    change_column :matches, :match_seq_num, :int
  end
end
