@echo off
logman -ets start -mode 2 -max 256 internettrace -p "{4E749B6A-667D-4c72-80EF-373EE3246B08}" 0x7FFFFFFF 5 -o nettrace.etl 
logman -ets update internettrace -p "{43D1A55C-76D6-4f7e-995C-64C711E5CAFE}" 0x7FFFFFFF 5
logman -ets update internettrace -p "{1A211EE8-52DB-4AF0-BB66-FB8C9F20B0E2}" 0x7FFFFFFF 5
logman -ets update internettrace -p "{B3A7698A-0C45-44DA-B73D-E181C9B5C8E6}" 0x7FFFFFFF 5
logman -ets update internettrace -p "{08F93B14-1608-4a72-9CFA-457EECEDBBA7}" 0x7FFFFFFF 5
logman -ets update internettrace -p "{50b3e73c-9370-461d-bb9f-26f32d68887d}" 0xFFFFFFFFFFFFFFFF 5
logman -ets update internettrace -p "{988ce33b-dde5-44eb-9816-ee156b443ff1}" 0x7FFFFFFF 5
logman -ets update internettrace -p "{41D92334-B49C-4938-85F1-3C22595DB157}" 0x7FFFFFFF 5
logman -ets update internettrace -p "{609151DD-04F5-4DA7-974C-FC6947EAA323}" 0x7FFFFFFF 5
logman -ets update internettrace -p "{1C95126E-7EEA-49A9-A3FE-A378B03DDB4D}" 0xFFFFFFFFFFFFFFFF 5
logman -ets update internettrace -p "{55404E71-4DB9-4DEB-A5F5-8F86E46DDE56}" 0x7FFFFFFF 5
logman -ets update internettrace -p "{0C478C5B-0351-41B1-8C58-4A6737DA32E3}" 0x7FFFFFFF 5
