{def $user=fetch(user, current_user)}
{def $access=fetch( 'user', 'has_access_to', hash( 'module', 'ticketsystem', 'function', 'deligate' ) )}	


{if or($access,eq($attribute.object.status, '0'))}

{default attribute_base=ContentObjectAttribute}
{let class_content=$attribute.contentclass_attribute.content}

{switch match=$class_content.selection_type}

{* Browse. *}
{case match=0}
<div class="block">

{section show=$attribute.content}
<table class="list" cellspacing="0">
<tr>
    <th>{'Name'|i18n( 'design/standard/content/datatype' )}</th>
    <th>{'Type'|i18n( 'design/standard/content/datatype' )}</th>
    <th>{'Section'|i18n( 'design/standard/content/datatype' )}</th>
</tr>
<tr>
    <td>{$attribute.content.class_identifier|class_icon( small, $attribute.content.class_name )}&nbsp;{$attribute.content.name|wash}</td>
    <td>{$attribute.content.class_name|wash}</td>
    <td>{fetch( section, object, hash( section_id, $attribute.content.section_id ) ).name|wash}</td>
</tr>
</table>
{section-else}
    <p>{'No relation'|i18n( 'design/standard/content/datatype' )}</p>
{/section}

{section show=$attribute.content}
    <input class="button" type="submit" name="CustomActionButton[{$attribute.id}_remove_object]" value="{'Remove object'|i18n( 'design/standard/content/datatype' )}" />
    <input class="button" type="submit" name="CustomActionButton[{$attribute.id}_browse_object]" value="{'Add object'|i18n( 'design/standard/content/datatype' )}" />
{section-else}
    <input class="button-disabled" type="submit" name="CustomActionButton[{$attribute.id}_remove_object]" value="{'Remove object'|i18n( 'design/standard/content/datatype' )}" disabled="disabled" />
    <input class="button" type="submit" name="CustomActionButton[{$attribute.id}_browse_object]" value="{'Add object'|i18n( 'design/standard/content/datatype' )}" />
{/section}

<input type="hidden" name="{$attribute_base}_data_object_relation_id_{$attribute.id}" value="{$attribute.data_int}" />

</div>
{/case}




{* Dropdown list. *}
{case match=1}
{let parent_node=fetch( content, node, hash( node_id, $class_content.default_selection_node ) )}

<select id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" name="{$attribute_base}_data_object_relation_id_{$attribute.id}">
{section show=$attribute.contentclass_attribute.is_required|not}
<option value="" {section show=eq( $attribute.data_int, '' )}selected="selected"{/section}>{'No relation'|i18n( 'design/standard/content/datatype' )}</option>
{/section}
{section var=Nodes loop=fetch( content, list, hash( parent_node_id, $parent_node.node_id, sort_by, $parent_node.sort_array ) )}
<option value="{$Nodes.item.contentobject_id}" {section show=eq( $attribute.data_int, $Nodes.item.contentobject_id )}selected="selected"{/section}>{$Nodes.item.name|wash}</option>
{/section}
</select>

{section show=$class_content.fuzzy_match}
<input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_fuzzy_match" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_data_object_relation_fuzzy_match_{$attribute.id}" value="" />
{/section}

{/let}
{/case}


{* Dropdown tree. Not implemented yet, thus unavailable from class edit mode. *}
{case match=2}
{/case}

{case/}

{/switch}

{/let}
{/default}
   						    					
{elseif eq($attribute.object.status, '1')}					
			

{section show=$attribute.content}
   {content_view_gui view=text_linked content_object=$attribute.content}
{section-else}
   {'No relation'|i18n( 'design/standard/content/datatype' )}
{/section}

{/if}	