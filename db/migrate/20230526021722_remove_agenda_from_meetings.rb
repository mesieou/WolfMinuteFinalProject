class RemoveAgendaFromMeetings < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :agenda, :text
  end
end
