variable "good_ip" {
    type        = string
    default     = "192.168.0.1"
    description = "ip-адрес"

    validation {
		condition     = can(cidrhost("${var.good_ip}/32", 0))
		error_message = "Invalid ip-address."
	}
}

# variable "bad_ip" {
#     type        = string
#     default     = "1920.1680.0.1"
#     description = "ip-адрес"

#     validation {
# 		condition     = can(cidrhost("${var.bad_ip}/32", 0))
# 		error_message = "Invalid ip-address."
# 	}
# }

variable "good_ips" {
    type        = list(string)
    default     = ["192.168.0.1", "1.1.1.1", "127.0.0.1"]
    description = "список ip-адресов"

    validation {
        condition = alltrue([ for ip in var.good_ips: can(cidrhost("${ip}/32", 0)) ])
        error_message = "Given list contains one or more invalid ip-address."
    }
}

# variable "bad_ips" {
#     type        = list(string)
#     default     = ["192.168.0.1", "1.1.1.1", "1270.0.0.1"]
#     description = "список ip-адресов"

#     validation {
#         condition = alltrue([ for ip in var.bad_ips: can(cidrhost("${ip}/32", 0)) ])
#         error_message = "Given list contains one or more invalid ip-address."
#     }
# }

variable "lower_case_string" {
    type        = string
    default     = "oh hi mark"
    # default     = "Hi doggy"
    description = "A string that contains only lowercase letters."

    validation {
        condition = var.lower_case_string == lower(var.lower_case_string)
        error_message = "The string must contain only lowercase letters."
    }
}

variable "in_the_end_there_can_be_only_one" {
    description="Who is better Connor or Duncan?"
    type = object({
        Dunkan = optional(bool)
        Connor = optional(bool)
    })

    default = {
        Dunkan = false
        Connor = true
    }
    # default = {
    #     Dunkan = true
    #     Connor = false
    # }
    # default = {
    #     Dunkan = false
    #     Connor = false
    # }
    # default = {
    #     Dunkan = true
    #     Connor = true
    # }

    validation {
        error_message = "There can be only one MacLeod"
        condition = var.in_the_end_there_can_be_only_one.Dunkan != var.in_the_end_there_can_be_only_one.Connor
    }
}