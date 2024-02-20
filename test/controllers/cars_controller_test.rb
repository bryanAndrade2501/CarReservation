require 'test_helper'

class CarsControllerTest < ActionDispatch::IntegrationTest
    test 'render a list of cars' do
        get cars_path
        #put cars_path
        assert_response :success
        assert_select '.car', 2
    end

    test 'render a detailed view of a car' do
        get car_path(cars(:carone))
        assert_response :success
        assert_select 'h1', 'Picanto'
    end

    test 'render new car form' do
        get new_car_path
        assert_response :success
        assert_select 'form'
    end
end
