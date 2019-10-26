<cfoutput>

<div class="mura-panel-group" id="panels-style-content">

		<!--- panel 1: layout --->
    <div class="panel mura-panel">
        <div class="mura-panel-heading panel-content">
            <h4 class="mura-panel-title">
                <a class="collapse collapsed" data-toggle="collapse" data-parent="##panels-style-content" href="##panel-style-content-1">Layout
                </a>
            </h4>
        </div> <!--- /.mura-panel-heading --->
        <div id="panel-style-content-1" class="panel-collapse collapse">
            <div class="mura-panel-body">
            <!--- panel contents --->
				<!--- text alignment --->
				<cfif attributes.params.object eq 'container'>
					<!--- text alignment --->
					<div class="mura-control-group">
						<label>Display</label>
						<select name="display" class="contentStyle">
							<option value="flex"<cfif attributes.params.stylesupport.contentstyles.display eq 'flex'> selected</cfif>>flex</option>
							<option value="block"<cfif attributes.params.stylesupport.contentstyles.display eq 'block'> selected</cfif>>block</option>
						</select>
					</div>
				<cfelse>
					<div class="mura-control-group">
						<label>Text Alignment</label>
						<select name="textAlign" class="contentStyle">
							<option value="">--</option>
							<option value="left"<cfif attributes.params.stylesupport.contentstyles.textalign eq 'left'> selected</cfif>>#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.left')#</option>
							<option value="right"<cfif attributes.params.stylesupport.contentstyles.textalign eq 'right'> selected</cfif>>#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.right')#</option>
							<option value="center"<cfif attributes.params.stylesupport.contentstyles.textalign eq 'center'> selected</cfif>>#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.center')#</option>
							<option value="justify"<cfif attributes.params.stylesupport.contentstyles.textalign eq 'justify'> selected</cfif>>#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.justify')#</option>
						</select>
					</div>
				</cfif>

				<!--- If the module is a container this toggle visible if is block---> 
				<div class="mura-control-group block-control-content" <cfif attributes.params.object eq 'container'>style="display:none;"</cfif>>
						<!--- todo: rbkey for margin and placeholders --->
						<label>Width</label>

						<div class="row mura-ui-row">

								<div class="mura-input-group">
									<label class="mura-serial">
										<input type="text" name="contentwidth" id="contentwidthnum" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.contentstyles.width))>#val(esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.width))#</cfif>">
									</label>
									<select id="contentwidthuom" name="contentwidthuom" class="styleSupport">
										<cfloop list="#request.objectlayoutuomext#" index="u">
											<option value="#u#"<cfif attributes.params.stylesupport.contentwidthuom eq u> selected</cfif>>#u#</option>
										</cfloop>
									</select>
								</div>
								<input type="hidden" name="width" id="contentwidthuomval" class="contentStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.width)#">
						</div>
					</div>

				<div class="mura-control-group">
					<!--- todo: rbkey for margin and placeholders --->
					<label>Minimum Height</label>

					<div class="row mura-ui-row">

							<div class="mura-input-group">
								<label class="mura-serial">
									<input type="text" name="contentminheight" id="contentminheightnum" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.contentstyles.minheight))>#val(esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.minheight))#</cfif>">
								</label>
								<select id="contentminheightuom" name="contentminheightuom" class="styleSupport">
									<cfloop list="#request.objectlayoutuomext#" index="u">
										<option value="#u#"<cfif attributes.params.stylesupport.contentminheightuom eq u or not len(attributes.params.styleSupport.contentminheightuom) and u eq request.preferreduom> selected</cfif>>#u#</option>
									</cfloop>
								</select>
							</div>
							<input type="hidden" name="minHeight" id="contentminheightuomval" class="contentStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.minheight)#">
					</div>
				</div>

				<cfif len(attributes.params.stylesupport.contentstyles.margintop
					& attributes.params.stylesupport.contentstyles.marginbottom
					& attributes.params.stylesupport.contentstyles.marginleft
					& attributes.params.stylesupport.contentstyles.marginright
					& attributes.params.stylesupport.contentstyles.marginall
					& attributes.params.stylesupport.contentstyles.paddingtop
					& attributes.params.stylesupport.contentstyles.paddingbottom
					& attributes.params.stylesupport.contentstyles.paddingleft
					& attributes.params.stylesupport.contentstyles.paddingright
					& attributes.params.stylesupport.contentstyles.paddingall
				)>
					<cfset attributes.params.contentspacing='custom'>
				</cfif>

				<cfif arrayLen(request.spacingoptions)>
					<div class="mura-control-group mura-ui-grid">
						<label>Spacing</label>
						<select name="contentspacingselect">
							<option value="">--</option>
							<cfloop array="#request.spacingoptions#" index="option">
								<option value="#option.value#"<cfif attributes.params.contentspacing eq option.value> selected</cfif>>#esapiEncode('html',option.name)#</option>
							</cfloop>
							<option value="custom"<cfif attributes.params.contentspacing eq 'custom'> selected</cfif>>Custom</option>
						</select>
						<input name="contentspacing" class="objectParam" type="hidden" value="#esapiEncode('html_attr',attributes.params.contentspacing)#">
					</div>
				</cfif>

				<div id="customcontentspacing"<cfif arrayLen(request.spacingoptions) and attributes.params.contentspacing neq 'custom'> style="display:none;"</cfif>>
					
					<!--- margin --->
					<div class="mura-control-group mura-ui-grid">
						<!--- todo: rbkey for margin and placeholders --->
						<label>Margin</label>

						<div class="row mura-ui-row">
							<div class="col-xs-12 center">
								<div class="mura-input-group">
									<label class="mura-serial">
										<input type="text" name="margin" id="contentmarginall" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.contentstyles.marginall))>#val(esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.marginall))#</cfif>">
									</label>
								
									<select id="contentmarginuom" name="contentmarginuom" class="styleSupport">
										<cfloop list="#request.objectlayoutuom#" index="u">
											<option value="#u#"<cfif attributes.params.styleSupport.contentmarginuom eq u or not len(attributes.params.styleSupport.contentmarginuom) and u eq request.preferreduom> selected</cfif>>#u#</option>
										</cfloop>
									</select>
								</div>
								<a class="btn ui-advanced mura-ui-link" data-reveal="contentmarginadvanced" href="##"><i class="mi-arrows"></i></a>
							</div>
						</div>

						<div id="contentmarginadvanced" class="mura-ui-inset" style="display: none;">
							<div class="row mura-ui-row">
								<div class="col-xs-3"></div>
								<div class="col-xs-6">
									<label class="mura-serial">
										<input type="text" name="contentMarginTop" id="contentmargintop" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.contentstyles.margintop))>#val(esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.margintop))#</cfif>">
									</label>
									<input type="hidden" name="marginTop" id="contentmargintopval" class="contentStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.margintop)#">
								</div>
								<div class="col-xs-3"></div>
							</div>

							<div class="row mura-ui-row">
								<div class="col-xs-5">
									<div class="mura-input-group">
										<label class="mura-serial">
											<input type="text" name="contentMarginLeft" id="contentmarginleft" class="numeric serial pull-right" value="<cfif attributes.params.stylesupport.contentstyles.marginleft eq 'auto'>auto<cfelseif len(trim(attributes.params.stylesupport.contentstyles.marginleft))>#val(esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.marginleft))#</cfif>">
											<a class="btn pull-right input-auto" data-auto-input="contentmarginleft" href="##"><span>a</span></a>
										</label>
									</div>
									<input type="hidden" name="marginLeft" id="contentmarginleftval" class="contentStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.marginleft)#">
								</div>
								<div class="col-xs-2">
									<i class="mi-arrows ui-inset-icon"></i>
								</div>
								<div class="col-xs-5">
									<div class="mura-input-group">
										<label class="mura-serial">
											<input type="text" name="contentMarginRight" id="contentmarginright" class="numeric serial pull-left" value="<cfif attributes.params.stylesupport.contentstyles.marginright eq 'auto'>auto<cfelseif len(trim(attributes.params.stylesupport.contentstyles.marginright))>#val(esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.marginright))#</cfif>">
											<a class="btn pull-left input-auto" data-auto-input="contentmarginright" href="##"><span>a</span></a>
										</label>
									</div>
									<input type="hidden" name="marginRight" id="contentmarginrightval" class="contentStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.marginright)#">
								</div>
							</div>

							<div class="row mura-ui-row">
								<div class="col-xs-3"></div>
								<div class="col-xs-6">
									<label class="mura-serial">
										<input type="text" name="contentMarginBottom" id="contentmarginbottom" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.contentstyles.marginbottom))>#val(esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.marginbottom))#</cfif>">
									</label>
									<input type="hidden" name="marginBottom" id="contentmarginbottomval" class="contentStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.marginbottom)#">
								</div>
								<div class="col-xs-3"></div>
							</div>
						</div>

					</div>

					<!--- padding --->
					<div class="mura-control-group mura-ui-grid">
						<!--- todo: rbkey for padding and placeholders --->
						<label>Padding</label>

						<div class="row mura-ui-row">
							<div class="col-xs-12 center">
								<div class="mura-input-group">
									<label class="mura-serial">
										<input type="text" name="padding" id="contentpaddingall" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.contentstyles.paddingall))>#val(esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.paddingall))#</cfif>">
									</label>
									<select id="contentpaddinguom" name="contentpaddinguom" class="styleSupport">
										<cfloop list="#request.objectlayoutuom#" index="u">
											<option value="#u#"<cfif attributes.params.styleSupport.contentpaddinguom eq u or not len(attributes.params.styleSupport.contentpaddinguom) and u eq request.preferreduom> selected</cfif>>#u#</option>
										</cfloop>
									</select>
								</div>
								<a class="btn ui-advanced mura-ui-link" data-reveal="contentpaddingadvanced" href="##"><i class="mi-arrows"></i></a>
							</div>
						</div>

						<div id="contentpaddingadvanced" class="mura-ui-inset" style="display: none;">
							<div class="row mura-ui-row">
								<div class="col-xs-3"></div>
								<div class="col-xs-6">
									<label class="mura-serial">
										<input type="text" name="contentPaddingTop" id="contentpaddingtop" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.contentstyles.paddingtop))>#val(esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.paddingtop))#</cfif>">
									</label>
									<input type="hidden" name="paddingTop" id="contentpaddingtopval" class="contentStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.paddingtop)#">
								</div>
								<div class="col-xs-3"></div>
							</div>

							<div class="row mura-ui-row">
								<div class="col-xs-1"></div>
								<div class="col-xs-4">
									<label class="mura-serial">
										<input type="text" name="contentPaddingLeft" id="contentpaddingleft" class="numeric serial pull-right" value="<cfif len(trim(attributes.params.stylesupport.contentstyles.paddingleft))>#val(esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.paddingleft))#</cfif>">
									</label>
									<input type="hidden" name="paddingLeft" id="contentpaddingleftval" class="contentStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.paddingleft)#">
								</div>
								<div class="col-xs-2">
									<i class="mi-arrows ui-inset-icon"></i>
								</div>
								<div class="col-xs-4">
									<label class="mura-serial">
										<input type="text" name="contentPaddingRight" id="contentpaddingright" class="numeric serial pull-left" value="<cfif len(trim(attributes.params.stylesupport.contentstyles.paddingright))>#val(esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.paddingright))#</cfif>">
									</label>
									<input type="hidden" name="paddingRight" id="contentpaddingrightval" class="contentStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.paddingright)#">
								</div>
								<div class="col-xs-1"></div>
							</div>
							<div class="row mura-ui-row">
								<div class="col-xs-3"></div>
								<div class="col-xs-6">
									<label class="mura-serial">
										<input type="text" name="contentPaddingBottom" id="contentpaddingbottom" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.contentstyles.paddingbottom))>#val(esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.paddingbottom))#</cfif>">
									</label>
									<input type="hidden" name="paddingBottom" id="contentpaddingbottomval" class="contentStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.paddingbottom)#">
								</div>
								<div class="col-xs-3"></div>
							</div>
						</div>

					</div>
				</div>
				<cfif arrayLen(request.spacingoptions)>
					<script>
						$('select[name="contentspacingselect"]').on(
							'change',
							function(){
								var item=$(this);
								if($(this).val()=='custom'){
									$('##customcontentspacing').show();
								} else {
									$('##customcontentspacing').hide();
									$('##contentpaddingall').val('').trigger('keyup');
									$('##contentmarginall').val('').trigger('keyup');
								}
								$('input[name="contentspacing"]').val(item.val()).trigger('change');
							}	
						)
					</script>
				</cfif>

				<cfif attributes.params.object eq 'container'>
					<div class="mura-control-group flex-control-content" style="display:none; margin-top:8px;">
						<label>Flex Alignment</label>
						<select name="justifyContent" class="contentStyle">
							<option value="">--</option>
							<option value="flex-start"<cfif attributes.params.stylesupport.contentstyles.justifyContent eq 'flex-start'> selected</cfif>>flex-start</option>
							<option value="flex-end"<cfif attributes.params.stylesupport.contentstyles.justifyContent eq 'flex-end'> selected</cfif>>flex-end</option>
							<option value="center"<cfif attributes.params.stylesupport.contentstyles.justifyContent eq 'center'> selected</cfif>>center</option>
							<option value="space-between"<cfif attributes.params.stylesupport.contentstyles.justifyContent eq 'space-between'> selected</cfif>>space-between</option>
							<option value="space-around"<cfif attributes.params.stylesupport.contentstyles.justifyContent eq 'space-around'> selected</cfif>>space-around</option>
							<option value="space-evenly"<cfif attributes.params.stylesupport.contentstyles.justifyContent eq 'justify'> selected</cfif>>space-evenly</option>
						</select>
					</div>
					<!--- text alignment --->
					<div class="mura-control-group flex-control-content" style="display:none;">
						<label>Flex Align Items</label>
						<select name="alignItems" class="contentStyle">
							<option value="">--</option>
							<option value="flex-start"<cfif attributes.params.stylesupport.contentstyles.alignItems eq 'flex-start'> selected</cfif>>flex-start</option>
							<option value="flex-end"<cfif attributes.params.stylesupport.contentstyles.alignItems eq 'flex-end'> selected</cfif>>flex-end</option>
							<option value="center"<cfif attributes.params.stylesupport.contentstyles.alignItems eq 'center'> selected</cfif>>center</option>
							<option value="baseline"<cfif attributes.params.stylesupport.contentstyles.alignItems eq 'baseline'> selected</cfif>>baseline</option>
						</select>
					</div>

					<!--- text alignment --->
					<div class="mura-control-group flex-control-content" style="display:none; margin-top:8px;s">
						<label>Flex Align Content</label>
						<select name="alignContent" class="contentStyle">
							<option value="">--</option>
							<option value="flex-start"<cfif attributes.params.stylesupport.contentstyles.alignContent eq 'flex-start'> selected</cfif>>flex-start</option>
							<option value="flex-end"<cfif attributes.params.stylesupport.contentstyles.alignContent eq 'flex-end'> selected</cfif>>flex-end</option>
							<option value="center"<cfif attributes.params.stylesupport.contentstyles.alignContent eq 'center'> selected</cfif>>center</option>
							<option value="stretch"<cfif attributes.params.stylesupport.contentstyles.alignContent eq 'stretch'> selected</cfif>>stretch</option>
							<option value="space-between"<cfif attributes.params.stylesupport.contentstyles.alignContent eq 'space-between'> selected</cfif>>space-between</option>
							<option value="space-around"<cfif attributes.params.stylesupport.contentstyles.alignContent eq 'space-around'> selected</cfif>>space-around</option>
						</select>
					</div>

					<script>
						$(function(){
							$('select[name="display"]').on(
								'change',
								function(){
									if($(this).val() != 'block'){
										$('.flex-control-content').show();
										$('.block-control-content').each(function()
										{
											var item=$(this);
											item.hide();
											item.find('input').val('');
										})
									} else {
										$('.block-control-content').show();
										$('.flex-control-content').each(function()
										{
											var item=$(this);
											item.hide();
											item.find('select').val('').niceSelect('update');
										});
									}
								}).trigger('change');	
						});
					</script>
				</cfif>	
            <!--- /end panel contents --->
            </div> <!--- /.mura-panel-body --->
        </div> <!--- /.panel-collapse --->
    </div> <!--- /.mura-panel --->

		<!--- panel 2: theme --->
    <div class="panel mura-panel">
        <div class="mura-panel-heading panel-content">
            <h4 class="mura-panel-title">
                <a class="collapse collapsed" data-toggle="collapse" data-parent="##panels-style-content" href="##panel-style-content-2">Text Color
                </a>
            </h4>
        </div> <!--- /.mura-panel-heading --->
        <div id="panel-style-content-2" class="panel-collapse collapse">
            <div class="mura-panel-body">
            <!--- panel contents --->
							<!--- text color --->
							<div class="mura-control-group">
								<!--- todo: rbkey for these labels, options and placeholders--->
								<label><!--- Text Color ---></label>

								<div class="input-group mura-colorpicker">
									<span class="input-group-addon"><i class="mura-colorpicker-swatch"></i></span>
									<input type="text" id="contenttextcolor" name="color" class="contentStyle" placeholder="Select Color" autocomplete="off" value="#esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.color)#">
								</div>

							</div>
            <!--- /end panel contents --->
            </div> <!--- /.mura-panel-body --->
        </div> <!--- /.panel-collapse --->
    </div> <!--- /.mura-panel --->


		<!--- panel 3: background --->
    <div class="panel mura-panel">
        <div class="mura-panel-heading panel-content">
            <h4 class="mura-panel-title">
                <a class="collapse collapsed" data-toggle="collapse" data-parent="##panels-style-content" href="##panel-style-content-3">Background
                </a>
            </h4>
        </div> <!--- /.mura-panel-heading --->
        <div id="panel-style-content-3" class="panel-collapse collapse">
            <div class="mura-panel-body">
            <!--- panel contents --->
							<!--- background --->
							<div class="mura-control-group">
								<!--- todo: rbkey for these labels, options and placeholders--->
								<label>Background Color</label>
								<div class="input-group mura-colorpicker" id="contentbackgroundcustom">
									<span class="input-group-addon"><i class="mura-colorpicker-swatch"></i></span>
									<input type="text" id="contentbackgroundcolor" name="backgroundColor" class="contentStyle" placeholder="Select Color" autocomplete="off" value="#esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.backgroundcolor)#">
								</div>
							</div>

							<div class="mura-control-group">
								<label>Background Image</label>
								<input type="hidden" id="contentbackgroundimage" name="backgroundImage" class="contentStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.backgroundimage)#">
								<input type="text" id="contentbackgroundimageurl" name="contentbackgroundimageurl" placeholder="URL" class="styleSupport" value="#esapiEncode('html_attr',attributes.params.styleSupport.contentbackgroundimageurl)#">
								<cfif len(request.assocatedImageURL)>
									<div class="btn-group btn-group-sm" role="group" aria-label="Select Image">		
										<button type="button" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
											<i class="mi-image"></i> Select Image <span class="caret"></span>
										</button>
										<ul class="dropdown-menu">
											<li><a class="mura-finder" data-target="contentbackgroundimageurl" data-completepath="false" href="javascript:void(0);"><i class="mi-globe"></i> File Manager</a></li>
											<li><a id="contentbackgroundassocurl" href="#request.assocatedImageURL#"> <i class="mi-th"></i> Associated Image</a></li>
										</ul>
										<script>
											$(function(){
												$('##contentbackgroundassocurl').click(function(){
													$('##contentbackgroundimageurl').val($(this).attr('href')).trigger('change');
													return false;
												})
											})
										</script>
									</div>
								<cfelse>
									<button type="button" class="btn mura-finder" data-target="contentbackgroundimageurl" data-completepath="false"><i class="mi-image"></i> Select Image</button>
								</cfif>
							</div>

					<div class="mura-control-group mura-ui-grid content-css-bg-option bg-position" style="display:none;">
								<label>Background Position</label>

								<div class="row mura-ui-row">
									<div class="col-xs-4"><label class="right ui-nested">Vertical</label></div>
									<div class="col-xs-8">
										<div class="mura-input-group">
											<label>
												<input type="text" id="contentbackgroundpositionynum" name="contentBackgroundPositionyNum" class="numeric" placeholder="" value="<cfif val(esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.backgroundpositiony))>#val(esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.backgroundpositiony))#</cfif>" style="display: none;">
											</label>

											<select id="contentbackgroundpositiony" name="contentBackgroundPositionY" class="styleSupport" data-numfield="contentbackgroundpositionynum">
												<cfloop list="Top,Center,Bottom,%,px,vh,vw" index="p">
													<option value="#lcase(p)#"<cfif attributes.params.stylesupport.contentstyles.backgroundpositiony contains p> selected</cfif>>#p#</option>
												</cfloop>
											</select>

											<input type="hidden" id="contentbackgroundpositionyval" name="backgroundPositionY" class="contentStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.backgroundpositiony)#">

										</div>
									</div>
								</div>

								<div class="row mura-ui-row">
									<div class="col-xs-4"><label class="right ui-nested">Horizontal</label></div>
									<div class="col-xs-8">
										<div class="mura-input-group">
											<label>
												<input type="text" id="contentbackgroundpositionxnum" name="contentBackgroundPositionxNum" class="numeric" placeholder="" value="<cfif val(esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.backgroundpositionx))>#val(esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.backgroundpositionx))#</cfif>" style="display: none;">
											</label>

											<select id="contentbackgroundpositionx" name="contentBackgroundPositionX" class="styleSupport" data-numfield="contentbackgroundpositionxnum">
												<cfloop list="Left,Center,Right,%,px,vh,vw" index="p">
													<option value="#lcase(p)#"<cfif attributes.params.stylesupport.contentstyles.backgroundpositionx contains p> selected</cfif>>#p#</option>
												</cfloop>
											</select>

											<input type="hidden" id="contentbackgroundpositionxval" name="backgroundPositionX" class="contentStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.backgroundpositionx)#">

										</div>
									</div>
								</div>
							</div>
							
							<div class="mura-control-group content-css-bg-option" style="display:none;">
								<label>Background Repeat</label>
								<select id="contentbackgroundrepeat" name="backgroundRepeat" class="contentStyle">
									<option value="no-repeat"<cfif attributes.params.stylesupport.contentstyles.backgroundrepeat eq 'norepeat'> selected</cfif>>No-repeat</option>
									<option value="repeat"<cfif attributes.params.stylesupport.contentstyles.backgroundrepeat eq 'repeat'> selected</cfif>>Repeat</option>
									<option value="repeat-x"<cfif attributes.params.stylesupport.contentstyles.backgroundrepeat eq 'repeatx'> selected</cfif>>Repeat-X</option>
									<option value="repeat-y"<cfif attributes.params.stylesupport.contentstyles.backgroundrepeat eq 'repeaty'> selected</cfif>>Repeat-Y</option>
								</select>
							</div>

							<div class="mura-control-group content-css-bg-option" style="display:none;">
								<label>Background Size</label>
								<select id="contentbackgroundsize" name="backgroundSize" class="contentStyle">
									<option value="auto"<cfif attributes.params.stylesupport.contentstyles.backgroundsize eq 'auto'>
									selected</cfif>>Auto</option>
									<option value="contain"<cfif attributes.params.stylesupport.contentstyles.backgroundsize eq 'contain'> selected</cfif>>Contain</option>
									<option value="cover"<cfif attributes.params.stylesupport.contentstyles.backgroundsize eq 'cover'> selected</cfif>>Cover</option>
								</select>
							</div>

							<div class="mura-control-group content-css-bg-option" style="display:none;">
								<label>Background Attachment</label>
								<select name="backgroundAttachment" class="contentStyle">
									<option value="scroll"<cfif attributes.params.stylesupport.contentstyles.backgroundAttachment eq 'scroll'>
									selected</cfif>>Scroll</option>
									<option value="Fixed"<cfif attributes.params.stylesupport.contentstyles.backgroundAttachment eq 'fixed'> selected</cfif>>Fixed</option>
								</select>
							</div>

            <!--- /end panel contents --->
            </div> <!--- /.mura-panel-body --->
        </div> <!--- /.panel-collapse --->
    </div> <!--- /.mura-panel --->

		<!--- panel 4: custom --->
    <div class="panel mura-panel">
        <div class="mura-panel-heading panel-content">
            <h4 class="mura-panel-title">
                <a class="collapse collapsed" data-toggle="collapse" data-parent="##panels-style-content" href="##panel-style-content-4">Custom
                </a>
            </h4>
        </div> <!--- /.mura-panel-heading --->
        <div id="panel-style-content-4" class="panel-collapse collapse">
            <div class="mura-panel-body">
            <!--- panel contents --->
							<div class="mura-control-group">
								<label>
								Z-Index
								</label>
								<input name="zIndex" class="contentStyle numeric" type="text" value="#esapiEncode('html_attr',attributes.params.stylesupport.contentstyles.zindex)#" maxlength="5">
							</div>
							<div class="mura-control-group">
								<label>
									CSS ID
								</label>
								<input name="contentcssid" class="objectParam" type="text" value="#esapiEncode('html_attr',attributes.params.contentcssid)#" maxlength="255">
							</div>
							<div class="mura-control-group">
								<label>
									CSS Class
								</label>
								<input name="contentcssclass" class="objectParam" type="text" value="#esapiEncode('html_attr',attributes.params.contentcssclass)#" maxlength="255">
							</div>
            <!--- /end panel contents --->
            </div> <!--- /.mura-panel-body --->
        </div> <!--- /.panel-collapse --->
    </div> <!--- /.mura-panel --->

</div> <!--- /.mura-panel-group --->

</cfoutput>
