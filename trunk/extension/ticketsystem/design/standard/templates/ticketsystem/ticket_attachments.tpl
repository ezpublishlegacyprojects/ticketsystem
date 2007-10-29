
{def $attachments=fetch( 'content', 'tree', hash( 'parent_node_id', $node.node_id, 
              'class_filter_type',  'include',
              'class_filter_array', array( 'ticket_attachment' ),
              'limitation', array(),
'sort_by', array( array( 'published', true() ) )
) ) }
{if $attachments}
<div class="content-view-children">
    <div class="context-block">						
					
					<div class="box-header">
						<div class="box-tc">
							<div class="box-ml">
								<div class="box-mr">
									<div class="box-tl">
										<div class="box-tr">
											{let item_type=ezpreference( 'admin_list_limit' )
											     number_of_items=min( $item_type, 3)|choose( 10, 10, 25, 50 )
											     can_remove=false()
											     can_edit=false()
											     can_create=false()
											     can_copy=false()
											     children_count=$node.children_count
									    		 children=fetch( content, list, hash( parent_node_id, $node.node_id,
									            		                              sort_by, $node.sort_array,
									                    		                      limit, $number_of_items,
									                            		              offset, $view_parameters.offset ) ) }							
											<h2 class="context-title">Attachments</h2>
											<div class="header-subline"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>			
					
																										                                          
<div class="content-navigation-childlist">
					<table class="list" cellspacing="0">
					    <tr>
							<th> Name			</th>	
							<th> File			</th>
							<th> Date		    </th>
							<th class="tight"> Action			</th>
					    </tr>  
					    {section var=Nodes loop=$attachments sequence=array( bglight, bgdark )}
					    {let child_name=$Nodes.item.name|wash 
					    	 node_name=$node.name}
				        <tr class="{$Nodes.sequence}">     
				        	<td> {attribute_view_gui attribute=$Nodes.object.data_map.name}									 </td>
							<td> {attribute_view_gui attribute=$Nodes.object.data_map.file}							 	  	 </td>		
							<td> {$Nodes.object.published|l10n( 'shortdatetime' )}													 </td>	
							<td> 
								    <form enctype="multipart/form-data" method="post" action={"content/action/"|ezurl}>
										<input type="hidden" name="TopLevelNode" value="{$node.main_node_id}" />
										<input type="hidden" name="ContentNodeID" value="{$Nodes.main_node_id}" />
										<input type="hidden" name="ContentObjectID" value="{$Nodes.contentobject_id}" />																																

											{if $Nodes.can_remove}
										        	<input class="button" style="width:60px;" type="submit" name="ActionRemove" value="Remove"/>
									        {else}
										        	<input class="button-disabled" style="width:60px;" type="submit" name="ActionRemove"value="Remove" disabled="disabled" />
									        {/if}
									</form>							
							</td>
					  	</tr>
					  	{/let}
					  	{/section}
					</table>
				</div> {* END class="content-navigation-childlist" *}
								<div class="controlbar">
					<div class="box-bc">
						<div class="box-ml">
							<div class="box-mr">
								<div class="box-tc">
									<div class="box-bl">
										<div class="box-br">
											<div class="block">
												<div class="left">	
													<div class="block">
													
													    <div class="left">
												    
													    	<div class="break"></div>
														</div> {* END class="left" *}																																	
													</div>
												<div class="right"></div>										
												<div class="break"></div>
											</div>									    
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
	</div>
</div>	
{/if}