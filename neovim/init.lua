require('impatient').enable_profile()

-- Do all init in my/config.lua so impatient can cache it
require('my.config')
-- idem for packer
require('packer_compiled')
