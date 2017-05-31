# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170517000002) do

  create_table "accidents", force: true do |t|
    t.integer  "car_id"
    t.integer  "sunshi_leixing"
    t.date     "chuxian_riqi"
    t.integer  "shifou_caijian"
    t.integer  "tingche_province_id", default: 0
    t.integer  "tingche_city_id",     default: 0
    t.string   "tingche_more"
    t.integer  "huji_province_id",    default: 0
    t.integer  "huji_city_id",        default: 0
    t.string   "huji_more"
    t.boolean  "chejiaohao_sousun"
    t.integer  "zeren_rending"
    t.string   "duifang_baoxian"
    t.integer  "renshang_qingkuang"
    t.string   "pengzhuang_buwei"
    t.string   "chuxian_jingguo"
    t.float    "zuizhong_peifu_jine", default: 0.0
    t.integer  "chuli_fangshi",       default: 0
    t.integer  "guohu_shixiao",       default: 0
    t.integer  "dengji_zhengshu",     default: 0
    t.integer  "xingche_zheng",       default: 0
    t.integer  "gouzhi_shui",         default: 0
    t.integer  "chepai",              default: 0
    t.integer  "yaoshi",              default: 0
    t.boolean  "weituo_xieyi",        default: false
    t.boolean  "youwu_diya",          default: false
    t.boolean  "youwu_qita",          default: false
    t.string   "weizhang"
    t.string   "cheliang_beizhu"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "other_fee",           default: 0.0
  end

  create_table "action_histories", force: true do |t|
    t.string   "api_name",   limit: nil
    t.string   "api_params", limit: nil
    t.string   "api_result", limit: nil
    t.integer  "auction_id"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "alerts", force: true do |t|
    t.integer  "status",     null: false
    t.integer  "author_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "auction_ratings", id: false, force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "auction_id", null: false
    t.float    "value",      null: false
    t.datetime "created_at"
  end

  add_index "auction_ratings", ["user_id", "auction_id"], name: "index_auction_ratings_on_user_id_and_auction_id"

  create_table "auctions", force: true do |t|
    t.boolean  "private",                    default: false,  null: false
    t.boolean  "delta",                      default: false
    t.integer  "status",                     default: 0,      null: false
    t.integer  "budget_id",                  default: 0,      null: false
    t.integer  "owner_id",                   default: 0,      null: false
    t.integer  "won_offer_id"
    t.string   "title",                      default: "",     null: false
    t.text     "description",                default: "",     null: false
    t.boolean  "highlight",                  default: false
    t.datetime "expired_at"
    t.integer  "offers_count",               default: 0
    t.integer  "visits",                     default: 0,      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "rating",                     default: 0.0
    t.integer  "auctioneer_id",              default: 1
    t.integer  "car_id",                     default: 0
    t.datetime "expected_start_at"
    t.datetime "expected_expired_at"
    t.datetime "public_start_at"
    t.datetime "public_expired_at"
    t.datetime "start_at"
    t.float    "starting_price",             default: 0.0
    t.float    "price_increment",            default: 0.0
    t.float    "reserve_price",              default: 0.0
    t.float    "deposit",                    default: 5000.0
    t.integer  "system",                     default: 0
    t.integer  "hall",                       default: 0
    t.string   "serial_no"
    t.string   "location"
    t.string   "type_name"
    t.string   "is_pass"
    t.string   "pass_times"
    t.datetime "commissioned_time"
    t.string   "transfer_complete"
    t.datetime "transfer_request_time"
    t.datetime "transfer_real_time"
    t.string   "remark"
    t.string   "last_api_name"
    t.string   "last_api_succeed"
    t.string   "last_api_message"
    t.string   "inquire_amount"
    t.string   "bidding_user"
    t.string   "is_entrust"
    t.string   "apply_reason"
    t.string   "inquire_result"
    t.string   "inquire_opinion"
    t.string   "feedback_result"
    t.string   "feedback_opinion"
    t.boolean  "is_auction",                 default: false,  null: false
    t.decimal  "transfer_bail",              default: 0.0,    null: false
    t.boolean  "is_pay_transfer_bail",       default: false,  null: false
    t.boolean  "is_pay_auction_price",       default: false,  null: false
    t.string   "transfer_opinion"
    t.string   "channel_transfer_result"
    t.string   "channel_transfer_opinion"
    t.string   "pay_out_type",               default: "",     null: false
    t.boolean  "is_pay_first_price",         default: false,  null: false
    t.datetime "first_price_pay_date"
    t.integer  "premium_price",              default: 0,      null: false
    t.boolean  "is_pay_premium",             default: false,  null: false
    t.datetime "premium_pay_date"
    t.string   "preservation_user",          default: "",     null: false
    t.datetime "preservation_date"
    t.string   "preservation_desc",          default: "",     null: false
    t.string   "document_group_id",          default: "",     null: false
    t.datetime "transfer_bail_pay_date"
    t.string   "iobs_token"
    t.string   "transfer_document_group_id"
  end

  add_index "auctions", ["rating"], name: "index_auctions_on_rating"

  create_table "auctions_tags", id: false, force: true do |t|
    t.integer "tag_id"
    t.integer "auction_id"
  end

  add_index "auctions_tags", ["tag_id", "auction_id"], name: "index_auctions_tags_on_tag_id_and_auction_id", unique: true

  create_table "auctions_users", id: false, force: true do |t|
    t.integer "auction_id"
    t.integer "user_id"
  end

  create_table "blog_categories", force: true do |t|
    t.string   "name",       limit: nil
    t.string   "short_name", limit: nil
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogcomments", force: true do |t|
    t.text     "content"
    t.integer  "blogpost_id"
    t.integer  "user_id",     default: 1
    t.integer  "admin",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blogcomments", ["blogpost_id"], name: "index_blogcomments_on_blogpost_id"
  add_index "blogcomments", ["user_id"], name: "index_blogcomments_on_user_id"

  create_table "blogposts", force: true do |t|
    t.text     "content"
    t.string   "title",       limit: nil
    t.integer  "user_id"
    t.integer  "admin",                   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id",             default: 0
    t.integer  "position",                default: 0
  end

  add_index "blogposts", ["user_id"], name: "index_blogposts_on_user_id"

  create_table "bonuspoints", force: true do |t|
    t.integer  "points",     default: 20
    t.integer  "user_id",    default: 1
    t.integer  "for_what",   default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bonuspoints", ["user_id"], name: "index_bonuspoints_on_user_id"

  create_table "budgets", force: true do |t|
    t.string "title", limit: nil
  end

  create_table "car_files", force: true do |t|
    t.integer  "car_id",                            default: 0, null: false
    t.string   "description",           limit: nil
    t.string   "uploaded_file_name",    limit: nil
    t.integer  "uploaded_file_size"
    t.string   "uploaded_content_type", limit: nil
    t.string   "type",                  limit: nil
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "car_models", force: true do |t|
    t.string   "name",       limit: nil
    t.string   "initial",    limit: nil
    t.string   "full_name",  limit: nil
    t.boolean  "is_foreign",             default: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cars", force: true do |t|
    t.integer  "model_id"
    t.string   "model_title",             limit: nil
    t.string   "serial_no",               limit: nil
    t.date     "registered_at"
    t.integer  "variator",                            default: 0
    t.string   "displacement",            limit: nil
    t.string   "plate_number",            limit: nil
    t.string   "engine_number",           limit: nil
    t.string   "frame_number",            limit: nil
    t.integer  "publisher_id"
    t.integer  "evaluator_id"
    t.integer  "status",                              default: 0
    t.float    "chengbao_jine",                       default: 0.0
    t.float    "gusun_jine",                          default: 0.0
    t.float    "shiji_jiazhi",                        default: 0.0
    t.float    "canzhi_jiazhi",                       default: 0.0
    t.float    "ershou_jiazhi",                       default: 0.0
    t.float    "bidding_price",                       default: 0.0
    t.float    "final_compensate_price",              default: 0.0
    t.string   "owner_name",              limit: nil
    t.string   "owner_phone",             limit: nil
    t.string   "pickup_contact_person",   limit: nil
    t.string   "pickup_contact_phone",    limit: nil
    t.integer  "pay_method"
    t.date     "pickup_start_at"
    t.date     "pickup_expired_at"
    t.string   "pickup_address",          limit: nil
    t.string   "giveup_auction_reason",   limit: nil
    t.string   "giveup_pickupcar_reason", limit: nil
    t.string   "giveup_transfer_reason",  limit: nil
    t.string   "type",                    limit: nil
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gearbox_status",          limit: nil
    t.string   "engine_status",           limit: nil
    t.string   "car_belong_kind_name",    limit: nil
    t.string   "has_scuttle",             limit: nil
    t.string   "robbery_car",             limit: nil
    t.string   "complete_formalities",    limit: nil
    t.string   "second_accident",         limit: nil
    t.string   "second_hand",             limit: nil
    t.string   "is_loan",                 limit: nil
    t.string   "gear_name",               limit: nil
    t.string   "survey_user",             limit: nil
    t.string   "url",                     limit: nil
    t.string   "remark",                  limit: nil
  end

  create_table "comment_keywords", force: true do |t|
    t.string "name", limit: nil, null: false
  end

  create_table "comment_values", id: false, force: true do |t|
    t.integer "comment_id",             null: false
    t.integer "keyword_id",             null: false
    t.string  "extra",      limit: nil
    t.integer "rating",                 null: false
  end

  add_index "comment_values", ["comment_id"], name: "index_comment_values_on_comment_id"

  create_table "comments", force: true do |t|
    t.integer  "auction_id"
    t.integer  "project_id"
    t.integer  "author_id",   null: false
    t.integer  "receiver_id", null: false
    t.integer  "level"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "communications", force: true do |t|
    t.integer  "auction_id", null: false
    t.text     "body",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name",                    limit: nil, default: "",    null: false
    t.string   "description",             limit: nil, default: "",    null: false
    t.string   "company_type",            limit: nil, default: "",    null: false
    t.boolean  "is_approval",                         default: false, null: false
    t.string   "approval",                limit: nil
    t.date     "approved_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "agent_name",              limit: nil
    t.string   "address",                 limit: nil
    t.string   "agent_id_file_name",      limit: nil
    t.string   "agent_id_content_type",   limit: nil
    t.integer  "agent_id_file_size"
    t.datetime "agent_id_updated_at"
    t.string   "company_id_file_name",    limit: nil
    t.string   "company_id_content_type", limit: nil
    t.integer  "company_id_file_size"
    t.datetime "company_id_updated_at"
    t.datetime "verified_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",               default: 0
    t.integer  "attempts",               default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: nil
    t.string   "queue",      limit: nil
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "emailvers", force: true do |t|
    t.string   "hash_mail",  limit: nil
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expired_auctions", id: false, force: true do |t|
    t.datetime "expired_at"
    t.integer  "auction_id"
  end

  add_index "expired_auctions", ["auction_id"], name: "index_expired_auctions_on_auction_id"
  add_index "expired_auctions", ["expired_at"], name: "index_expired_auctions_on_expired_at"

  create_table "groups", force: true do |t|
    t.string  "name",   limit: nil, null: false
    t.integer "status",             null: false
  end

  create_table "invitations", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "role_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "project_id", null: false
    t.integer  "role_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "owner_id",                            null: false
    t.integer  "author_id",                           null: false
    t.integer  "receiver_id",                         null: false
    t.integer  "status",                  default: 2, null: false
    t.text     "body"
    t.string   "topic",       limit: nil,             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "auction_id",              default: 0
  end

  create_table "offers", force: true do |t|
    t.integer  "auction_id",             null: false
    t.integer  "offerer_id",             null: false
    t.integer  "status",                 null: false
    t.decimal  "price",                  null: false
    t.integer  "days",       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "topic_id",   null: false
    t.integer  "user_id",    null: false
    t.text     "content",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_files", force: true do |t|
    t.integer  "project_id",                         null: false
    t.text     "description",                        null: false
    t.string   "project_file_file_name", limit: nil
    t.integer  "project_file_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.integer  "auction_id"
    t.string   "name",        limit: nil, null: false
    t.integer  "owner_id",                null: false
    t.integer  "leader_id",               null: false
    t.integer  "duration",                null: false
    t.integer  "status",                  null: false
    t.text     "description",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", force: true do |t|
    t.integer  "watcher_id"
    t.integer  "watched_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["watched_id"], name: "index_relationships_on_watched_id"
  add_index "relationships", ["watcher_id", "watched_id"], name: "index_relationships_on_watcher_id_and_watched_id", unique: true
  add_index "relationships", ["watcher_id"], name: "index_relationships_on_watcher_id"

  create_table "reputations", force: true do |t|
    t.integer  "user_id"
    t.integer  "finished_auctions",        default: 0
    t.integer  "auctions_overall_ratings", default: 0
    t.integer  "rated_projects",           default: 0
    t.integer  "projects_overall_ratings", default: 0
    t.integer  "average_contact",          default: 0
    t.integer  "average_realization",      default: 0
    t.integer  "average_attitude",         default: 0
    t.integer  "reputation",               default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reputations", ["user_id"], name: "index_reputations_on_user_id"

  create_table "roles", force: true do |t|
    t.string   "name",       limit: nil,                 null: false
    t.boolean  "info",                   default: false, null: false
    t.boolean  "member",                 default: false, null: false
    t.boolean  "ticket",                 default: false, null: false
    t.boolean  "file",                   default: false, null: false
    t.boolean  "forum",                  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.integer "status"
    t.integer "group_id"
    t.string  "name",          limit: nil
    t.integer "auction_count",             default: 0
  end

  create_table "teams", force: true do |t|
    t.string   "name",       limit: nil, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "title",       limit: nil
    t.text     "description"
    t.integer  "duration"
    t.integer  "status",                  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.integer  "project_id",             null: false
    t.integer  "user_id",                null: false
    t.string   "title",      limit: nil, null: false
    t.text     "content",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usefuls", force: true do |t|
    t.integer  "blogpost_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usefuls", ["blogpost_id"], name: "index_usefuls_on_blogpost_id"
  add_index "usefuls", ["user_id"], name: "index_usefuls_on_user_id"

  create_table "users", force: true do |t|
    t.string   "login",               limit: nil,                  null: false
    t.string   "name",                limit: nil,                  null: false
    t.string   "lastname",            limit: nil, default: "",     null: false
    t.string   "country",             limit: nil, default: "cn",   null: false
    t.integer  "province_id",                     default: 0,      null: false
    t.integer  "city_id",                         default: 0,      null: false
    t.integer  "company_id",                      default: 0,      null: false
    t.string   "id_number",           limit: nil, default: "",     null: false
    t.string   "vercode",             limit: nil, default: "",     null: false
    t.string   "email",               limit: nil,                  null: false
    t.string   "password",            limit: nil,                  null: false
    t.integer  "status",                          default: 1,      null: false
    t.string   "role",                limit: nil, default: "user", null: false
    t.string   "salt",                limit: nil,                  null: false
    t.text     "description",                                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name",    limit: nil
    t.string   "avatar_content_type", limit: nil
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "business_phones",     limit: nil
    t.string   "cellphone",           limit: nil
    t.float    "deposit",                         default: 0.0
    t.string   "access_token",        limit: nil
    t.integer  "token_expires_in"
    t.datetime "token_expires_at"
  end

end
