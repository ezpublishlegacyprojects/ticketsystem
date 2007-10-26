{def $user=fetch(user, current_user)}
{def $access=fetch( 'user', 'has_access_to', hash( 'module', 'ticketsystem', 'function', 'deligate' ) )}	

{*$attribute|attribute(show,2)*}
{default attribute_base=ContentObjectAttribute}
{let selected_id_array=$attribute.content}
{if $access}
        <div class="original">
{* Always set the .._selected_array_.. variable, this circumvents the problem when nothing is selected. *} 
<input type="hidden" name="{$attribute_base}_ezselect_selected_array_{$attribute.id}" value="" />

<select id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" name="{$attribute_base}_ezselect_selected_array_{$attribute.id}[]" {section show=$attribute.class_content.is_multiselect}multiple{/section}>
{section var=Options loop=$attribute.class_content.options}
<option value="{$Options.item.id}" {section show=$selected_id_array|contains( $Options.item.id )}selected="selected"{/section}>{$Options.item.name|wash( xhtml )}</option>
{/section}
</select>
		</div>
{else}
			{if or( eq($attribute.data_text, 7), 
					eq($attribute.data_text, 8) )}																
			
						<input type="hidden" name="{$attribute_base}_ezselect_selected_array_{$attribute.id}" value="">		
						<select id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" name="{$attribute_base}_ezselect_selected_array_{$attribute.id}[]" {section show=$attribute.class_content.is_multiselect}multiple{/section}>				
							{foreach $attribute.class_content.options as $index => $object} 									
								{if or( eq($attribute.object.name, 'Reopened'), eq($attribute.object.name, 'Invalid') )}
									<option value="{$index}" {section show=$selected_id_array|contains( $index )}selected="selected"{/section}> {$attribute.object.name}</option>
								{elseif or( eq($attribute.object.name, 'Reopened'), eq($attribute.object.name, 'Closed') )}
									<option value="{$index}" {section show=$selected_id_array|contains( $index )}selected="selected"{/section}> {$attribute.object.name}</option>								
								{/if}									
							{/foreach}	    																											
						</select>																																																																																    				    				    				    	  	
			{else} 			
				{if or( $access, eq($attribute.object.status, '0'))}
					{attribute_edit_gui attribute_base=$attribute_base attribute=$attribute}   						    						
				{elseif eq($attribute.object.status, '1')}
					{attribute_view_gui attribute_base=$attribute_base attribute=$attribute}
			    {/if}
			{/if}
{/if}
{/let}
{/default}
