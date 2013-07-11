class CreateCompany < ActiveRecord::Migration
  def up
    create_table :companies do |t|
      t.string :name, :null => false
      t.string :description, :null => false, :length => 500
      t.string :company_type, :null => false #"insurance"=>保险公司,"evaluator"=>评估公司
      t.boolean :is_approval, :null=>false, :default=>false
      t.string :approval  #审核描述
      t.date :approved_at #审核日期
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.timestamps
    end
    create_table :company_files do |t|
      t.references :company, :null => false
      t.string :company_file_file_name
      t.integer :company_file_file_size
      t.integer :type
      #1。委托人身份证正反面， 2.企业营业执照， 3.授权委托书。      
      t.timestamps
    end
  end

  def down
    drop_table :companies
    drop_table :company_files
  end
end
