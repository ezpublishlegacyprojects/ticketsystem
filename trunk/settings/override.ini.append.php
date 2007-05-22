<?php /* #?ini charset="iso-8859-1"?
[one_ticket]
Source=node/view/full.tpl
MatchFile=one_ticket.tpl
Subdir=templates
Match[class_identifier]=ticket

[edit_ticket]
Source=content/edit.tpl
MatchFile=edit_ticket.tpl
Subdir=templates
Match[class_identifier]=ticket

[edit_ticket_comment]
Source=content/edit.tpl
MatchFile=edit_comment.tpl
Subdir=templates
Match[class_identifier]=ticket_comment

[one_comment]
Source=node/view/full.tpl
MatchFile=one_comment.tpl
Subdir=templates
Match[class_identifier]=ticket_comment

[ticket_list]
Source=node/view/full.tpl
MatchFile=ticketsystem/ticketsystem.tpl
Subdir=templates
Match[class_identifier]=ticketsystem

[assigned_to]
Source=content/datatype/view/ezobjectrelation.tpl
MatchFile=ezobjectrelation_assigned_to.tpl
Subdir=templates
Match[attribute_identifier]=assigned


[notification_ticket]
Source=notification/handler/ezsubtree/view/plain.tpl
MatchFile=notification/handler/ezsubtree/view/ticket.tpl
Subdir=templates
Match[class_identifier]=ticket

[notification_ticket_comment]
Source=notification/handler/ezsubtree/view/plain.tpl
MatchFile=notification/handler/ezsubtree/view/ticket_comment.tpl
Subdir=templates
Match[class_identifier]=ticket_comment

*/ ?>