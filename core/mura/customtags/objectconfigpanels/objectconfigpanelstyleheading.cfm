<cfoutput>
<div class="mura-panel-group" id="panels-style-meta">

		<!--- panel 1: label --->
    <div class="panel mura-panel">
        <div class="mura-panel-heading panel-meta">
            <h4 class="mura-panel-title">
                <a class="collapse collapsed" data-toggle="collapse" data-parent="##panels-style-meta" href="##panel-style-meta-1">Position
                </a>
            </h4>
        </div> <!--- /.mura-panel-heading --->
        <div id="panel-style-meta-1" class="panel-collapse collapse">
            <div class="mura-panel-body">
            <!--- panel contents --->
            <!--- todo: rbkeys --->
			<!--- label position --->
			<div class="mura-control-group">
				<label>Position</label>
				<select name="labelposition" class="classtoggle">
				<option value="mura-object-label-top"<cfif listFind(attributes.params.class,'mura-object-label-top',' ')> selected</cfif>>Top</option>
				<option value="mura-object-label-left"<cfif listFind(attributes.params.class,'mura-object-label-left',' ')> selected</cfif>>Left</option>
				<option value="mura-object-label-right"<cfif listFind(attributes.params.class,'mura-object-label-right',' ')> selected</cfif>>Right</option>
				</select>
			</div>

			<!--- label alignment --->
			<div class="mura-control-group">
				<label>Align</label>
				<select name="float" class="metaStyle">
					<option value="none"<cfif attributes.params.stylesupport.metastyles.float eq 'none'> selected</cfif>>#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.center')#</option>
					<option value="left"<cfif attributes.params.stylesupport.metastyles.float eq 'left'> selected</cfif>>#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.left')#</option>
					<option value="right"<cfif attributes.params.stylesupport.metastyles.float eq 'right'> selected</cfif>>#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.right')#</option>
				</select>
			</div>
            <!--- /end panel contents --->
            </div> <!--- /.mura-panel-body --->
        </div> <!--- /.panel-collapse --->
    </div> <!--- /.mura-panel --->

		<!--- panel 2: layout --->
    <div class="panel mura-panel">
        <div class="mura-panel-heading panel-meta">
            <h4 class="mura-panel-title">
                <a class="collapse collapsed" data-toggle="collapse" data-parent="##panels-style-meta" href="##panel-style-meta-2">Layout
                </a>
            </h4>
        </div> <!--- /.mura-panel-heading --->
        <div id="panel-style-meta-2" class="panel-collapse collapse">
            <div class="mura-panel-body">
            <!--- panel contents --->
								<!--- margin --->
								<div class="mura-control-group mura-ui-grid">
									<!--- todo: rbkey for margin and placeholders --->
									<label>Margin</label>

									<div class="row mura-ui-row">
										<div class="col-xs-12 center">
											<div class="mura-input-group">
												<label class="mura-serial">
													<input type="text" name="margin" id="metamarginall" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.metastyles.marginall))>#val(esapiEncode('html_attr',attributes.params.stylesupport.metastyles.marginall))#</cfif>">
												</label>
												<select id="metamarginuom" name="metamarginuom" class="styleSupport">
													<cfloop list="#request.objectlayoutuom#" index="u">
														<option value="#u#"<cfif attributes.params.styleSupport.metamarginuom eq u or not len(attributes.params.styleSupport.metamarginuom) and u eq request.preferreduom> selected</cfif>>#u#</option>
													</cfloop>
												</select>
											</div>
										<a class="btn ui-advanced mura-ui-link" data-reveal="metamarginadvanced" href="##"><i class="mi-arrows"></i></a>
										</div>
									</div>

									<div id="metamarginadvanced" class="mura-ui-inset" style="display: none;">
										<div class="row mura-ui-row">
											<div class="col-xs-3"></div>
											<div class="col-xs-6">
												<label class="mura-serial">
													<input type="text" name="metaMarginTop" id="metamargintop" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.metastyles.margintop))>#val(esapiEncode('html_attr',attributes.params.stylesupport.metastyles.margintop))#</cfif>">
												</label>
												<input type="hidden" name="marginTop" id="metamargintopval" class="metaStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.metastyles.margintop)#">
											</div>
											<div class="col-xs-3"></div>
										</div>

										<div class="row mura-ui-row">
											<div class="col-xs-5">
												<label class="mura-serial">
													<input type="text" name="metaMarginLeft" id="metamarginleft" class="numeric serial pull-right" value="<cfif attributes.params.stylesupport.metastyles.marginleft eq 'auto'>auto<cfelseif len(trim(attributes.params.stylesupport.metastyles.marginleft))>#val(esapiEncode('html_attr',attributes.params.stylesupport.metastyles.marginleft))#</cfif>">
													<a class="btn pull-right input-auto" data-auto-input="metamarginleft" href="##"><span>a</span></a>
												</label>
												<input type="hidden" name="marginLeft" id="metamarginleftval" class="metaStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.metastyles.marginleft)#">
											</div>
											<div class="col-xs-2">
												<i class="mi-arrows ui-inset-icon"></i>
											</div>
											<div class="col-xs-5">
												<label class="mura-serial">
													<input type="text" name="metaMarginRight" id="metamarginright" class="numeric serial pull-left" value="<cfif attributes.params.stylesupport.metastyles.marginright eq 'auto'>auto<cfelseif len(trim(attributes.params.stylesupport.metastyles.marginright))>#val(esapiEncode('html_attr',attributes.params.stylesupport.metastyles.marginright))#</cfif>">
													<a class="btn pull-left input-auto" data-auto-input="metamarginright" href="##"><span>a</span></a>
												</label>
												<input type="hidden" name="marginRight" id="metamarginrightval" class="metaStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.metastyles.marginright)#">
											</div>
										</div>

										<div class="row mura-ui-row">
											<div class="col-xs-3"></div>
											<div class="col-xs-6">
												<label class="mura-serial">
													<input type="text" name="metaMarginBottom" id="metamarginbottom" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.metastyles.marginbottom))>#val(esapiEncode('html_attr',attributes.params.stylesupport.metastyles.marginbottom))#</cfif>">
												</label>
												<input type="hidden" name="marginBottom" id="metamarginbottomval" class="metaStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.metastyles.marginbottom)#">
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
													<input type="text" name="padding" id="metapaddingall" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.metastyles.paddingall))>#val(esapiEncode('html_attr',attributes.params.stylesupport.metastyles.paddingall))#</cfif>">
												</label>
												<select id="metapaddinguom" name="metapaddinguom" class="styleSupport">
													<cfloop list="#request.objectlayoutuom#" index="u">
														<option value="#u#"<cfif attributes.params.styleSupport.metapaddinguom eq u or not len(attributes.params.styleSupport.metapaddinguom) and u eq request.preferreduom> selected</cfif>>#u#</option>
													</cfloop>
												</select>
											</div>
										<a class="btn ui-advanced mura-ui-link" data-reveal="metapaddingadvanced" href="##"><i class="mi-arrows"></i></a>
										</div>
									</div>

									<div id="metapaddingadvanced" class="mura-ui-inset" style="display: none;">
										<div class="row mura-ui-row">
											<div class="col-xs-3"></div>
											<div class="col-xs-6">
												<label class="mura-serial">
													<input type="text" name="metaPaddingTop" id="metapaddingtop" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.metastyles.paddingtop))>#val(esapiEncode('html_attr',attributes.params.stylesupport.metastyles.paddingtop))#</cfif>">
												</label>
												<input type="hidden" name="paddingTop" id="metapaddingtopval" class="metaStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.metastyles.paddingtop)#">
											</div>
											<div class="col-xs-3"></div>
										</div>

										<div class="row mura-ui-row">
											<div class="col-xs-1"></div>
												<div class="col-xs-4">
													<label class="mura-serial">
														<input type="text" name="metaPaddingLeft" id="metapaddingleft" class="numeric serial pull-right" value="<cfif len(trim(attributes.params.stylesupport.metastyles.paddingleft))>#val(esapiEncode('html_attr',attributes.params.stylesupport.metastyles.paddingleft))#</cfif>">
													</label>
													<input type="hidden" name="paddingLeft" id="metapaddingleftval" class="metaStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.metastyles.paddingleft)#">
												</div>
												<div class="col-xs-2">
													<i class="mi-arrows ui-inset-icon"></i>
												</div>
												<div class="col-xs-4">
													<label class="mura-serial">
														<input type="text" name="metaPaddingRight" id="metapaddingright" class="numeric serial pull-left" value="<cfif len(trim(attributes.params.stylesupport.metastyles.paddingright))>#val(esapiEncode('html_attr',attributes.params.stylesupport.metastyles.paddingright))#</cfif>">
													</label>
													<input type="hidden" name="paddingRight" id="metapaddingrightval" class="metaStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.metastyles.paddingright)#">
												</div>
											<div class="col-xs-1"></div>
										</div>

										<div class="row mura-ui-row">
											<div class="col-xs-3"></div>
											<div class="col-xs-6">
												<label class="mura-serial">
													<input type="text" name="metaPaddingBottom" id="metapaddingbottom" class="numeric serial" value="<cfif len(trim(attributes.params.stylesupport.metastyles.paddingbottom))>#val(esapiEncode('html_attr',attributes.params.stylesupport.metastyles.paddingbottom))#</cfif>">
												</label>
												<input type="hidden" name="paddingBottom" id="metapaddingbottomval" class="metaStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.metastyles.paddingbottom)#">
											</div>
											<div class="col-xs-3"></div>
										</div>
									</div>

								</div>

            <!--- /end panel contents --->
            </div> <!--- /.mura-panel-body --->
        </div> <!--- /.panel-collapse --->
    </div> <!--- /.mura-panel --->

		<!--- panel 3: layout --->
    <div class="panel mura-panel">
        <div class="mura-panel-heading panel-meta">
            <h4 class="mura-panel-title">
                <a class="collapse collapsed" data-toggle="collapse" data-parent="##panels-style-meta" href="##panel-style-meta-3">Text Color
                </a>
            </h4>
        </div> <!--- /.mura-panel-heading --->
        <div id="panel-style-meta-3" class="panel-collapse collapse">
            <div class="mura-panel-body">
            <!--- panel contents --->
							<!--- text color --->
							<div class="mura-control-group">
								<label><!--- ---></label>
								<div class="input-group mura-colorpicker">
									<span class="input-group-addon"><i class="mura-colorpicker-swatch"></i></span>
									<input type="text" id="metatextcolor" name="color" class="metaStyle" placeholder="Select Color" autocomplete="off" value="#esapiEncode('html_attr',attributes.params.stylesupport.metastyles.color)#">
								</div>
							</div>
            <!--- /end panel contents --->
            </div> <!--- /.mura-panel-body --->
        </div> <!--- /.panel-collapse --->
    </div> <!--- /.mura-panel --->

		<!--- panel 4: background --->
    <div class="panel mura-panel">
        <div class="mura-panel-heading panel-meta">
            <h4 class="mura-panel-title">
                <a class="collapse collapsed" data-toggle="collapse" data-parent="##panels-style-meta" href="##panel-style-meta-4">Background
                </a>
            </h4>
        </div> <!--- /.mura-panel-heading --->
        <div id="panel-style-meta-4" class="panel-collapse collapse">
            <div class="mura-panel-body">
            <!--- panel contents --->
							<!--- background --->
							<div class="mura-control-group">
								<label>Background Color</label>
								<div class="input-group mura-colorpicker" id="metabackgroundcustom">
									<span class="input-group-addon"><i class="mura-colorpicker-swatch"></i></span>
									<input type="text" id="metabackgroundcolor" name="backgroundColor" class="metaStyle"  placeholder="Select Color" autocomplete="off" value="#esapiEncode('html_attr',attributes.params.stylesupport.metastyles.backgroundcolor)#">
								</div>
							</div>

							<div class="mura-control-group">
								<label>Background Image</label>
								<input type="hidden" id="metabackgroundimage" name="backgroundImage" class="metaStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.metastyles.backgroundimage)#">
								<input type="text" id="metabackgroundimageurl" name="metabackgroundimageurl" placeholder="URL" class="styleSupport" value="#esapiEncode('html_attr',attributes.params.styleSupport.metabackgroundimageurl)#">
								
								<cfif len(request.assocatedImageURL)>
									<div class="btn-group btn-group-sm" role="group" aria-label="Select Image">		
										<button type="button" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
											<i class="mi-image"></i> Select Image <span class="caret"></span>
										</button>
										<ul class="dropdown-menu">
											<li><a class="mura-finder" data-target="metabackgroundimageurl" data-completepath="false" href="javascript:void(0);"><i class="mi-globe"></i> File Manager</a></li>
											<li><a id="metabackgroundassocurl" href="#request.assocatedImageURL#"> <i class="mi-th"></i> Associated Image</a></li>
										</ul>
										<script>
											$(function(){
												$('##metabackgroundassocurl').click(function(){
													$('##metabackgroundimageurl').val($(this).attr('href')).trigger('change');
													return false;
												})
											})
										</script>
									</div>
								<cfelse>
									<button type="button" class="btn mura-finder" data-target="metabackgroundimageurl" data-completepath="false"><i class="mi-image"></i> Select Image</button>
								</cfif>
							</div>

							<div class="mura-control-group mura-ui-grid meta-css-bg-option bg-position" style="display:none;">
								<label>Background Position</label>

								<div class="row mura-ui-row">
									<div class="col-xs-4"><label class="right ui-nested">Vertical</label></div>
									<div class="col-xs-8">
										<div class="mura-input-group">
											<label>
												<input type="text" id="metabackgroundpositionynum" name="metaBackgroundPositionyNum" class="numeric" placeholder="" value="<cfif val(esapiEncode('html_attr',attributes.params.stylesupport.metastyles.backgroundpositiony))>#val(esapiEncode('html_attr',attributes.params.stylesupport.metastyles.backgroundpositiony))#</cfif>" style="display: none;">
											</label>

											<select id="metabackgroundpositiony" name="metaBackgroundPositionY" class="styleSupport" data-numfield="metabackgroundpositionynum">
												<cfloop list="Top,Center,Bottom,%,px" index="p">
													<option value="#lcase(p)#"<cfif attributes.params.stylesupport.metastyles.backgroundpositiony contains p> selected</cfif>>#p#</option>
												</cfloop>
											</select>

											<input type="hidden" id="metabackgroundpositionyval" name="backgroundPositionY" class="metaStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.metastyles.backgroundpositiony)#">

										</div>
									</div>
								</div>

								<div class="row mura-ui-row">
									<div class="col-xs-4"><label class="right ui-nested">Horizontal</label></div>
									<div class="col-xs-8">
										<div class="mura-input-group">
											<label>
												<input type="text" id="metabackgroundpositionxnum" name="metaBackgroundPositionxNum" class="numeric" placeholder="" value="<cfif val(esapiEncode('html_attr',attributes.params.stylesupport.metastyles.backgroundpositionx))>#val(esapiEncode('html_attr',attributes.params.stylesupport.metastyles.backgroundpositionx))#</cfif>" style="display: none;">
											</label>

											<select id="metabackgroundpositionx" name="metaBackgroundPositionX" class="styleSupport" data-numfield="metabackgroundpositionxnum">
												<cfloop list="Left,Center,Right,%,px" index="p">
													<option value="#lcase(p)#"<cfif attributes.params.stylesupport.metastyles.backgroundpositionx contains p> selected</cfif>>#p#</option>
												</cfloop>
											</select>

											<input type="hidden" id="metabackgroundpositionxval" name="backgroundPositionX" class="metaStyle" value="#esapiEncode('html_attr',attributes.params.stylesupport.metastyles.backgroundpositionx)#">

										</div>
									</div>
								</div>
							</div>

							<div class="mura-control-group meta-css-bg-option" style="display:none;">
								<label>Background Repeat</label>
								<select id="metabackgroundrepeat" name="backgroundRepeat" class="metaStyle">
									<option value="no-repeat"<cfif attributes.params.stylesupport.metastyles.backgroundrepeat eq 'norepeat'> selected</cfif>>No-repeat</option>
									<option value="repeat"<cfif attributes.params.stylesupport.metastyles.backgroundrepeat eq 'repeat'> selected</cfif>>Repeat</option>
									<option value="repeat-x"<cfif attributes.params.stylesupport.metastyles.backgroundrepeat eq 'repeatx'> selected</cfif>>Repeat-X</option>
									<option value="repeat-y"<cfif attributes.params.stylesupport.metastyles.backgroundrepeat eq 'repeaty'> selected</cfif>>Repeat-Y</option>
								</select>
							</div>

							<div class="mura-control-group meta-css-bg-option" style="display:none;">
								<label>Background Size</label>
								<select id="metabackgroundsize" name="backgroundSize" class="metaStyle">
									<option value="auto"<cfif attributes.params.stylesupport.metastyles.backgroundsize eq 'auto'>
									selected</cfif>>Auto</option>
									<option value="contain"<cfif attributes.params.stylesupport.metastyles.backgroundsize eq 'contain'> selected</cfif>>Contain</option>
									<option value="cover"<cfif attributes.params.stylesupport.metastyles.backgroundsize eq 'cover'> selected</cfif>>Cover</option>
								</select>
							</div>

							<div class="mura-control-group meta-css-bg-option" style="display:none;">
								<label>Background Attachment</label>
								<select name="backgroundAttachment" class="metaStyle">
									<option value="scroll"<cfif attributes.params.stylesupport.metastyles.backgroundAttachment eq 'scroll'>
									selected</cfif>>Scroll</option>
									<option value="Fixed"<cfif attributes.params.stylesupport.metastyles.backgroundAttachment eq 'fixed'> selected</cfif>>Fixed</option>
								</select>
							</div>

            <!--- /end panel contents --->
            </div> <!--- /.mura-panel-body --->
        </div> <!--- /.panel-collapse --->
    </div> <!--- /.mura-panel --->

		<!--- panel 5: custom --->
    <div class="panel mura-panel">
        <div class="mura-panel-heading panel-meta">
            <h4 class="mura-panel-title">
                <a class="collapse collapsed" data-toggle="collapse" data-parent="##panels-style-meta" href="##panel-style-meta-5">Custom
                </a>
            </h4>
        </div> <!--- /.mura-panel-heading --->
        <div id="panel-style-meta-5" class="panel-collapse collapse">
            <div class="mura-panel-body">
            <!--- panel contents --->
							<div class="mura-control-group">
								<label>
								Z-Index
								</label>
								<input name="zIndex" class="metaStyle numeric" type="text" value="#esapiEncode('html_attr',attributes.params.stylesupport.metastyles.zindex)#" maxlength="5">
							</div>
							<div class="mura-control-group">
								<label>
									CSS ID
								</label>
								<input name="metacssid" class="objectParam" type="text" value="#esapiEncode('html_attr',attributes.params.metacssid)#" maxlength="255">
							</div>
							<div class="mura-control-group">
								<label>
									CSS Class
								</label>
								<input name="metacssclass" class="objectParam" type="text" value="#esapiEncode('html_attr',attributes.params.metacssclass)#" maxlength="255">
							</div>

            <!--- /end panel contents --->
            </div> <!--- /.mura-panel-body --->
        </div> <!--- /.panel-collapse --->
    </div> <!--- /.mura-panel --->

</div> <!--- /.mura-panel-group --->

</cfoutput>
