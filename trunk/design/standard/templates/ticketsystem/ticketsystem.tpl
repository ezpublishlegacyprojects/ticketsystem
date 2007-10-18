{set-block scope=root variable=cache_ttl}0{/set-block}
{if $view_parameters.state}
    {def $selected_states=$view_parameters.state|trim(',')|explode( ',' )}
{else}
     {def $selected_states = array(0,1,2,3,4,5,6)}
{/if}
{if $view_parameters.creator}
    {def $selected_creator = $view_parameters.creator|trim(',')|explode( ',' )}
    {if $selected_creator|contains(0)}
        {set $selected_creator = array(0)}
    {/if}
{else}
     {def $selected_creator = array(0)}
{/if}
{let item_type=ezpreference( 'admin_list_limit' )
     number_of_items=min( $item_type, 3)|choose( 10, 10, 25, 50 )
	 can_remove=false()
	 can_edit=false()
	 can_create=false()
	 can_copy=false()
	 attribute_filter= array()
     children_count=$node.children_count}
{if $selected_states}
{set $attribute_filter=$attribute_filter|append( array( 'ticket/state', 'in', $selected_states ) )}
{/if}
{if and($selected_creator, $selected_creator|contains(0)|not )}
{set $attribute_filter=$attribute_filter|append( array( 'owner', 'in', $selected_creator ) )}
{/if}
{*$attribute_filter|attribute(show,3)*}
{def $tickets=fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id, 
'offset', $view_parameters.offset,
'attribute_filter', $attribute_filter,
'limit', $number_of_items,
'sort_by', array( 
                array( 'attribute', false(), 'ticket/priority' ),
                array( 'published', true() )
                
             )
) ) }

{def $user=fetch(user, current_user)}
	{def $access=fetch( 'user', 'has_access_to', hash( 'module',   'ticketsystem',
													   'function', '' ) )}		
		{if $access}
<div class="content-navigation">

{* Content window. *}
<div class="context-block">

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
															   
															
<h1 class="context-title">Ticket list</h1>

