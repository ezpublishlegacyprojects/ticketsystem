{def $comments=fetch( 'content', 'tree', hash( 'parent_node_id', $node.node_id, 
              'class_filter_type',  'include',
              'class_filter_array', array( 'ticket_comment' ),
              'limitation', array(),
'sort_by', array( array( 'published', true() ) )
) ) }
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
											<h2 class="context-title">Comments</h2>
											<div class="header-subline"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>			
					{section show=$comments}
					<div class="context-toolbar">
						<div class="block">
							<div class="left">
							    <p>
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
				<div class="content-navigation-childlist">
					<table class="list" cellspacing="0">
					    <tr>
							<th>Name</th>	
							<th>Date</th>		
							<th>Author</th>
							<th class="tight">Action</th>
					    </tr>  
					    {section var=Nodes loop=$comments sequence=array( bglight, bgdark )}
					    {let child_name=$Nodes.item.name|wash 
					    	 node_name=$node.name}
				        <tr class="{$Nodes.sequence}">     
				        	<td> {*node_view_gui view=line content_node=$Nodes.item*}	
				        	     {attribute_view_gui attribute=$Nodes.object.data_map.name}										 </td>
							
							<td> {$Nodes.object.published|l10n( 'shortdatetime' )}													 </td>
							<td> {if eq($user.contentobject.name, $Nodes.creator.name)}Self{else}{$Nodes.creator.name}{/if}		 </td>		
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
										    

											{if $Nodes.can_edit}
											    <input class="button" style="width:60px;" type="submit" name="EditButton" value="Edit"/>
											{else}
											   	<input class="button-disabled" style="width:60px;" type="submit" name="EditButton" value="Edit" disabled="disabled"/>
											{/if}
									</form>							
							</td>
					  	</tr>
					  	<tr class="{$Nodes.sequence}"> 
					  	<td colspan="4" > {attribute_view_gui attribute=$Nodes.object.data_map.comment}</td>		
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