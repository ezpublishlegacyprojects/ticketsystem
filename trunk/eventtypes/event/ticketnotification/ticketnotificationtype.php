<?php
include_once( 'kernel/classes/workflowtypes/event/ezwaituntildate/ezwaituntildate.php' );
include_once( "lib/ezutils/classes/ezmail.php" );
define( "ticketNotificationType_ID", "ticketnotification" );
include_once( 'lib/ezutils/classes/ezmailtransport.php' );

class ticketNotificationType extends eZWorkflowEventType
{

    function ticketNotificationType()
    {    	
        $this->eZWorkflowEventType( ticketNotificationType_ID, ezi18n( 'kernel/workflow/event', "Automatic ticket notification" ) );
        $this->setTriggerTypes( array( 'content' => array( 'publish' => array( 'after' ) ) ) );    
    }            
    
    function execute( &$process, &$event )
    {       
        eZDebug::writeNotice( 'Executing notification cronjob.' );
        $parameters = $process->attribute( 'parameter_list' );       
        $object =& eZContentObject::fetch( $parameters['object_id'] );
        $user =& eZUser::currentUser();
        if ( in_array( $object->attribute( 'class_identifier' ), array('ticket', 'ticket_comment') ) )
        {
            include_once( 'kernel/classes/notification/handler/ezsubtree/ezsubtreenotificationrule.php' );
            $nodeID = $object->attribute( 'main_node_id' );
            $nodeIDList = eZSubtreeNotificationRule::fetchNodesForUserID( $user->attribute( 'contentobject_id' ), false );            
            if ( !in_array( $nodeID, $nodeIDList ) )
            {
                eZDebug::writeNotice( 'Added subtree notification for node ID: ' . $nodeID );
                $rule = eZSubtreeNotificationRule::create( $nodeID, $user->attribute( 'contentobject_id' ) );
                $rule->store();
            }
        }                                       
        return EZ_WORKFLOW_TYPE_STATUS_ACCEPTED;
    }
}

eZWorkflowEventType::registerType( ticketNotificationType_ID, "ticketnotificationtype" );

?>