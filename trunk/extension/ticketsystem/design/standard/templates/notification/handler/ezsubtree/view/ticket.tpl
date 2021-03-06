{let use_url_translation=ezini('URLTranslator','Translation')|eq('enabled')
     is_update=false()}
{section loop=$object.versions}{section show=and($:item.status|eq(3),$:item.version|ne($object.current_version))}{set is_update=true()}{/section}{/section}
{section show=$is_update}
{set-block scope=root variable=subject}[TICKET][#{$object.id}] {'"%name" was updated'|i18n('design/standard/notification', '', hash( '%name', $object.name|wash ))}[{ezini("SiteSettings","SiteURL")}]{/set-block}
{set-block scope=root variable=from}{concat($object.current.creator.name|wash,' <', $sender, '>')}{/set-block}
{set-block scope=root variable=message_id}{concat('<node.',$object.main_node_id,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}	{/set-block}
{set-block scope=root variable=reply_to}{concat('<node.',$object.main_node_id,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}{/set-block}
{set-block scope=root variable=references}{section name=Parent loop=$object.main_node.path_array}{concat('<node.',$:item,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}{delimiter}{" "}{/delimiter}{/section}{/set-block}	
{"This e-mail is to inform you that an updated item has been published at %sitename."|i18n('design/standard/notification','',hash('%sitename',ezini("SiteSettings","SiteURL")))}
{"The item can be viewed by using the URL below."|i18n('design/standard/notification')}
{$object.name|wash}

{$object.data_map.description.content.output.output_text|striptags()}
{section-else}
{set-block scope=root variable=subject}[TICKET][#{$object.id}] {'"%name" was created'|i18n('design/standard/notification', '', hash( '%name', $object.name|wash ))} [{ezini("SiteSettings","SiteURL")}]{/set-block}
{set-block scope=root variable=from}{concat($object.owner.name,' <', $sender, '>')}{/set-block}
{set-block scope=root variable=message_id}{concat('<node.',$object.main_node_id,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}{/set-block}
{set-block scope=root variable=reply_to}{concat('<node.',$object.main_node.parent_node_id,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}{/set-block}
{set-block scope=root variable=references}{section name=Parent loop=$object.main_node.parent.path_array}{concat('<node.',$:item,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}{delimiter}{" "}{/delimiter}{/section}{/set-block}
{"This e-mail is to inform you that a new item has been published at %sitename."|i18n('design/standard/notification','',hash('%sitename',ezini("SiteSettings","SiteURL")))}
{"The item can be viewed by using the URL below."|i18n('design/standard/notification')}
{$object.name}

{$object.data_map.description.content.output.output_text|striptags()}
{/section}
http://{ezini("SiteSettings","SiteURL")}{cond( $use_url_translation, $object.main_node.url_alias|ezurl(no),
                                               true(), concat( "/content/view/full/", $object.main_node_id )|ezurl(no) )}
{"If you do not wish to continue receiving these notifications,
change your settings at:"|i18n('design/standard/notification')}
http://{ezini("SiteSettings","SiteURL")}{concat("notification/settings/")|ezurl(no)}
-- 
{"%sitename notification system"|i18n('design/standard/notification',,
hash('%sitename',ezini("SiteSettings","SiteURL")))}
{/let}