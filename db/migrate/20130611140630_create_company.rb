class CreateCompany < ActiveRecord::Migration
  def up
    create_table :companies do |t|
      t.string :name, :null => false,:default=>''
      t.string :description, :null => false, :length => 500,:default=>''
      t.string :company_type, :null => false,:default=>'' #""=>other, "insurance"=>保险公司,"evaluator"=>评估公司
      t.boolean :is_approval, :null=>false, :default=>false
      t.string :approval  #审核描述
      t.date :approved_at #审核日期
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      
      t.string :agent_name
      t.string :address
      t.string :agent_id_file_name
      t.string :agent_id_content_type
      t.integer :agent_id_file_size
      t.datetime :agent_id_updated_at    
      t.string :company_id_file_name
      t.string :company_id_content_type
      t.integer :company_id_file_size
      t.datetime :company_id_updated_at    
      t.datetime :verified_at    
      t.timestamps
    end
  end

  def down
    drop_table :companies
  end
end
