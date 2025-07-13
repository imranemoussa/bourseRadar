every 1.day, at: '9:00 am' do
  rake "scholarships:send_deadline_reminders"
end

every :sunday, at: '10:00 am' do
  rake "scholarships:send_weekly_digest"
end