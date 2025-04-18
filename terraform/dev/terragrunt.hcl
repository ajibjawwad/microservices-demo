#find terragrunt.hcl in root_folder
include {
    path = find_in_parent_folders()
}
