terraform {
  source = "${path_relative_from_include()}/../terraform/modules/storage-account//."
}

inputs = {
  resource_group_id = "/subscriptions/4345f739-7f4a-45ab-b437-126f4437e962/resourceGroups/sample-rg"
}

include {
  path = find_in_parent_folders()
}