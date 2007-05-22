{def $user=fetch(user, current_user)}
{def $access=fetch( 'user', 'has_access_to', hash( 'module', 'ticketsystem', 'function', 'deligate' ) )}	
<div class="block">
{section name=ContentObjectAttribute loop=$content_attributes sequence=array(bglight,bgdark)}
	<label{section show=$:item.has_validation_error} class="validation-error"{/section}></label>		
    <div class="labelbreak"></div>        
    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$:item.id}" />         									
    <label{section show=$:item.has_validation_error} class="message-error"{/section}>{$:item.contentclass_attribute_name|wash}{section show=$:item.is_required} <span class="required">({'required'|i18n( 'design/admin/content/edit_attribute' )})</span>{/section}{section show=$:item.is_information_collector} <span class="collector">({'information collector'|i18n( 'design/admin/content/edit_attribute' )})</span>{/section}:</label>		        
	{if $access}
        <div class="original">
			{attribute_edit_gui attribute_base=$attribute_base attribute=$:item}
		</div>
	{else}
		{if eq($:item.contentclass_attribute.identifier, 'state')}
			{if or( eq($:item.object.data_map.state.data_text, 7), 
					eq($:item.object.data_map.state.data_text, 8) )}																
				{default attribute_base=ContentObjectAttribute}						
					{def $selected_id_array=$:item.content}		
						<input type="hidden" name="{$attribute_base}_ezselect_selected_array_{$:item.id}" value="">		
						<select id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$:item.contentclassattribute_id}_{$:item.contentclass_attribute_identifier}" class="ezcc-{$:item.object.content_class.identifier} ezcca-{$:item.object.content_class.identifier}_{$:item.contentclass_attribute_identifier}" name="{$attribute_base}_ezselect_selected_array_{$:item.id}[]" {section show=$:item.class_content.is_multiselect}multiple{/section}>				
							{foreach $:item.class_content.options as $index => $object} 									
								{if or( eq($object.name, 'Reopened'), eq($object.name, 'Invalid') )}
									<option value="{$index}" {section show=$selected_id_array|contains( $index )}selected="selected"{/section}> {$object.name}</option>
								{elseif or( eq($object.name, 'Reopened'), eq($object.name, 'Closed') )}
									<option value="{$index}" {section show=$selected_id_array|contains( $index )}selected="selected"{/section}> {$object.name}</option>								
								{/if}									
							{/foreach}	    																											
						</select>																																																																										
				{/default}								    				    				    				    	  	
			{else} 			
				{if or( $access, eq($:item.object.status, '0'))}
					{attribute_edit_gui attribute_base=$attribute_base attribute=$:item}   						    						
				{elseif eq($:item.object.status, '1')}
					{attribute_view_gui attribute_base=$attribute_base attribute=$:item}
			    {/if}
			{/if}
		{elseif eq($:item.contentclass_attribute.identifier, 'assigned')}					
			
			    {if or($access,eq($:item.object.status, '0'))}
					{attribute_edit_gui attribute_base=$attribute_base attribute=$:item}   						    					
				{elseif eq($:item.object.status, '1')}					
				    {attribute_view_gui attribute_base=$attribute_base attribute=$:item}
				{/if}			
			{undef}
		{else}
			{attribute_edit_gui attribute_base=$attribute_base attribute=$:item}   						    										
	    {/if}		    
	{/if}
{/section}
</div>
{undef}