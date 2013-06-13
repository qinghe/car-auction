require 'test_helper'

class AccidentsControllerTest < ActionController::TestCase
  setup do
    @accident = accidents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accidents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create accident" do
    assert_difference('Accident.count') do
      post :create, accident: { chejiaohao_sousun: @accident.chejiaohao_sousun, chengbao_jine: @accident.chengbao_jine, chuli_fangshi: @accident.chuli_fangshi, chuxian_jingguo: @accident.chuxian_jingguo, chuxian_riqi: @accident.chuxian_riqi, duifang_baoxian: @accident.duifang_baoxian, gusun_jine: @accident.gusun_jine, pengzhuang_buwei: @accident.pengzhuang_buwei, renshang_qingkuang: @accident.renshang_qingkuang, sunshi_leixing: @accident.sunshi_leixing, tingche_city_id: @accident.tingche_city_id, tingche_more: @accident.tingche_more, tingche_province_id: @accident.tingche_province_id, zeren_rending: @accident.zeren_rending }
    end

    assert_redirected_to case_accident_path(assigns(:accident))
  end

  test "should show accident" do
    get :show, id: @accident
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @accident
    assert_response :success
  end

  test "should update accident" do
    put :update, id: @accident, accident: { chejiaohao_sousun: @accident.chejiaohao_sousun, chengbao_jine: @accident.chengbao_jine, chuli_fangshi: @accident.chuli_fangshi, chuxian_jingguo: @accident.chuxian_jingguo, chuxian_riqi: @accident.chuxian_riqi, duifang_baoxian: @accident.duifang_baoxian, gusun_jine: @accident.gusun_jine, pengzhuang_buwei: @accident.pengzhuang_buwei, renshang_qingkuang: @accident.renshang_qingkuang, sunshi_leixing: @accident.sunshi_leixing, tingche_city_id: @accident.tingche_city_id, tingche_more: @accident.tingche_more, tingche_province_id: @accident.tingche_province_id, zeren_rending: @accident.zeren_rending }
    assert_redirected_to case_accident_path(assigns(:accident))
  end

  test "should destroy accident" do
    assert_difference('Accident.count', -1) do
      delete :destroy, id: @accident
    end

    assert_redirected_to case_accidents_path
  end
end
