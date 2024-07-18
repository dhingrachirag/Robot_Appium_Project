
import time
import sys



class DataManager:
    def __init__(self):
        self.Initiate()


    def Initiate(self):
        print "#################"
        print('INTENT VALIDATOR')
        print "#################"
        print "\n"
        try:
            input = self.read_and_validate_integer_input(0, 11)

            if input == 0:
                verify = self.verify_incall_state(self)

            if input == 1:
                verify = self.verify_incomingcall_state(self)

                if input == 2:
                     verify = self.verify_mute_state(self)

                if input == 3:
                    verify = self.verify_missedcall_state(self)

                if input == 4:
                    verify = self.verify_missedvoicemail_state(self)

                if input == 5:
                    verify = self.verify_voicemailplaying_state(self)

                if input == 6:
                    verify = self.verify_users_state(self)

            	if input == 7:
                    verify = self.verify_darktheam_state(self)

                if input == 8:
                    verify = self.verify_phone_state_update(self)

                if input == 9:
                    verify = self.verify_dreaming_started(self)

                if input == 10:
                    verify = self.verify_dreaming_stopped(self)

				if input == 11:
					verify = self.verify_dail_emergency_number(self)

            		return verify

        except KeyboardInterrupt as e:
            print "Exception caught : " + str(e)
            return None
