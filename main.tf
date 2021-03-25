module "example1" {
  source = "./modules/Talisker"
  monitorName = "NRDB Long Alerts"
  frequency = 10
  userAPIKey = var.userAPIKey
  insertAPIKey = var.insertAPIKey
  accountId = var.terraformNRAccountId
  notificationChannelId = newrelic_alert_channel.SlackDemo.id

  tasks = [
    {
      id = "example1"
      name = "Simple value"
      accountId = "1"
      query = "FROM Public_APICall select count(*)/100000 as value since 1 day ago"
      selector = "value"
      chaining="NONE"

      alert_operator = "below"
      alert_critical_threshold = 2500
      alert_warning_threshold = 3000
      alert_threshold_occurrences = "all"   
    },
    {
      id = "example2"
      name = "Compare with"
      accountId = "1"
      query = "FROM Public_APICall select count(*) as value since 1 day ago compare with 1 week ago"
      selector = "value"
      chaining="NONE"

      alert_operator = "below"
      alert_critical_threshold = 0
      alert_warning_threshold = 10
      alert_threshold_occurrences = "all"   
    },
    {
      id = "example3"
      name = "Chaining setup"
      accountId = "1"
      query = "FROM Public_APICall select count(*) as value since 8 day ago until 7 day ago"
      selector = "value"
      chaining="NONE"

      alert_operator = "below"
      alert_critical_threshold = 0
      alert_warning_threshold = 0
      alert_threshold_occurrences = "all"   
    },
    {
      id = "example4"
      name = "Chained value"
      accountId = "1"
      query = "FROM Public_APICall select count(*) as value since 1 day ago"
      selector = "value"
      chaining="PERC_DIFF"

      alert_operator = "below"
      alert_critical_threshold = 0
      alert_warning_threshold = 10
      alert_threshold_occurrences = "all"   
    }
  ]
}
