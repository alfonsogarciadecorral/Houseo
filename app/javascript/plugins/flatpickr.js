import flatpickr from "flatpickr"
import "flatpickr/dist/themes/airbnb.css" // Note this is important!

flatpickr(".datepicker", {
  enableTime: true,
  minuteIncrement: 30,
  minTime: "10:00",
  maxTime: "20:00"
})
