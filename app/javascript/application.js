// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
// import "./custom/flower_type_size"
import "./custom/order_detail_flow"
import "./custom/add_size"
import "bootstrap"
import "@popperjs/core"
import * as ActiveStorage from "@rails/activestorage"

ActiveStorage.start()