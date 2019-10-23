<!--- todo: document nested configurator panel syntax --->
<!---
<div class="mura-panel-group" id="panels-style-object">

		<!--- panel 1: layout --->
    <div class="panel mura-panel">
        <div class="mura-panel-heading">
            <h4 class="mura-panel-title">
                <a class="collapse collapsed" data-toggle="collapse" data-parent="##panels-style-object" href="##panel-style-object-1">Layout
                </a>
            </h4>
        </div> <!--- /.mura-panel-heading --->
        <div id="panel-style-object-1" class="panel-collapse collapse">
            <div class="mura-panel-body">
            <!--- panel contents --->

            <!--- /end panel contents --->
            </div> <!--- /.mura-panel-body --->
        </div> <!--- /.panel-collapse --->
    </div> <!--- /.mura-panel --->

</div> <!--- /.mura-panel-group --->
--->

<cfoutput>

<div class="mura-panel-group" id="panels-style-object">

		<!--- panel 1: layout --->
    <div class="panel mura-panel">
        <div class="mura-panel-heading">
            <h4 class="mura-panel-title">
                <a class="collapse collapsed" data-toggle="collapse" data-parent="##panels-style-object" href="##panel-style-object-1">Layout
                </a>
            </h4>
        </div> <!--- /.mura-panel-heading --->
        <div id="panel-style-object-1" class="panel-collapse collapse">
            <div class="mura-panel-body">
            	<!--- panel contents --->
						<cfif request.haspositionoptions>

							<div class="mura-control-group">
								<label>#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.alignment')#</label>
								<select name="alignment" class="classtoggle">
								<option value="">--</option>
								<option value="mura-left"<cfif listFind(attributes.params.class,'mura-left',' ')> selected</cfif>>#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.left')#</option>
								<!---<option value="mura-center"<cfif listFind(attributes.params.class,'mura-center',' ')> selected</cfif>>#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.center')#</option>--->
								<option value="mura-right"<cfif listFind(attributes.params.class,'mura-right',' ')> selected</cfif>>#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.right')#</option>
								</select>
							</div>

							<div class="mura-control-group">
								<label>#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.width')#</label>
								<!--- width selector widget --->
								<div id="object-widthsel-ui">
									<div id="object-widthsel-wrapper">
									<cfloop from="1" to="#arrayLen(attributes.positionoptions)#" index="i">
										<cfset p = attributes.positionoptions[i]>
										<cfif structKeyExists(p,'cols') and val(p["cols"])>
										<div class="object-widthsel-option" data-value="#p["value"]#"><span>#p["cols"]#</span></div>
										</cfif>
									</cfloop>
									</div>
								</div>
								<!--- hidden select tied to js logic in objectconfigurator.cfm --->
								<div style="display: none">
									<select name="width" id="objectwidthsel" class="classtoggle">
										<cfloop from="1" to="#arrayLen(attributes.positionoptions)#" index="i">
											<cfset p = attributes.positionoptions[i]>
											<option value="#p['value']#"<cfif listFind(attributes.params.class,'#p['value']#',' ')> selected</cfif>>#p['label']#</option>
											<cfset l = "'#p["label"]#'">
											<cfset v = "'#p["value"]#'">
										</cfloop>
									</select>
								</div>
							</div>

							<cfif len(contentcontainerclass)>
								<div class="mura-control-group constraincontentcontainer" style='display:none;'>
											<!--- todo: rb keys --->
											<label class="css-input switch switch-sm switch-primary">
								<input type="checkbox" id="expandedwidthtoggle" name="expandedwidthtoggle" value="true"<cfif listFind(attributes.params.class,'mura-expanded',' ')> checked</cfif>><span></span> Expand Width
							</label>
											<label class="css-input switch switch-sm switch-primary">
								<input name="constraincontenttoggle" type="checkbox" id="constraincontenttoggle" value="true"<cfif listFind(attributes.params.contentcssclass,contentcontainerclass,' ')> checked</cfif>><span></span> Constrain Content
							</label>
									<!--- hidden select tied to js logic in objectconfigurator.cfm --->
											<div style="display:none;">	
												<select name="constraincontent" id="objectconstrainsel" class="classtoggle">
													<option value=""<cfif not listFind(attributes.params.contentcssclass,contentcontainerclass,' ')> selected</cfif>>False</option>
													<option value="constrain"<cfif listFind(attributes.params.contentcssclass,contentcontainerclass,' ')> selected</cfif>>True</option>
												</select> 
											</div>									 								
								</div>
							</cfif>

							<div class="mura-control-group objectbreakpointcontainer" style="display:none;">
								<!--- todo: rbkeys for label and options --->
								<label>Full-Width Breakpoint</label>
								<select name="breakpoint"  id="objectbreakpointsel" class="classtoggle">
								<option value="">Auto</option>
								<option value="mura-sm"<cfif listFind(attributes.params.class,'mura-sm',' ')> selected</cfif>>Tablet ( <768px )</option>
								<option value="mura-md"<cfif listFind(attributes.params.class,'mura-md',' ')> selected</cfif>>Laptop ( <992px )</option>
								<option value="mura-lg"<cfif listFind(attributes.params.class,'mura-lg',' ')> selected</cfif>> Desktop ( <1200px )</option>
								</select>
							</div>
							
						</cfif>

						<div class="mura-control-group">
							<!--- todo: rbkey for margin and placeholders --->
							<label>Minimum Height</label>

							<div class="row mura-ui-row">
								<div class="mura-input-group">
									<label class="mura-serial">
										<input type="text" name="objectminheight" id="objectminheightnum" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.objectstyles.minheight))>#val(esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.minheight))#</cfif>">
									</label>
									<select id="objectminheightuom" name="objectminheightuom" class="styleSupport">
										<cfloop list="#request.objectlayoutuomext#" index="u">
											<option value="#u#"<cfif attributes.params.stylesupport.objectminheightuom eq u or not len(attributes.params.styleSupport.objectpaddinguom) and u eq request.preferreduom> selected</cfif>>#u#</option>
										</cfloop>
									</select>
								</div>
								<input type="hidden" name="minHeight" id="objectminheightuomval" class="objectStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.minheight)#">
							</div>
						</div>
						
						<cfif arrayLen(request.spacingoptions)>
							<div class="mura-control-group mura-ui-grid">
								<label>Spacing</label>
								<select name="objectspacing" class="objectParam">
									<option value="">--</option>
									<cfloop array="#request.spacingoptions#" index="option">
										<option value="#option.value#"<cfif attributes.params.objectspacing eq option.value> selected</cfif>>#esapiEncode('html',option.name)#</option>
									</cfloop>
									<option value="custom"<cfif attributes.params.objectspacing eq 'custom'> selected</cfif>>Custom</option>
								</select>
							</div>
						</cfif>

						<div id="customobjectspacing"<cfif arrayLen(request.spacingoptions) and attributes.params.objectspacing neq 'custom'> style="display:none;"</cfif>>
							<!--- margin --->
							<div class="mura-control-group mura-ui-grid">
								<!--- todo: rbkey for margin and placeholders --->
								<label>Margin</label>

								<div class="row mura-ui-row">
									<div class="col-xs-12 center">
										<div class="mura-input-group">
											<label sclass="mura-serial">
												<input type="text" name="margin" id="objectmarginall" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.objectstyles.marginall))>#val(esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.marginall))#</cfif>">
											</label>
											<select id="objectmarginuom" name="objectmarginuom" class="styleSupport">
												<cfloop list="#request.objectlayoutuom#" index="u">
													<option value="#u#"<cfif attributes.params.stylesupport.objectmarginuom eq u or not len(attributes.params.styleSupport.objectmarginuom) and u eq request.preferreduom> selected</cfif>>#u#</option>
												</cfloop>
											</select>
										<a class="btn ui-advanced mura-ui-link" data-reveal="objectmarginadvanced" href="##"><i class="mi-arrows"></i></a>
										</div>
									</div>
								</div>
								<div id="objectmarginadvanced" class="mura-ui-inset" style="display: none;">
									<div class="row mura-ui-row">
										<div class="col-xs-3"></div>
										<div class="col-xs-6">
											<label class="mura-serial">
												<input type="text" name="objectMarginTop" id="objectmargintop" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.objectstyles.margintop))>#val(esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.margintop))#</cfif>">
											</label>
											<input type="hidden" name="marginTop" id="objectmargintopval" class="objectStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.margintop)#">
										</div>
										<div class="col-xs-3"></div>
									</div>

									<div class="row mura-ui-row">
										<div class="col-xs-5">
												<div class="mura-input-group">
													<label class="mura-serial">
														<input type="text" name="objectMarginLeft" id="objectmarginleft" class="numeric serial pull-right" value="<cfif  attributes.params.stylesupport.objectstyles.marginleft eq 'auto'>auto<cfelseif len(trim(attributes.params.stylesupport.objectstyles.marginleft))>#val(esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.marginleft))#</cfif>">
															<!---<a class="btn pull-right input-auto" data-auto-input="objectmarginleft" href="##"><span>a</span></a>--->
														</label>
												</div>
											<input type="hidden" name="marginLeft" id="objectmarginleftval" class="objectStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.marginleft)#">
										</div>
										<div class="col-xs-2">
											<i class="mi-arrows ui-inset-icon"></i>
										</div>
										<div class="col-xs-5">
											<div class="mura-input-group">
												<label class="mura-serial">
													<input type="text" name="objectMarginRight" id="objectmarginright" class="numeric serial pull-left" value="<cfif  attributes.params.stylesupport.objectstyles.marginright eq 'auto'>auto<cfelseif len(trim(attributes.params.stylesupport.objectstyles.marginright))>#val(esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.marginright))#</cfif>">
													<!---<a class="btn pull-left input-auto" data-auto-input="objectmarginright" href="##"><span>a</span></a>--->
												</label>
											</div>
											<input type="hidden" name="marginRight" id="objectmarginrightval" class="objectStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.marginright)#">
										</div>
									</div>

									<div class="row mura-ui-row">
										<div class="col-xs-3"></div>
										<div class="col-xs-6">
											<label class="mura-serial">
												<input type="text" name="objectMarginBottom" id="objectmarginbottom" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.objectstyles.marginbottom))>#val(esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.marginbottom))#</cfif>">
											</label>
											<input type="hidden" name="marginBottom" id="objectmarginbottomval" class="objectStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.marginbottom)#">
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
												<input type="text" name="padding" id="objectpaddingall" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.objectstyles.paddingall))>#val(esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.paddingall))#</cfif>">
											</label>
											<select id="objectpaddinguom" name="objectpaddinguom" class="styleSupport">
												<cfloop list="#request.objectlayoutuom#" index="u">
													<option value="#u#"<cfif attributes.params.styleSupport.objectpaddinguom eq u or not len(attributes.params.styleSupport.objectpaddinguom) and u eq request.preferreduom> selected</cfif>>#u#</option>
												</cfloop>
											</select>
										</div>
										<a class="btn ui-advanced mura-ui-link" data-reveal="objectpaddingadvanced" href="##"><i class="mi-arrows"></i></a>
									</div>
								</div>

								<div id="objectpaddingadvanced" class="mura-ui-inset" style="display: none;">
									<div class="row mura-ui-row">
										<div class="col-xs-3"></div>
										<div class="col-xs-6">
											<label class="mura-serial">
												<input type="text" name="objectPaddingTop" id="objectpaddingtop" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.objectstyles.paddingtop))>#val(esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.paddingtop))#</cfif>">
											</label>
											<input type="hidden" name="paddingTop" id="objectpaddingtopval" class="objectStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.paddingtop)#">
										</div>
										<div class="col-xs-3"></div>
									</div>

									<div class="row mura-ui-row">
										<div class="col-xs-1"></div>
										<div class="col-xs-4">
											<label class="mura-serial">
												<input type="text" name="objectPaddingLeft" id="objectpaddingleft" class="numeric serial pull-right" value="<cfif len(trim(attributes.params.stylesupport.objectstyles.paddingleft))>#val(esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.paddingleft))#</cfif>">
											</label>
											<input type="hidden" name="paddingLeft" id="objectpaddingleftval" class="objectStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.paddingleft)#">
										</div>
										<div class="col-xs-2">
											<i class="mi-arrows ui-inset-icon"></i>
										</div>
										<div class="col-xs-4">
											<label class="mura-serial">
												<input type="text" name="objectPaddingRight" id="objectpaddingright" class="numeric serial pull-left" value="<cfif len(trim(attributes.params.stylesupport.objectstyles.paddingright))>#val(esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.paddingright))#</cfif>">
											</label>
											<input type="hidden" name="paddingRight" id="objectpaddingrightval" class="objectStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.paddingright)#">
										</div>
										<div class="col-xs-1"></div>
									</div>

									<div class="row mura-ui-row">
										<div class="col-xs-3"></div>
										<div class="col-xs-6">
											<label class="mura-serial">
												<input type="text" name="objectPaddingBottom" id="objectpaddingbottom" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.objectstyles.paddingbottom))>#val(esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.paddingbottom))#</cfif>">
											</label>
											<input type="hidden" name="paddingBottom" id="objectpaddingbottomval" class="objectStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.paddingbottom)#">
										</div>
										<div class="col-xs-3"></div>
									</div>
								</div>

							</div>
						</div>
						<cfif arrayLen(request.spacingoptions)>
							<script>
								$('select[name="objectspacing"').on(
									'change',
									function(){
										if($(this).val()=='custom'){
											$('##customobjectspacing').show();
										} else {
											$('##customobjectspacing').hide();
											$('##objectpaddingall').val('').trigger('change');
											$('##objectmarginall').val('').trigger('change');
										}
									}	
								)
							</script>
						</cfif>

            	<!--- /panel contents --->
            </div> <!--- /.mura-panel-body --->
        </div> <!--- /.panel-collapse --->
    </div> <!--- /.mura-panel --->

		<!--- panel 2: theme --->
    <div class="panel mura-panel">
        <div class="mura-panel-heading">
            <h4 class="mura-panel-title">
                <a class="collapse collapsed" data-toggle="collapse" data-parent="##panels-style-object" href="##panel-style-object-2">Theme
                </a>
            </h4>
        </div> <!--- /.mura-panel-heading --->
        <div id="panel-style-object-2" class="panel-collapse collapse">
            <div class="mura-panel-body">
         		<!--- panel contents --->

         				<!--- theme --->
								<cfif arrayLen(request.modulethemeoptions)>
								<div class="mura-control-group">
									<label>Theme</label>
									<select name="moduletheme" class="classtoggle">
										<option value="">--</option>
										<cfloop array="#request.modulethemeoptions#" index="theme">
											<option value="#theme.value#"<cfif listFind(attributes.params.class,theme.value,' ') OR (listLen(theme.value,' ') gt 1 and attributes.params.class contains theme.value)> selected</cfif>>#esapiEncode('html',theme.name)#</option>
										</cfloop>
									</select>
								</div>
								</cfif>

								<!--- text color --->
								<div class="mura-control-group">
									<!--- todo: rbkey for these labels, options and placeholders--->
									<label>Text Color</label>
									<div class="input-group mura-colorpicker">
										<span class="input-group-addon"><i class="mura-colorpicker-swatch"></i></span>
										<input type="text" id="objecttextcolor" name="color" class="objectStyle" placeholder="Select Color" autocomplete="off" value="#esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.color)#">
									</div>
								</div>

         		<!--- /end panel contents --->
            </div> <!--- /.mura-panel-body --->
        </div> <!--- /.panel-collapse --->
    </div> <!--- /.mura-panel --->

		<!--- panel 3: background --->
    <div class="panel mura-panel">
        <div class="mura-panel-heading">
            <h4 class="mura-panel-title">
                <a class="collapse collapsed" data-toggle="collapse" data-parent="##panels-style-object" href="##panel-style-object-3">Background
                </a>
            </h4>
        </div> <!--- /.mura-panel-heading --->
        <div id="panel-style-object-3" class="panel-collapse collapse">
            <div class="mura-panel-body">
            <!--- panel contents --->
						<!--- background --->
						<div class="mura-control-group">
							<!--- todo: rbkey for these labels, options and placeholders--->
							<label>Background Color</label>
							<div class="input-group mura-colorpicker" id="objectbackgroundcustom">
								<span class="input-group-addon"><i class="mura-colorpicker-swatch"></i></span>
								<input type="text" id="objectbackgroundcolor" name="backgroundColor" class="objectStyle" placeholder="Select Color" autocomplete="off" value="#esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.backgroundcolor)#">
							</div>
						</div>

						<div class="mura-control-group">
							<label>Background Image</label>
							<input type="hidden" id="objectbackgroundimage" name="backgroundImage" class="objectStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.backgroundimage)#">
							<input type="text" id="objectbackgroundimageurl" name="objectbackgroundimageurl" placeholder="URL" class="styleSupport" value="#esapiEncode('html_attr',attributes.params.styleSupport.objectbackgroundimageurl)#">
							
							<cfif len(request.assocatedImageURL)>
								<div class="btn-group btn-group-sm" role="group" aria-label="Select Image">		
									<button type="button" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										<i class="mi-image"></i> Select Image <span class="caret"></span>
									</button>
									<ul class="dropdown-menu">
										<li><a class="mura-finder" data-target="objectbackgroundimageurl" data-completepath="false" href="javascript:void(0);"><i class="mi-globe"></i> File Manager</a></li>
										<li><a id="objectbackgroundassocurl" href="#request.assocatedImageURL#"> <i class="mi-th"></i> Associated Image</a></li>
									</ul>
									<script>
										$(function(){
											$('##objectbackgroundassocurl').click(function(){
												$('##objectbackgroundimageurl').val($(this).attr('href')).trigger('change');
												return false;
											})
										})
									</script>
								</div>
							<cfelse>
								<button type="button" class="btn mura-finder" data-target="objectbackgroundimageurl" data-completepath="false"><i class="mi-image"></i> Select Image</button>
							</cfif>

						</div>
						<div class="mura-control-group mura-ui-grid object-css-bg-option bg-position" style="display:none;">
							<label>Background Position</label>

							<div class="row mura-ui-row">
								<div class="col-xs-4"><label class="right ui-nested">Vertical</label></div>
								<div class="col-xs-8">
									<div class="mura-input-group">
										<label>
											<input type="text" id="objectbackgroundpositionynum" name="objectBackgroundPositionyNum" class="numeric" placeholder="" value="<cfif val(esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.backgroundpositiony))>#val(esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.backgroundpositiony))#</cfif>" style="display: none;">
										</label>

										<select id="objectbackgroundpositiony" name="objectBackgroundPositionY" class="styleSupport" data-numfield="objectbackgroundpositionynum">
											<cfloop list="Top,Center,Bottom,%,px" index="p">
												<option value="#lcase(p)#"<cfif attributes.params.stylesupport.objectstyles.backgroundpositiony contains p> selected</cfif>>#p#</option>
											</cfloop>
										</select>

										<input type="hidden" id="objectbackgroundpositionyval" name="backgroundPositionY" class="objectStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.backgroundpositiony)#">

									</div>
								</div>
							</div>

							<div class="row mura-ui-row">
								<div class="col-xs-4"><label class="right ui-nested">Horizontal</label></div>
								<div class="col-xs-8">
									<div class="mura-input-group">
										<label>
											<input type="text" id="objectbackgroundpositionxnum" name="objectBackgroundPositionxNum" class="numeric" placeholder="" value="<cfif val(esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.backgroundpositionx))>#val(esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.backgroundpositionx))#</cfif>" style="display: none;">
										</label>

										<select id="objectbackgroundpositionx" name="objectBackgroundPositionX" class="styleSupport" data-numfield="objectbackgroundpositionxnum">
											<cfloop list="Left,Center,Right,%,px" index="p">
												<option value="#lcase(p)#"<cfif attributes.params.stylesupport.objectstyles.backgroundpositionx contains p> selected</cfif>>#p#</option>
											</cfloop>
										</select>

										<input type="hidden" id="objectbackgroundpositionxval" name="backgroundPositionX" class="objectStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.backgroundpositionx)#">

									</div>
								</div>
							</div>
						</div>

						<div class="mura-control-group object-css-bg-option" style="display:none;">
							<label>Background Repeat</label>
							<select id="objectbackgroundrepeat" name="backgroundRepeat" class="objectStyle">
								<option value="no-repeat"<cfif attributes.params.stylesupport.objectstyles.backgroundrepeat eq 'norepeat'> selected</cfif>>No-repeat</option>
								<option value="repeat"<cfif attributes.params.stylesupport.objectstyles.backgroundrepeat eq 'repeat'> selected</cfif>>Repeat</option>
								<option value="repeat-x"<cfif attributes.params.stylesupport.objectstyles.backgroundrepeat eq 'repeatx'> selected</cfif>>Repeat-X</option>
								<option value="repeat-y"<cfif attributes.params.stylesupport.objectstyles.backgroundrepeat eq 'repeaty'> selected</cfif>>Repeat-Y</option>
							</select>
						</div>

						<div class="mura-control-group object-css-bg-option" style="display:none;">
							<label>Background Size</label>
							<select id="objectbackgroundsize" name="backgroundSize" class="objectStyle">
								<option value="auto"<cfif attributes.params.stylesupport.objectstyles.backgroundsize eq 'auto'>
								selected</cfif>>Auto</option>
								<option value="contain"<cfif attributes.params.stylesupport.objectstyles.backgroundsize eq 'contain'> selected</cfif>>Contain</option>
								<option value="cover"<cfif attributes.params.stylesupport.objectstyles.backgroundsize eq 'cover'> selected</cfif>>Cover</option>
							</select>
						</div>

						<div class="mura-control-group object-css-bg-option" style="display:none;">
							<label>Background Attachment</label>
							<select name="backgroundAttachment" class="objectStyle">
								<option value="scroll"<cfif attributes.params.stylesupport.objectstyles.backgroundAttachment eq 'scroll'>
								selected</cfif>>Scroll</option>
								<option value="Fixed"<cfif attributes.params.stylesupport.objectstyles.backgroundAttachment eq 'fixed'> selected</cfif>>Fixed</option>
							</select>
						</div>

            <!--- /end panel contents --->
            </div> <!--- /.mura-panel-body --->
        </div> <!--- /.panel-collapse --->
    </div> <!--- /.mura-panel --->

		<!--- panel 4: custom --->
    <div class="panel mura-panel">
        <div class="mura-panel-heading">
            <h4 class="mura-panel-title">
                <a class="collapse collapsed" data-toggle="collapse" data-parent="##panels-style-object" href="##panel-style-object-4">Custom
                </a>
            </h4>
        </div> <!--- /.mura-panel-heading --->
        <div id="panel-style-object-4" class="panel-collapse collapse">
            <div class="mura-panel-body">
            <!--- panel contents --->

							<div class="mura-control-group">
								<label>
								Z-Index
								</label>
								<input name="zIndex" class="objectStyle numeric" type="text" value="#esapiEncode('html_attr',attributes.params.stylesupport.objectstyles.zindex)#" maxlength="5">
							</div>
							<div class="mura-control-group">
								<label>
									CSS Class
								</label>
								<input name="cssclass" class="objectParam classtoggle" type="text" value="#esapiEncode('html_attr',attributes.params.cssclass)#" maxlength="255">
							</div>
							<div class="mura-control-group">
								<label>
									Custom CSS Styles
								</label>
								<cfoutput>
								<textarea class="textarea-lg" id="customstylesedit">#esapiEncode('html',attributes.params.stylesupport.css)#</textarea>
								</cfoutput>
								<!--- todo: rb key --->
								<a class="btn" id="applystyles"><i class="mi-check"></i>Apply Custom Styles</a>
								<script>
									Mura('##applystyles').click(function(){
										jQuery('##csscustom').val(Mura('##customstylesedit').val()).trigger('change');
									})
								</script>
							</div>
            <!--- /end panel contents --->
            </div> <!--- /.mura-panel-body --->
        </div> <!--- /.panel-collapse --->
    </div> <!--- /.mura-panel --->

</div> <!--- /.mura-panel-group --->
</cfoutput>
