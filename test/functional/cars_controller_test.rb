require 'test_helper'

class CarsControllerTest < ActionController::TestCase
  setup do
    @car = cars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create car" do
    assert_difference('Car.count') do
      post :create, car: { engine_number: @car.engine_number, frame_number: @car.frame_number, variator: @car.variator, model_id: @car.model_id, model_name: @car.model_name, plate_number: @car.plate_number, registered_at: @car.registered_at, serial_no: @car.serial_no }
    end

    assert_redirected_to car_path(assigns(:car))
  end

  test "should show car" do
    get :show, id: @car
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @car
    assert_response :success
  end

  test "should update car" do
    put :update, id: @car, car: { engine_number: @car.engine_number, frame_number: @car.frame_number, variator: @car.variator, model_id: @car.model_id, model_name: @car.model_name, plate_number: @car.plate_number, registered_at: @car.registered_at, serial_no: @car.serial_no }
    assert_redirected_to car_path(assigns(:car))
  end

  test "should destroy car" do
    assert_difference('Car.count', -1) do
      delete :destroy, id: @car
    end

    assert_redirected_to cars_path
  end
end
