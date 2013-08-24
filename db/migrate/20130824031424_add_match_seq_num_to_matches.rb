class AddMatchSeqNumToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :match_seq_num, :integer
  end
end
