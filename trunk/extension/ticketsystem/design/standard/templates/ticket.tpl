{set-block scope=root variable=cache_ttl}0{/set-block}
{def $user=fetch(user, current_user)}
	<div class="content-navigation">
			<div class="context-block">
				<div class="box-header">
					<div class="box-tc">
						<div class="box-ml">
							<div class="box-mr">
								<div class="box-tl">
									<div class="box-tr">
										<h1 class="context-title"> {$node.object.name} </h1>					
										<div class="header-mainline"></div>
									</div> {* END class="box-tr"*}
								</div> {* END class="box-tl"*}
							</div> {* END class="box-mr"*}
						</div> {* END class="box-ml"*}
					</div> {* END class="box-tc"*}
				</div> {* END class="box-header"*}
				
				<div class="box-ml">
					<div class="box-mr">			
						<div class="context-information">
							<p class="modified">Last modified:{$node.object.modified|l10n( 'datetime' )}, Creator: {$node.creator.name}</p>					
							<div class="break"></div>
						</div> {* END class="context-information"*}
						<div class="mainobject-window">
    					        {* in window *}
								<div class="holdinplace">    						
				<table class="list"  style="width:30%; float:right" >
														    
								 <tr>
								    <th> {$node.object.data_map.category.contentclass_attribute.name}:</th>
								     <td> {attribute_view_gui attribute=$node.object.data_map.category} </td>
								</tr>								    
								 <tr>
								    <th>{$node.object.data_map.type.contentclass_attribute.name}: </th>
								     <td>  {attribute_view_gui attribute=$node.object.data_map.type}  </td>
								</tr>								    
								<tr>
								    <th>{$node.object.data_map.project.contentclass_attribute.name}: </th>
								     <td> {attribute_view_gui attribute=$node.object.data_map.project} </td>
								</tr>								    
								<tr>
								    <th>{$node.object.data_map.assigned.contentclass_attribute.name}: </th>
								     <td>   {attribute_view_gui attribute=$node.object.data_map.assigned} </td>
								</tr>								  
								<tr>
								    <th>{$node.object.data_map.priority.contentclass_attribute.name}: </th>
								     <td>{attribute_view_gui attribute=$node.object.data_map.priority}     </td>
								</tr>								    
								<tr>
								    <th>{$node.object.data_map.state.contentclass_attribute.name}: </th>
								     <td>{attribute_view_gui attribute=$node.object.data_map.state}    </td>
							 	</tr>								  
							    <tr>
								    <th>{$node.object.data_map.deadline.contentclass_attribute.name}:</th>
								     <td>
								     {if $node.object.data_map.deadline.has_content|not}
								     <p>none</p>
								     {else}
								     {attribute_view_gui attribute=$node.object.data_map.deadline}
								     {/if}
								     </td>
								    </tr>
								    
							</table> 	
								    
								     
							            <h3>{$node.object.data_map.name.contentclass_attribute.name}:</h3>        
											{attribute_view_gui attribute=$node.object.data_map.name} 
							       
							        						    			
    					         				            <h3>{$node.object.data_map.description.contentclass_attribute.name}:</h3>        
											{attribute_view_gui attribute=$node.object.data_map.description}
							    
				
    					         {* in window *} 
							<div class="break"></div>
						</div>
					</div>
				</div>
                <div class="controlbar">
					<div class="box-bc">
						<div class="box-ml">
							<div class="box-mr">
								<div class="box-tc">
									<div class="box-bl">
										<div class="box-br">
											<div class="block">		
										        <div class="left">
										        <div class="element">
										        {def $class=fetch( 'content', 'class', hash( 'class_id', 'ticket_comment' ) )}															 
										        <form enctype="multipart/form-data" method="post" action={"content/action/"|ezurl}>	
										            <input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings','ContentObjectLocale' )}" />												
													<input type="hidden" name="ContentObjectID" value="{$node.contentobject_id}" />																																																															
													<input type="hidden" name="ClassID" value="{$class.id}" />
													<input type="hidden" name="NodeID" value="{$node.node_id}" />				
													<input class="button" type="submit" name="NewButton" value="Add new comment" />
												</form>	
												{undef}
												</div>
												<div class="element">
												{def $class=fetch( 'content', 'class', hash( 'class_id', 'ticket_attachment' ) )}															 
										        <form enctype="multipart/form-data" method="post" action={"content/action/"|ezurl}>	
										            <input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings','ContentObjectLocale' )}" />												
													<input type="hidden" name="ContentObjectID" value="{$node.contentobject_id}" />																																																															
													<input type="hidden" name="ClassID" value="{$class.id}" />
													<input type="hidden" name="NodeID" value="{$node.node_id}" />				
													<input class="button" type="submit" name="NewButton" value="Add new attachment" />
												</form>	
												{undef}
												</div>
												
													<div class="element">
												{def $class=fetch( 'content', 'class', hash( 'class_id', 'ticket_edit' ) )}															 
										        <form enctype="multipart/form-data" method="post" action={"content/action/"|ezurl}>	
										            <input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings','ContentObjectLocale' )}" />												
													<input type="hidden" name="ContentObjectID" value="{$node.contentobject_id}" />																																																															
													<input type="hidden" name="ClassID" value="{$class.id}" />
													<input type="hidden" name="NodeID" value="{$node.node_id}" />				
													<input class="button" type="submit" name="EditButton" value="Edit" />
												</form>	
												{undef}
												</div>
														<div class="element">	
														<form action={$node.parent.url_alias|ezurl}>			
													<input class="button" type="submit" value="Back to Ticketsystem" />
													</form>
												</div>	
																						
											    </div>  							 
												<div class="break"></div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>	
			</div> {* END class="context-block" *}
			
{include uri='design:ticketsystem/ticket_attachments.tpl'}

{include uri='design:ticketsystem/ticket_comments.tpl'}

		</div>
	</div>

<div class="break"></div>
