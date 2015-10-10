module PermittedAttributes
    ATTRIBUTES = [
      :accident_attributes,
      :alert_attributes,
      :blog_category_attributes,
      :blogcomment_attributes,
      :blogpost_attributes,
      :bonuspoint_attributes,
      :car_attributes,
      :car_file_attributes,
      :car_model_attributes,
      :company_attributes
      ]

    mattr_reader *ATTRIBUTES

    @@accident_attributes = [
      :chejiaohao_sousun, :chuli_fangshi,:shifou_caijian, :chuxian_jingguo, :chuxian_riqi, :duifang_baoxian, :gusun_jine, :pengzhuang_buwei, :renshang_qingkuang, :sunshi_leixing, :zeren_rending,
        :tingche_province_id, :tingche_city_id, :tingche_more,
        :guohu_shixiao, :huji_province_id, :huji_city_id, :huji_more,
        :gouzhi_shui, :chepai, :yaoshi,
        :weituo_xieyi, :youwu_diya, :youwu_qita,
        :dengji_zhengshu, :xingche_zheng,
        :weizhang, :cheliang_beizhu
    ]

    @@alert_attributes = [  :text  ]

    @@blog_category_attributes = [:name, :short_name]

    @@blogcomment_attributes = [:content, :admin, :user_id, :blogpost_id]

    @@blogpost_attributes = [:content, :title, :admin, :category_id]

    @@bonuspoint_attributes = [:points, :for_what, :user_id]

    @@car_attributes = [:engine_number, :frame_number, :variator, :model_id, :model_name, :plate_number, :registered_at, :serial_no, :displacement, :status, :bidding_price,
      :final_compensate_price, :owner_name, :owner_phone, :pickup_contact_person, :pickup_contact_phone, :pay_method, :pickup_start_at, :pickup_expired_at,
      :pickup_address, :giveup_auction_reason, :giveup_pickupcar_reason, :giveup_transfer_reason,
      :publisher_id, :evaluator_id,
      :accident_attributes, :auction_attributes, :car_license_image_ids, :car_frame_image_ids, :car_image_ids, :car_doc_ids,
      :chengbao_jine, :gusun_jine, :shiji_jiazhi, :canzhi_jiazhi, :ershou_jiazhi]

    @@car_file_attributes = [:uploaded, :car_id]

    @@car_model_attributes = [:initial, :name]

    @@company_attributes = [:parent_id, :name ,:description, :company_type , :is_approval, :approval, :approved_at, :address, :agent_name, :agent_id, :company_id]

end
