// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "../js/bootstrap_js_files.js"
import $ from 'jquery';
import 'select2'
import 'select2/dist/css/select2.css'

Rails.start()
Turbolinks.start()
ActiveStorage.start()
/*$(function() {
  $('#attendee_search').select2({
    ajax: {
      url: '/attendees',
      dataType: 'json',
      delay: 250,
      data: (params) => {
        return {
          q: {
            full_name_or_preferred_first_name_or_preferred_last_name_contains: params.term
          }
        }
      },
      minimumInputLength: 2,
      placeholder: 'Legal or Preferred Name',
      allowClear: true
    }
  });
});*/
