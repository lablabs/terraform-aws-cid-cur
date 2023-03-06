module "cur_source" {
  source                 = "../../"
  usage                  = "source"
  destination_account_id = "0987654321"
}

module "cur_destination" {
  source = "../../"
  usage  = "destination"

  source_account_ids     = ["1234567890", "2345678901"]
  destination_account_id = "0987654321"
}