{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>
											
											<div class="context-toolbar">
												<div class="block">
													<div class="left">
													    <p> Show per page:
													        {switch match=$number_of_items}
													    	    {case match=25}
											    			        <a href={'/user/preferences/set/admin_list_limit/1'|ezurl} title="{'Show 10 items per page.'|i18n( 'design/admin/node/view/full' )}">10</a>
													    	        <span class="current">25</span>
													    	        <a href={'/user/preferences/set/admin_list_limit/3'|ezurl} title="{'Show 50 items per page.'|i18n( 'design/admin/node/view/full' )}">50</a>
													    	    {/case}
													    	    {case match=50}
													    	        <a href={'/user/preferences/set/admin_list_limit/1'|ezurl} title="{'Show 10 items per page.'|i18n( 'design/admin/node/view/full' )}">10</a>
													    	        <a href={'/user/preferences/set/admin_list_limit/2'|ezurl} title="{'Show 25 items per page.'|i18n( 'design/admin/node/view/full' )}">25</a>
													    	        <span class="current">50</span>
											    			    {/case}
													    	    {case}
													    	        <span class="current">10</span>
													    	        <a href={'/user/preferences/set/admin_list_limit/2'|ezurl} title="{'Show 25 items per page.'|i18n( 'design/admin/node/view/full' )}">25</a>
													    	        <a href={'/user/preferences/set/admin_list_limit/3'|ezurl} title="{'Show 50 items per page.'|i18n( 'design/admin/node/view/full' )}">50</a>
													    	    {/case}
													        {/switch}
													    </p>
													</div> {* END class="left" *}
												<div class="break"></div>
												</div> {* END class="block" *}
											</div> {* END class="context-toolbar" *}
<div class="context-toolbar">
												<div class="block">

<form id="selector" name="selector" enctype="multipart/form-data" method="get" action="{$node.url_alias|ezurl}">

	    <input name="url" type="hidden" value={$node.url_alias|ezurl} />
{def $classes=fetch( 'class', 'list', hash( 'class_filter', array( 'ticket' ) ) )}

<div class="element">
<label for="state">Status</label><div class="break"></div>
<select name="state" multiple size="{$classes.0.data_map.state.content.options|count}">
{foreach $classes.0.data_map.state.content.options as $options}
<option value="{$options.id}" {if $selected_states|contains($options.id)} selected{/if}>{$options.name}</option>
{/foreach}
</select>
</div>
<div class="element">
{def $users = fetch( 'content', 'tree', hash( 'parent_node_id',   5,
              'main_node_only', true(),
              'class_filter_type',  'include',
              'class_filter_array', array( 'user' ) ) )}
<label for="creator">Creator</label><div class="break"></div>
<select name="creator" multiple size="8">
<option value="0" {if $selected_creator|contains(0)} selected{/if}>Any</option>
{foreach $users as $user}
<option value="{$user.contentobject_id}" {if $selected_creator|contains($user.contentobject_id)} selected{/if}>{$user.name}</option>
{/foreach}
</select>
</div>
<div class="element">
{literal}
<input name="Select" value="Select" onclick="var url = document.selector.url.value;
    if ( document.selector.state.value )
    {
        url += '/(state)/';
        for (var i=0; i < document.selector.state.options.length; i++ ) 
        {
            if ( document.selector.state.options[i].selected == true )
            {
                url += document.selector.state.options[i].value + ',';
            }
        }
    }
    if ( document.selector.creator.value )
    {
        url += '/(creator)/';
        for (var i=0; i < document.selector.creator.options.length; i++ ) 
        {
            if ( document.selector.creator.options[i].selected == true )
            {
                url += document.selector.creator.options[i].value + ',';
            }
        }
    }
    window.location.href = url;" type="button" class="button" />
{/literal}
</div>

</form>
<div id="searchbox" style="float: right; padding-right: 30px;">
      <form action={"/content/search"|ezurl}>
        {if eq( $ui_context, 'edit' )}
        <input id="searchtext" name="SearchText" type="text" value="" size="12" disabled="disabled" />
        <input id="SubTreeArray[]" name="SubTreeArray[]" type="hidden" value="{$node.node_id}" />
        <input id="searchbutton" class="button-disabled" type="submit" value="{'Search'|i18n('ticketsystem/design/standard')}" alt="Submit" disabled="disabled" />
        {else}
        <input id="searchtext" name="SearchText" type="text" value="" size="12" />
        <input id="SubTreeArray[]" name="SubTreeArray[]" type="hidden" value="{$node.node_id}" />
        <input id="searchbutton" class="button" type="submit" value="{'Search'|i18n('ticketsystem/design/standard')}" alt="Submit" />
            {if eq( $ui_context, 'browse' )}
             <input name="Mode" type="hidden" value="browse" />
            {/if}
        {/if}
      </form>
    </div>
												<div class="break"></div>
</div> {* END class="block" *}
</div>
{section show=$tickets}
					<div class="content-navigation-childlist">
						<table class="list" cellspacing="0">
						    <tr>
						    	<th> ID					</th>	
								<th> Name of ticket		</th>	
								<th> Priority			</th>
								<th> Date				</th>		
								<th> Status				</th>
								<th> Creator			</th>
								<th> Assigned person	</th>
								<th> Project			</th>
								<th> Action             </th>    
						    </tr>  
						    {section var=Nodes loop=$tickets sequence=array( bglight, bgdark )}
						    {let child_name=$Nodes.item.name|wash 
						    	 node_name=$node.name}
					        <tr class="{$Nodes.sequence}">
					        	<td>{$Nodes.main_node_id}</td>    
								<td width="30%">{node_view_gui view=line content_node=$Nodes.item} 
								     {*attribute_view_gui attribute=$Nodes.object.data_map.name*}  									 </td>
								<td width="10%"> {attribute_view_gui attribute=$Nodes.object.data_map.priority}							 	  	 </td>		
								<td width="10%"> {$Nodes.object.published|l10n( 'shortdate' )}													 </td>
								<td width="10%"> {attribute_view_gui attribute=$Nodes.object.data_map.state}									 </td>
								<td width="10%"> {if eq($user.contentobject.name, $Nodes.creator.name)}Self{else}{$Nodes.object.owner.name}{/if}		 </td>		
								<td width="10%"> {attribute_view_gui attribute=$Nodes.object.data_map.assigned} 							  	 </td>
								<td width="10%"> {attribute_view_gui attribute=$Nodes.object.data_map.project}								 	 </td>    
								<td width="10%"> 
								    <form enctype="multipart/form-data" method="post" action={"content/action/"|ezurl}>
										<input type="hidden" name="TopLevelNode" value="{$node.main_node_id}" />
										<input type="hidden" name="ContentNodeID" value="{$Nodes.main_node_id}" />
										<input type="hidden" name="ContentObjectID" value="{$Nodes.contentobject_id}" />		
										<input type="hidden" name="ContentObjectLanguageCode" value="{ezini( 'RegionalSettings','ContentObjectLocale' )}" />																														

											{if $Nodes.can_remove}
										        	<input class="button" style="width:60px;" type="submit" name="ActionRemove" value="Remove"/>
									        {else}
										        	<input class="button-disabled" style="width:60px;" type="submit" name="ActionRemove"value="Remove" disabled="disabled" />
									        {/if}

											{if $Nodes.can_edit}
											    <input class="button" style="width:60px;" type="submit" name="EditButton" value="Edit"/>
											{else}
											   	<input class="button-disabled" style="width:60px;" type="submit" name="EditButton" value="Edit" disabled="disabled"/>	
											{/if}
									
										    <input class="button" style="width:60px;" name="UpdatePriorityButton" type="submit" value="View"/>	
									</form>	
								 </td>
						  	</tr>
						  	{/let}
						  	{/section}
						</table>
					</div> {* END class="content-navigation-childlist" *}
					<div class="context-toolbar">
					{include name=navigator
					         uri='design:navigator/google.tpl'
					         page_uri=$node.url_alias
					         item_count=$children_count
					         view_parameters=$view_parameters
					         item_limit=$number_of_items}
					</div> {* class="context-toolbar" *}							
									{section-else}									
									<div class="context-toolbar">
										<div class="box-ml">
											<div class="box-mr">
												<div class="box-content">
													<div class="block">
												    <p>{'The current item does not contain any sub items.'|i18n( 'design/admin/node/view/full' )}</p>
													</div>
												</div>
											</div>
										</div>										
									</div>
									{/section}						
					<div class="controlbar">
						<div class="box-bc">
							<div class="box-ml">
								<div class="box-mr">
									<div class="box-tc">
										<div class="box-bl">
											<div class="box-br">
												<div class="block">		
								        			<div class="left">	
								        			{def $class=fetch( 'content', 'class', hash( 'class_id', 'ticket' ) )}															 
														<form method="post" action={"content/action/"|ezurl}>
														    {* <input type="hidden" name="ContentObjectLanguageCode" value="{ezini( 'RegionalSettings','ContentObjectLocale' )}" /> *}
															<input type="hidden" name="ContentLanguageCode" value="eng-GB" />
															<input class="button" type="submit" name="NewButton" value="Add new ticket" />
															<input type="hidden" name="ClassID" value={$class.id} />
															<input type="hidden" name="NodeID" value="{$node.node_id}" />
														</form>		
													{undef}												
											    	</div>  {* END class="left" *}  
													<div class="break"></div>
												</div> {* END class="block" *}
											</div> {* END class="box-br" *}
										</div> {* END class="box-bl" *}
									</div> {* END class="box-tc" *}
								</div> {* END class="box-mr" *}
							</div> {* END class="box-ml" *}
						</div> {* END class="box-bc" *}
					</div> {* END class="controlbar" *}
				</div>  {* END class="box-tc" *}
			</div> {* END class="content-navigation" *}

		{/if}
	{undef}
{undef}		

{/let}
<div class="break"></div>