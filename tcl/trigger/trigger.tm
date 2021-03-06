package provide osys::rfg::trigger 1.0.0

namespace eval osys::rfg::trigger {
    
    set RF_List {}

    proc calculate rf {
        
        lappend RF_List $rf
        
        ## Creating the RF_List
        $rf walkDepthFirst {
        
            if {[$it isa osys::rfg::RegisterFile]} {
                lappend RF_List $it
            }

            return true            
        }

        ## Walking through the RF_List in reverse and propagate the trigger Ids
        foreach regfile [lreverse $RF_List] {
            
            set trigger_list {}
            $regfile walkDepthFirst {
                if {[$it isa osys::rfg::Register]} {
                    set reg $it
                    $it onEachField {
                        $it onAttributes {hardware.osys::rfg::trigger} {
                         
                            if {[lsearch $trigger_list [$it getAttributeValue hardware.osys::rfg::trigger]] == -1} {
                                lappend trigger_list [$it getAttributeValue hardware.osys::rfg::trigger]
                            }

                        }
                    }

                }
                
                if {[$it isa osys::rfg::RegisterFile]} {
                    
                    $it onAttributes {hardware.osys::rfg::trigger} {
                        foreach trigger [$it getAttributeValue hardware.osys::rfg::trigger] {
                            if {[lsearch $trigger_list [$it getAttributeValue hardware.osys::rfg::trigger]] == -1} {
                                lappend trigger_list $trigger
                            }
                        }
                    }

                    return false
                
                } else {

                    return true
                
                }

            }
            
            $regfile attributes hardware {
                trigger $trigger_list
            }

        }
    }
}
