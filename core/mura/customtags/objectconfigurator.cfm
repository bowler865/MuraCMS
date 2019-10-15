<cfif thisTag.ExecutionMode eq 'start'>
	<cfsilent>
		<cfscript>
			if(server.coldfusion.productname != 'ColdFusion Server'){
				backportdir='';
				include "/mura/backport/backport.cfm";
			} else {
				backportdir='/mura/backport/';
				include "#backportdir#backport.cfm";
			}
		</cfscript>

		<cfset $=application.serviceFactory.getBean("muraScope").init(session.siteid)>

		<cfif not isdefined('attributes.params')>
			<cfif isDefined("form.params") and isJSON(form.params)>
				<cfset attributes.params=deserializeJSON(form.params)>
			<cfelse>
				<cfset attributes.params={}>
			</cfif>
		</cfif>

		<cfparam name="attributes.configurable" default="true">
	 	<cfparam name="attributes.basictab" default="true">
		<cfparam name="attributes.params.class" default="mura-twelve">
		<cfparam name="attributes.params.cssclass" default="">
		<cfparam name="attributes.params.metacssclass" default="">
		<cfparam name="attributes.params.metacssid" default="">
		<cfparam name="attributes.params.contentcssclass" default="">
		<cfparam name="attributes.params.contentcssid" default="">
		<cfparam name="attributes.params.cssid" default="">
		<cfparam name="attributes.params.hasTargetAttr" default="false">
		<cfparam name="attributes.params.label" default="">
		<cfparam name="attributes.params.labeltag" default="h2">
		<cfparam name="attributes.params.object" default="">

		<cfparam name="request.hasbasicoptions" default="false">
		<cfparam name="request.hasmetaoptions" default="false">
		<cfparam name="request.haspositionoptions" default="false">


		<cfscript>
		request.uomdefault = "%,px,rem,em";
		request.uomextdefault = "%,px,rem,em,vw,vh";
		request.preferreduom = "rem";
		param name="request.objectlayoutuom" default=$.globalConfig().getValue(property='objectlayoutuom',defaultValue=request.uomdefault);
		param name="request.objectlayoutuomext" default=$.globalConfig().getValue(property='objectlayoutuomext',defaultValue=request.uomextdefault);
		param name="request.preferreduom" default=$.globalConfig().getValue(property='preferreduom',defaultValue=request.preferreduom);

		u = request.objectlayoutuom.listToArray(',');
		v = request.uomdefault.listToArray(',');
		u.retainAll(v);
		if (arrayLen(v)){
			request.objectlayoutuom = u.toList(',');
		} else {
			request.objectlayoutuom = request.uomdefault;
		}

		u = request.objectlayoutuomext.listToArray(',');
		v = request.uomextdefault.listToArray(',');
		u.retainAll(v);
		if (arrayLen(v)){
			request.objectlayoutuomext = u.toList(',');
		} else {
			request.objectlayoutuomext = request.uomextdefault;
		}

		</cfscript>

		<cfscript>
			if(!isStruct(attributes.params)){
				attributes.params={};
			}
			param name="attributes.params.stylesupport" default={};
			if(!isStruct(attributes.params.stylesupport)){
				attributes.params.stylesupport={};
			}
			param name="attributes.params.stylesupport.css" default="";
			param name="attributes.params.stylesupport.objectbackgroundimageurl" default="";
			param name="attributes.params.stylesupport.objectbackgroundcolorsel" default="";
			param name="attributes.params.stylesupport.contentbackgroundimageurl" default="";
			param name="attributes.params.stylesupport.contentbackgroundimageurl" default="";
			param name="attributes.params.stylesupport.contentbackgroundcolorsel" default="";
			param name="attributes.params.stylesupport.metabackgroundimageurl" default="";
			param name="attributes.params.stylesupport.metabackgroundimageurl" default="";
			param name="attributes.params.stylesupport.metabackgroundcolorsel" default="";
			param name="attributes.params.stylesupport.metamarginuom" default="";
			param name="attributes.params.stylesupport.metapaddinguom" default="";
			param name="attributes.params.stylesupport.metabackgroundcolorsel" default="";
			param name="attributes.params.stylesupport.objectmarginuom" default="";
			param name="attributes.params.stylesupport.objectpaddinguom" default="";
			param name="attributes.params.stylesupport.objectminheightuom" default="";
			param name="attributes.params.stylesupport.metaminheightuom" default="";
			param name="attributes.params.stylesupport.contentminheightuom" default="";
			param name="attributes.params.stylesupport.contentmarginuom" default="";
			param name="attributes.params.stylesupport.contentpaddinguom" default="";
			param name="attributes.params.stylesupport.contentwidth" default="";
			param name="attributes.params.stylesupport.contentwidthuom" default="";
			param name="attributes.params.stylesupport.objectbackgroundpositionx" default="";
			param name="attributes.params.stylesupport.objectbackgroundpositiony" default="";
			param name="attributes.params.stylesupport.contentbackgroundpositionx" default="";
			param name="attributes.params.stylesupport.contentbackgroundpositiony" default="";
			param name="attributes.params.stylesupport.metabackgroundpositionx" default="";
			param name="attributes.params.stylesupport.metabackgroundpositiony" default="";
			
			$=request.$;

			request.assocatedImageURL=$.content().getImageURL(complete=$.siteConfig('isRemote'));

			attributes.globalparams = [
				'backgroundcolor'
				,'backgroundimage'
				,'backgroundoverlay'
				,'backgroundattachment'
				,'backgroundposition'
				,'backgroundpositionx'
				,'backgroundpositiony'
				,'backgroundrepeat'
				,'backgroundsize'
				,'backgroundvideo'
				,'color'
				,'float'
				,'margin'
				,'margintop'
				,'marginright'
				,'marginbottom'
				,'marginleft'
				,'marginall'
				,'marginuom'
				,'opacity'
				,'padding'
				,'paddingtop'
				,'paddingright'
				,'paddingbottom'
				,'paddingleft'
				,'paddingall'
				,'paddinguom'
				,'textalign'
				,'minheight'
				,'width'
				,'zindex'];

			for (p in attributes.globalparams){
				param name="attributes.params.stylesupport.objectstyles.#p#" default="";
				if(p == 'textalign'){
					param name="attributes.params.stylesupport.metastyles.#p#" default="center";
				} else {
					param name="attributes.params.stylesupport.metastyles.#p#" default="";
				}
				param name="attributes.params.stylesupport.contentstyles.#p#" default="";
			}
		</cfscript>

		<cfset request.colorOptions = $.getContentRenderer().getColorOptions()>
		<cfset request.modulethemeoptions = $.getContentRenderer().getModuleThemeOptions()>

		<cfset contentcontainerclass=esapiEncode("javascript",$.getContentRenderer().expandedContentContainerClass)>

		<cfif not (isDefined("attributes.params.stylesupport.objectstyles") and isStruct(attributes.params.stylesupport.objectstyles))>
			<cfif isDefined("attributes.params.stylesupport.objectstyles") and isJSON(attributes.params.stylesupport.objectstyles)>
				<cfset attributes.params.stylesupport.objectstyles=deserializeJSON(attributes.params.stylesupport.objectstyles)>
			<cfelse>
				<cfset attributes.params.stylesupport.objectstyles={}>
			</cfif>
		</cfif>

		<cfif not (isDefined("attributes.params.stylesupport.metastyles") and isStruct(attributes.params.stylesupport.metastyles))>
			<cfif isDefined("attributes.params.stylesupport.metastyles") and isJSON(attributes.params.stylesupport.metastyles)>
				<cfset attributes.params.stylesupport.metastyles=deserializeJSON(attributes.params.stylesupport.metastyles)>
			<cfelse>
				<cfset attributes.params.stylesupport.metastyles={}>
			</cfif>
		</cfif>
		<cfif not (isDefined("attributes.params.stylesupport.contentstyles") and isStruct(attributes.params.stylesupport.contentstyles))>
			<cfif isDefined("objectParams.contentcssstyles") and isJSON(attributes.params.stylesupport.contentstyles)>
				<cfset attributes.params.stylesupport.contentstyles=deserializeJSON(attributes.params.stylesupport.contentstyles)>
			<cfelse>
				<cfset attributes.params.stylesupport.contentstyles={}>
			</cfif>
		</cfif>

		<cfif not request.hasbasicoptions>
		<cfset request.hasbasicoptions=attributes.basictab>
		</cfif>

		<cfif not listFindNoCase('folder,gallery,calendar',attributes.params.object) and not (isBoolean(attributes.params.hasTargetAttr) and attributes.params.hasTargetAttr)>
			<cfset request.haspositionoptions = true>
		</cfif>

		<cfscript>
			attributes.positionoptions = [
					{value='mura-one', label='1/12',percent='8.33%', cols='1'}
					,{value='mura-two', label='1/6',percent='16.66%', cols='2'}
					,{value='mura-three', label='1/4',percent='25%', cols='3'}
					,{value='mura-four', label='1/3',percent='33.33%', cols='4'}
					,{value='mura-five', label='5/12',percent='41.66%', cols='5'}
					,{value='mura-six', label='1/2',percent='50%', cols='6'}
					,{value='mura-seven', label='7/12',percent='58.33%', cols='7'}
					,{value='mura-eight', label='2/3',percent='66.66%', cols='8'}
					,{value='mura-nine', label='3/4',percent='75%', cols='9'}
					,{value='mura-ten', label='5/6',percent='41.66%', cols='10'}
					,{value='mura-eleven', label='11/12',percent='91.66%', cols='11'}
					,{value='mura-twelve', label='100%',percent='100%', cols='12'}
					,{value='mura-expanded', label='Expanded',percent='100%'}
				];
		</cfscript>

	</cfsilent>

	<cfif $.getContentRenderer().useLayoutManager()>
		<cfoutput>
		<cfset request.muraconfiguratortag=true>
		<div id="availableObjectContainer"<cfif not attributes.configurable> style="display:none"</cfif>>
			<div class="mura-panel-group" id="configurator-panels" role="tablist" aria-multiselectable="true">
			<!--- Basic panel --->
			<cfif request.hasbasicoptions>
			<div class="mura-panel panel">
				<div class="mura-panel-heading" role="tab" id="heading-basic">
					<h4 class="mura-panel-title">
						<a class="collapse collapsed" role="button" data-toggle="collapse" data-parent="##configurator-panels" href="##panel-basic" aria-expanded="true" aria-controls="panel-basic">
							<i class="mi-sliders"></i>Settings <!--- #application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.basic')# --->
						</a>
					</h4>
				</div>
				<div id="panel-basic" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading-basic">
					<div class="mura-panel-body">
			</cfif>
		</cfoutput>
	</cfif>
<!--- /end start mode --->
<cfelseif thisTag.ExecutionMode eq 'end'>
	<cfset $=application.serviceFactory.getBean("muraScope").init(session.siteid)>

	<cfif $.getContentRenderer().useLayoutManager()>

	<cfoutput>

		<!--- close the basic or style panel --->
		<cfif request.hasbasicoptions or request.hasmetaoptions and not (IsBoolean(attributes.params.hasTargetAttr) and attributes.params.hasTargetAttr)>
				</div> <!--- /end  mura-panel-collapse --->
			</div> <!--- /end  mura-panel-body --->
		</div> <!--- /end panel --->
		</cfif>
	
		<style>
			.btn-group, .btn-group button, .btn-group ul {
				background-color:##333;
				color:##f3f3f3;
			}

			.btn-group button {
				border-radius: 2px;
				background-image: none;
				text-shadow: none;
				color: ##f3f3f3;
				background-color: ##333;
				border-color: transparent;
				border-radius: 2px;
				font-size: 13px;
    			padding: 3px 12px 3px;
				font-family: "Inter UI","Helvetica Neue",Helvetica,Arial,sans-serif;
    			font-weight: 400;
			}

			.btn-group li, .btn-group li:hover {
				border-radius: 2px !important;
				background-image: none !important;
				text-shadow: none !important;
				background-color: ##333 !important;
				font-size: 13px !important;
    			padding: 3px 12px 3px!important;
				font-family: "Inter UI","Helvetica Neue",Helvetica,Arial,sans-serif;
    			
			}

			.btn-group a, .btn-group a:active{
				background-color: ##333 !important;
				font-weight: 400 !important;
				font-size: 13px !important;
    			padding: 0px 0px !important;
    			padding-left: 0px !important;
			}

			.btn-group a:active, .btn-group a:hover { 
				color: ##f3f3f3 !important;
			}
		</style>
	
		<!--- style --->
		<div class="mura-panel panel">
			<div class="mura-panel-heading" role="tab" id="heading-style">
				<h4 class="mura-panel-title">
					<!--- todo: rbkey for style --->
					<a class="collapse collapsed" role="button" data-toggle="collapse" data-parent="##configurator-panels" href="##panel-style" aria-expanded="false" aria-controls="panel-style">
						<i class="mi-tint"></i>Style
					</a>
				</h4>
			</div>
			<div id="panel-style" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading-style">
				<div class="mura-panel-body">
					<div class="container">
						<!--- nested panels --->

					<!--- todo: rbkeys for box labels --->
					<cfoutput>
						<div class="panel-gds-box active" id="panel-gds-object" data-gdsel="panel-style-object"><span>Module</span> .mura-object
							<cfif request.hasmetaoptions>
								<div class="panel-gds-box" id="panel-gds-meta" data-gdsel="panel-style-label"<cfif not len(attributes.params.label)> style="display:none"</cfif>><span>Heading</span>  .mura-object-meta</div>
							</cfif>
							<div class="panel-gds-box" id="panel-gds-content" data-gdsel="panel-style-content"><span>Content</span> .mura-object-content</div>
						</div>
					</cfoutput>

					<div class="mura-panel-group" id="style-panels" role="tablist" aria-multiselectable="true">

						<!--- object/module style panel--->
						<div class="mura-panel panel">
							<div class="mura-panel-heading" role="tab" id="heading-style-object">
								<h4 class="mura-panel-title">
									<a class="collapse collapsed" role="button" data-toggle="collapse" data-parent="##configurator-panels" href="##panel-style-object" aria-expanded="false" aria-controls="panel-style-object">
										Module
									</a>
								</h4>
							</div>
							<div id="panel-style-object" class="panel-collapse collapse" role="tabpanel" aria-labeledby="heading-style-object">
								<div class="mura-panel-body">
									<div class="container">
										<cfinclude template="objectconfigpanels/objectconfigpanelstylemodule.cfm">
									</div> <!--- /end container --->
								</div> <!--- /end mura-panel-body --->
							</div> <!--- /end panel-collapse --->
						</div> <!--- /end object panel --->

					<!--- meta/label style panel --->
					<cfif request.hasmetaoptions and not (IsBoolean(attributes.params.hasTargetAttr) and attributes.params.hasTargetAttr)>
						<!--- label --->
						<div class="mura-panel panel">
							<div class="mura-panel-heading" role="tab" id="heading-style-label">
								<h4 class="mura-panel-title">
									<a class="collapse collapsed" role="button" data-toggle="collapse" data-parent="##configurator-panels" href="##panel-style-label" aria-expanded="false" aria-controls="panel-style-label">
										Label
									</a>
								</h4>
							</div>
							<div id="panel-style-label" class="panel-collapse collapse" role="tabpanel" aria-labeledby="heading-style-label">
								<div class="mura-panel-body">
									<div class="container" id="labelContainer">
										<cfinclude template="objectconfigpanels/objectconfigpanelstyleheading.cfm">
									</div> <!--- /end container --->
								</div> <!--- /end mura-panel-body --->
							</div> <!--- /end panel-collapse --->
						</div> <!--- /end label panel --->
					</cfif>

					<!--- content style panel --->
						<div class="mura-panel panel">
							<div class="mura-panel-heading" role="tab" id="heading-style-content">
								<h4 class="mura-panel-title">
									<a class="collapse collapsed" role="button" data-toggle="collapse" data-parent="##configurator-panels" href="##panel-style-content" aria-expanded="false" aria-controls="panel-style-content">
										Content
									</a>
								</h4>
							</div>
							<div id="panel-style-content" class="panel-collapse collapse" role="tabpanel" aria-labeledby="heading-style-content">
								<div class="mura-panel-body">
									<div class="container">
										<cfinclude template="objectconfigpanels/objectconfigpanelstylecontent.cfm">
									</div> <!--- /end container --->
								</div> <!--- /end mura-panel-body --->
							</div> <!--- /end panel-collapse --->
						</div> <!--- /end content panel --->

						<cfoutput>
						<div>
							<input name="class" type="hidden" class="objectParam" value="#esapiEncode('html_attr',attributes.params.class)#"/>
							<input class="styleSupport" name="css" id="csscustom" type="hidden" value="#esapiEncode('html_attr',attributes.params.stylesupport.css)#"/>
						</div>
						</cfoutput>

					</div> <!--- /end panel group --->

					</div> <!--- /end container --->
				</div> <!--- /end  mura-panel-body --->
			</div> <!--- /end  mura-panel-collapse --->
		</div> <!--- /end style panel --->
	</div><!--- /end panels --->
	</cfoutput>
</div> <!--- /end availableObjectContainer --->

	<script>
		$(function(){

			currentPanel="";
			re="[^0-9\\-\\.]";
			numRE = new RegExp(re,"g")
			window.configuratorInited=false;

			$('#panel-gds-object,.mura-panel-heading').click(function(){
				if(!$(this).is('.panel-content, .panel-meta')){
					currentPanel="";
					frontEndProxy.post(
					{
						cmd:'setCurrentPanel',
						instanceid:instanceid,
						currentPanel:currentPanel
					});
				}
			});

			$('#panel-gds-content, .panel-content').click(function(){
				currentPanel="content";
				frontEndProxy.post(
				{
					cmd:'setCurrentPanel',
					instanceid:instanceid,
					currentPanel:currentPanel
				});
			});

			$('#panel-gds-meta,.panel-meta').click(function(){
				currentPanel="meta";
				frontEndProxy.post(
				{
					cmd:'setCurrentPanel',
					instanceid:instanceid,
					currentPanel:currentPanel
				});
			});

			$('.mura-panel-heading, .panel-gds-box').on('click',function(){
				setConfigPanelStates();
			})

			$('.panel-gds-box').on('click',function(){
				var gdspanel = $(this).attr('data-gdsel');
				var gdstarget = $('#' + gdspanel);
				$('.panel-gds-box').removeClass('active');
				$(this).addClass('active');
				$('#style-panels > .mura-panel > .panel-collapse.in').removeClass('in');
				$(gdstarget).addClass('in');
				return false;
			})

			$('#object-widthsel-ui .object-widthsel-option').hover(
				function(){
					previewGridWidth($(this));
				}, 
				function(){
					resetGridWidth();
				}
			)
			
			$('#object-widthsel-ui .object-widthsel-option').on('click',function(){
				setGridWidth($(this));
				setGridIndicators($(this));
				$(this).addClass('selected').siblings().removeClass('selected');
				selectGridWidth($(this));
			})

			function unsetGridWidth(){
				$('#object-widthsel-ui .object-widthsel-option').removeClass('set');
			}	
			function resetGridWidth(){
				$('#object-widthsel-ui .object-widthsel-option').removeClass('active');
			}

			function selectGridWidth(activeOption){
				var optionValue = $(activeOption).attr('data-value');
				if (optionValue == 'mura-twelve' && $('#expandedwidthtoggle').is(':checked')){
					optionValue = 'mura-expanded';
				} else if (optionValue == 'mura-expanded' && !($('#expandedwidthtoggle').is(':checked'))){
					optionValue = 'mura-twelve';
				}

				$('#objectwidthsel').val(optionValue).trigger('change').niceSelect('update');
			}

			function setGridWidth(activeOption){
				$(activeOption).siblings('.object-widthsel-option').removeClass('set');
				$(activeOption).addClass('set').prevAll('.object-widthsel-option').addClass('set');
			}

			function previewGridWidth(activeOption){
				$(activeOption).siblings('.object-widthsel-option').removeClass('active');
				$(activeOption).addClass('active').prevAll('.object-widthsel-option').addClass('active');
			}

			function setGridIndicators(activeOption){
				var optionValue = $(activeOption).attr('data-value');
				var markers = '';

				if (optionValue == 'mura-two' || optionValue == 'mura-ten'){
					markers = ['2','4','6','8','10'];
				} else if (optionValue == 'mura-three' || optionValue == 'mura-six' || optionValue == 'mura-nine'){
					markers = ['3','6','9'];
				} else if (optionValue == 'mura-four' || optionValue == 'mura-eight'){
					markers = ['4','8'];
				} else {
					markers = ['1','2','3','4','5','6','7','8','9','10','11'];
				} 

				$('#object-widthsel-wrapper .indicator').removeClass('indicator');

				for (m in markers){
					$('#object-widthsel-wrapper > .object-widthsel-option:nth-child(' + markers[m] + ')').addClass('indicator');
				}
			}

			function setActiveGDSpanel(){
				var visiblekids = $('#style-panels > .mura-panel > .panel-collapse.in');
				if (!visiblekids.length){
					$('#panel-gds-object').trigger('click');
				} else {
					$('.panel-gds-box[data-gdsel="' + visiblekids[0].id + '"]').trigger('click');
				}
			}

			// set panel state cookie
			function setConfigPanelStates(){
				var savedStates = JSON.parse(getConfigPanelStates());
				var newStates = [];

				for (i in savedStates){
					if (newStates.length <= 10){
						var item = savedStates[i];
						if (item[0] != instanceid){
							newStates.push(item);
						}
					}
				}

				setTimeout(function(){
				 	var openPanels = $('#configurator-panels').find('.panel-collapse.in').map(function(){
				 			return this.id;
				 	}).get();
				 	var thisArr = [instanceid,openPanels];
				 	newStates.unshift(thisArr);
				 	var str = JSON.stringify(newStates);
				 	Mura.createCookie('mura_configpanelstate',encodeURIComponent(str));

				},500);
			}

			// get panel state cookie
			function getConfigPanelStates(){
					var cps = Mura.readCookie('mura_configpanelstate');
					if (cps == ''){
						return JSON.stringify([]);
					} else {
						return cps;
					}
			}

			// apply open panels
			function applyConfigPanelStates(){
					var cps = JSON.parse(getConfigPanelStates());

					for (i in cps){
						var savedinstanceid = cps[i][0];
						var panelarr = cps[i][1];
						if (panelarr.length && savedinstanceid == instanceid){
							$('#configurator-panels').find('.panel-collapse.in').removeClass('in');
							$('#configurator-panels').find('.mura-panel-title a.collapse').addClass('collapsed');
							for (i in panelarr){
								$('#'+ panelarr[i]).addClass('in').siblings('.mura-panel-heading').find('a.collapse').removeClass('collapsed');
							}
						}
					}
			}

			// run on load
			$('#style-panels').addClass('no-header');
			$('#panel-style-object').addClass('in');
			applyConfigPanelStates();
			setActiveGDSpanel();

			$('#labelText').change(function(item){
				if(Mura.trim(Mura(this).val())){
					Mura('#panel-gds-meta').show();
				} else {
					Mura('#panel-gds-meta').hide();
					$('#panel-style-label').removeClass('in');
					$('#panel-style-object').addClass('in');
					$('#panel-gds-object').addClass('active');
				}
			});

			<cfif len(contentcontainerclass) 
				and listFind(attributes.params.contentcssclass,contentcontainerclass,' ')
				and listFind(attributes.params.class,'mura-expanded',' ')>
				var hasExpandedContainerClass=true;
			<cfelse>
				var hasExpandedContainerClass=false;
			</cfif>

			function updateDynamicClasses(){
				var classInput=$('input[name="class"]');
				classInput.val('');

				$('.classtoggle,.classToggle').each(function(){
					var input=$(this);
					if(classInput.val() ){
						classInput.val(classInput.val() + ' ' + input.val());
					} else {
						classInput.val(input.val());
					}
				})

				classInput.val($.trim(classInput.val()));
			
				var contentcssclass=$('input[name="contentcssclass"]');
				var expandedContentContainerClass='<cfoutput>#contentcontainerclass#</cfoutput>';
				var contentcssclassArray=[];
				if(typeof contentcssclass.val() =='string'){
					contentcssclassArray=contentcssclass.val().split(' ');
				}
				var constraincontent=$('select[name="constraincontent"]');
				var currentwidth = $('select[name="width"].classtoggle').val();

				if(expandedContentContainerClass && constraincontent.length){

					// if selecting expanded class
					if(currentwidth == 'mura-expanded' || currentwidth == 'mura-twelve'){
						$('.constraincontentcontainer').show();

						// if constraining content
						if(constraincontent.val()=='constrain'){
							// if expanded class not present yet
							if(contentcssclassArray.indexOf(expandedContentContainerClass)==-1){
								// apply container class
								if(contentcssclassArray.length){
									contentcssclass.val(contentcssclass.val() + ' ' + expandedContentContainerClass);
								} else {
									contentcssclass.val(expandedContentContainerClass);
								}
							}
							hasExpandedContainerClass=true;
						
						// if not constraining
						} else {
							if(contentcssclassArray.indexOf(expandedContentContainerClass) > -1){
								for( var i = 0; i < contentcssclassArray.length; i++){
									if ( contentcssclassArray[i] === expandedContentContainerClass) {
										contentcssclassArray.splice(i, 1);
									}
								}
							}
							contentcssclass.val(contentcssclassArray.join(' '));
							hasExpandedContainerClass=false;
						} // end if constraining

					} else if (hasExpandedContainerClass){
						$('.constraincontentcontainer').hide();
						if(contentcssclassArray.indexOf(expandedContentContainerClass) > -1){
							for( var i = 0; i < contentcssclassArray.length; i++){
								if ( contentcssclassArray[i] === expandedContentContainerClass) {
									contentcssclassArray.splice(i, 1);
								}
							}
						}
						contentcssclass.val(contentcssclassArray.join(' '));
						hasExpandedContainerClass=false;
					} else {
						$('.constraincontentcontainer').hide();
					}

					contentcssclass.val($.trim(contentcssclass.val()));
				}
				if(typeof updateDraft == 'function'){
					updateDraft();
				}
			}

			updateDynamicClasses();

			$('#globalSettingsBtn').click(function(){
				$('#availableObjectContainer').hide();
				$('#objectSettingsBtn').show();
				$('#globalObjectParams').fadeIn();
				$('#globalSettingsBtn').hide();
			});

			$('#objectSettingsBtn').click(function(){
				$('#availableObjectContainer').fadeIn();
				$('#objectSettingsBtn').hide();
				$('#globalObjectParams').hide();
				$('#globalSettingsBtn').show();
			});

			$('.mura-ui-link').on('click',function(){
				var targetEl = $(this).attr('data-reveal');
				if (targetEl.length > 0){
					$('#' + targetEl).toggle();
				}
				return false;
			})

			$('.classtoggle,.classToggle').on('change', function() {
				updateDynamicClasses();
			});

			// Begin Object Margin and Padding
			function updateObjectPadding(){
				var t = $('#objectpaddingtop').val().replace(numRE,'');
				var r = $('#objectpaddingright').val().replace(numRE,'');
				var b = $('#objectpaddingbottom').val().replace(numRE,'');
				var l =$('#objectpaddingleft').val().replace(numRE,'');
				var u = $('#objectpaddinguom').val();
				if (t.length){ $('#objectpaddingtopval').val(t + u); } else { $('#objectpaddingtopval').val(''); }
				if (r.length){ $('#objectpaddingrightval').val(r + u); } else { $('#objectpaddingrightval').val(''); }
				if (b.length){ $('#objectpaddingbottomval').val(b + u); } else { $('#objectpaddingbottomval').val(''); }
				if (l.length){ $('#objectpaddingleftval').val(l + u); } else { $('#objectpaddingleftval').val(''); }
				if (t == r && r == b && b == l){
					$('#objectpaddingall').val(t);
				} else {
					$('#objectpaddingall').val('');
					$('#objectpaddingadvanced').show();
				}
				$('#objectpaddingtopval').trigger('change');
			}

			$('#objectpaddingall').on('keyup', function(){
				var v = $('#objectpaddingall').val().replace(numRE,'');
				$('#objectpaddingadvanced').hide();
				$('#objectpaddingtop').val(v);
				$('#objectpaddingleft').val(v);
				$('#objectpaddingright').val(v);
				$('#objectpaddingbottom').val(v);
			})

			$('#objectpaddingtop,#objectpaddingright,#objectpaddingbottom,#objectpaddingleft,#objectpaddingall').on('keyup', function(){
				updateObjectPadding();
			})

			$('#objectpaddinguom').on('change',function(){
				updateObjectPadding();
			});

			updateObjectPadding();

			// margin
			function updateObjectMargin(){
				var t = $('#objectmargintop').val().replace(numRE,'');
				var r = $('#objectmarginright').val();
				if(r != 'auto'){r=r.replace(numRE,'')}
				var b = $('#objectmarginbottom').val().replace(numRE,'');
				var l =$('#objectmarginleft').val();
				if(l != 'auto'){l=l.replace(numRE,'')}
				var u = $('#objectmarginuom').val();
				if (t.length){ $('#objectmargintopval').val(t + u); } else { $('#objectmargintopval').val(''); }
				if(r=='auto'){
					$('#objectmarginrightval').val(r);
				} else {
					if (r.length){ $('#objectmarginrightval').val(r + u); } else { $('#objectmarginrightval').val(''); }
				}
				if (b.length){ $('#objectmarginbottomval').val(b + u); } else { $('#objectmarginbottomval').val(''); }
				if(l=='auto'){
					$('#objectmarginleftval').val(r);
				} else {
					if (l.length){ $('#objectmarginleftval').val(l + u); } else { $('#objectmarginleftval').val(''); }
				}
				if (t == r && r == b && b == l){
					$('#objectmarginall').val(t);
				} else {
					$('#objectmarginall').val('');
					$('#objectmarginadvanced').show();
				}
				$('#objectmargintopval').trigger('change');
			}

			$('#objectmarginall').on('keyup', function(){
				var v = $('#objectmarginall').val().replace(numRE,'');
				$('#objectmarginadvanced').hide();
				$('#objectmargintop').val(v);
				$('#objectmarginleft').val(v);
				$('#objectmarginright').val(v);
				$('#objectmarginbottom').val(v);
			})

			$('a.input-auto').on('click',function(){
				var ai = '#' + $(this).attr('data-auto-input');
				$(ai).val('auto').trigger('keyup');
				return false;
			})

			$('#objectmargintop,#objectmarginright,#objectmarginbottom,#objectmarginleft,#objectmarginall').on('keyup', function(){
				var val=$(this).val();
				if(!(val=='a' || val=='au' || val=='aut')){
					updateObjectMargin();
				}
			});

			$('#objectmarginuom').on('change',function(){
				updateObjectMargin();
			});

			updateObjectMargin();
			//End Object Margin and Padding

			// Begin Meta Margin and Padding
			<cfif request.hasmetaoptions and not (IsBoolean(attributes.params.hasTargetAttr) and attributes.params.hasTargetAttr)>
			function updateMetaPadding(){
				var t = $('#metapaddingtop').val().replace(numRE,'');
				var r = $('#metapaddingright').val().replace(numRE,'');
				var b = $('#metapaddingbottom').val().replace(numRE,'');
				var l =$('#metapaddingleft').val().replace(numRE,'');
				var u = $('#metapaddinguom').val();
				if (t.length){ $('#metapaddingtopval').val(t + u); } else { $('#metapaddingtopval').val(''); }
				if (r.length){ $('#metapaddingrightval').val(r + u); } else { $('#metapaddingrightval').val(''); }
				if (b.length){ $('#metapaddingbottomval').val(b + u); } else { $('#metapaddingbottomval').val(''); }
				if (l.length){ $('#metapaddingleftval').val(l + u); } else { $('#metapaddingleftval').val(''); }
				if (t == r && r == b && b == l){
					$('#metapaddingall').val(t);
				} else {
					$('#metapaddingall').val('');
					$('#metapaddingadvanced').show();
				}
				$('#metapaddingtopval').trigger('change');
			}

			$('#metapaddingall').on('keyup', function(){
				var v = $('#metapaddingall').val().replace(numRE,'');
				$('#metapaddingadvanced').hide();
				$('#metapaddingtop').val(v);
				$('#metapaddingleft').val(v);
				$('#metapaddingright').val(v);
				$('#metapaddingbottom').val(v);
			})

			$('#metapaddingtop,#metapaddingright,#metapaddingbottom,#metapaddingleft,#metapaddingall').on('keyup', function(){
				updateMetaPadding();
			})

			$('#metapaddinguom').on('change',function(){
				updateMetaPadding();
			});

			updateMetaPadding();

			// margin
			function updateMetaMargin(){
				var t = $('#metamargintop').val().replace(numRE,'');
				var r = $('#metamarginright').val();
				if(r != 'auto'){r=r.replace(numRE,'')}
				var b = $('#metamarginbottom').val().replace(numRE,'');
				var l =$('#metamarginleft').val();
				if(l != 'auto'){l=l.replace(numRE,'')}
				var u = $('#metamarginuom').val();
				if (t.length){ $('#metamargintopval').val(t + u); } else { $('#metamargintopval').val(''); }
				if(r=='auto'){
					$('#metamarginrightval').val(r);
				} else {
					if (r.length){ $('#metamarginrightval').val(r + u); } else { $('#metamarginrightval').val(''); }
				}
				if (b.length){ $('#metamarginbottomval').val(b + u); } else { $('#metamarginbottomval').val(''); }
				if(l=='auto'){
					$('#metamarginleftval').val(r);
				} else {
					if (l.length){ $('#metamarginleftval').val(l + u); } else { $('#metamarginleftval').val(''); }
				}
				if (t == r && r == b && b == l){
					$('#metamarginall').val(t);
				} else {
					$('#metamarginall').val('');
					$('#metamarginadvanced').show();
				}
				$('#metamargintopval').trigger('change');
			}

			$('#metamarginall').on('keyup', function(){
				var v = $('#metamarginall').val().replace(numRE,'');
				$('#metamarginadvanced').hide();
				$('#metamargintop').val(v);
				$('#metamarginleft').val(v);
				$('#metamarginright').val(v);
				$('#metamarginbottom').val(v);
			})

			$('#metamargintop,#metamarginright,#metamarginbottom,#metamarginleft,#metamarginall').on('keyup', function(){
				var val=$(this).val();
				if(!(val=='a' || val=='au' || val=='aut')){
					updateMetaMargin();
				}
			});

			$('#metamarginuom').on('change',function(){
				updateMetaMargin();
			});

			updateMetaMargin();
			</cfif>
			// End Meta Margin and Padding

			// Begin Content Content Margin and Padding
			function updateContentPadding(){
				var t = $('#contentpaddingtop').val().replace(numRE,'');
				var r = $('#contentpaddingright').val().replace(numRE,'');
				var b = $('#contentpaddingbottom').val().replace(numRE,'');
				var l =$('#contentpaddingleft').val().replace(numRE,'');
				var u = $('#contentpaddinguom').val();
				if (t.length){ $('#contentpaddingtopval').val(t + u); } else { $('#contentpaddingtopval').val(''); }
				if (r.length){ $('#contentpaddingrightval').val(r + u); } else { $('#contentpaddingrightval').val(''); }
				if (b.length){ $('#contentpaddingbottomval').val(b + u); } else { $('#contentpaddingbottomval').val(''); }
				if (l.length){ $('#contentpaddingleftval').val(l + u); } else { $('#contentpaddingleftval').val(''); }
				if (t == r && r == b && b == l){
					$('#contentpaddingall').val(t);
				} else {
					$('#contentpaddingall').val('');
					$('#contentpaddingadvanced').show();
				}
				$('#contentpaddingtopval').trigger('change');
			}

			$('#contentpaddingall').on('keyup', function(){
				var v = $('#contentpaddingall').val().replace(numRE,'');
				$('#contentpaddingadvanced').hide();
				$('#contentpaddingtop').val(v);
				$('#contentpaddingleft').val(v);
				$('#contentpaddingright').val(v);
				$('#contentpaddingbottom').val(v);
			})

			$('#contentpaddingtop,#contentpaddingright,#contentpaddingbottom,#contentpaddingleft,#contentpaddingall').on('keyup', function(){
				updateContentPadding();
			})

			$('#contentpaddinguom').on('change',function(){
				updateContentPadding();
			});

			updateContentPadding();

 			// margin
			function updateContentMargin(){
				var t = $('#contentmargintop').val().replace(numRE,'');
				var r = $('#contentmarginright').val();
				if(r != 'auto'){r=r.replace(numRE,'')}
				var b = $('#contentmarginbottom').val().replace(numRE,'');
				var l =$('#contentmarginleft').val();
				if(l != 'auto'){l=l.replace(numRE,'')}
				var u = $('#contentmarginuom').val();
				if (t.length){ $('#contentmargintopval').val(t + u); } else { $('#contentmargintopval').val(''); }
				if(r=='auto'){
					$('#contentmarginrightval').val(r);
				} else {
					if (r.length){ $('#contentmarginrightval').val(r + u); } else { $('#contentmarginrightval').val(''); }
				}
				if (b.length){ $('#contentmarginbottomval').val(b + u); } else { $('#contentmarginbottomval').val(''); }
				if(l=='auto'){
					$('#contentmarginleftval').val(r);
				} else {
					if (l.length){ $('#contentmarginleftval').val(l + u); } else { $('#contentmarginleftval').val(''); }
				}
				if (t == r && r == b && b == l){
					$('#contentmarginall').val(t);
				} else {
					$('#contentmarginall').val('');
					$('#contentmarginadvanced').show();
				}
				$('#contentmargintopval').trigger('change');
			}

			$('#contentmarginall').on('keyup', function(){
				var v = $('#contentmarginall').val().replace(numRE,'');
				$('#contentmarginadvanced').hide();
				$('#contentmargintop').val(v);
				$('#contentmarginleft').val(v);
				$('#contentmarginright').val(v);
				$('#contentmarginbottom').val(v);
			})

			$('#contentmargintop,#contentmarginright,#contentmarginbottom,#contentmarginleft,#contentmarginall').on('keyup', function(){
				updateContentMargin();
			});

			$('#contentmarginuom').on('change',function(){
				var val=$(this).val();
				if(!(val=='a' || val=='au' || val=='aut')){
					updateContentMargin();
				}
			});

			updateContentMargin();
			// End Content Content Margin and Padding

			// Begin Object background
			$('#objectminheightnum,#objectminheightoum').on('change',function(){
				var el = $('#objectminheightuomval');
				var str = $('#objectminheightuom').val();
				var num = $('#objectminheightnum').val();
				if (num.length > 0){
					str = num + str;
				}
				$(el).val(str).trigger('change');
			});

			$('#contentminheightnum,#contentminheightoum').on('change',function(){
				var el = $('#contentminheightuomval');
				var str = $('#contentminheightuom').val();
				var num = $('#contentminheightnum').val();
				if (num.length > 0){
					str = num + str;
				}
				$(el).val(str).trigger('change');
			});

			// background position x/y
			function updatePositionSelection(sel){
				var v = $(sel).val();
				var el = $(sel).attr('data-numfield');
				if (v == 'px' || v == '%' || v == 'vh' || v == 'vw'){
					$('#' + el).show();
				} else {
					$('#' + el).hide();
				}
			}

			// background image
			$('#objectbackgroundimageurl').on('change',function(){
				var v = $(this).val();
				var str = "";
				if (typeof v !='undefined' && v.length > 3){
					str = "url('" + v + "')";
					$('.object-css-bg-option').show();
				} else {
					$('.object-css-bg-option').hide();
				}
				$('#objectbackgroundimage').val(str).trigger('change');
			});

			var v = $('#objectbackgroundimageurl').val();
			var str = "";
			if (typeof v !='undefined' && v.length > 3){
				str = "url('" + v + "')";
				$('.object-css-bg-option').show();
			} else {
				$('.object-css-bg-option').hide();
			}

			//$('#objectbackgroundimageurl').trigger('change');

			$('#objectbackgroundpositiony,#objectbackgroundpositionynum').on('change',function(){
				var el = $('#objectbackgroundpositionyval');
				var str = $('#objectbackgroundpositiony').val();
				var num = $('#objectbackgroundpositionynum').val();
				if (num.length > 0){
					str = num + str;
				}
				$(el).val(str).trigger('change');
			});

			$('#objectbackgroundpositionx,#objectbackgroundpositionxnum').on('change',function(){
				var el = $('#objectbackgroundpositionxval');
				var str = $('#objectbackgroundpositionx').val();
				var num = $('#objectbackgroundpositionxnum').val();
				if (num.length > 0){
					str = num + str;
				}
				$(el).val(str).trigger('change');
			});

			$('#objectbackgroundpositionx,#objectbackgroundpositiony').on('change',function(){
				updatePositionSelection($(this));
			});

			$('#objectbackgroundpositionx,#objectbackgroundpositiony').each(function(){
				updatePositionSelection($(this));
			});
			//End Object Background

			// background image
			$('#metabackgroundimageurl').on('change',function(){
				var v = $(this).val();
				var str = "";
				if (typeof v != 'undefined' && v.length > 3){
					str = "url('" + v + "')";
					$('.meta-css-bg-option').show();
				} else {
					$('.meta-css-bg-option').hide();
				}
				$('#metabackgroundimage').val(str).trigger('change');
			});

			var v = $('#metabackgroundimageurl').val();
			var str = "";
			if (typeof v != 'undefined' && v.length > 3){
				str = "url('" + v + "')";
				$('.meta-css-bg-option').show();
			} else {
				$('.meta-css-bg-option').hide();
			}

			$('#metabackgroundpositiony,#metabackgroundpositionynum').on('change',function(){
				var el = $('#metabackgroundpositionyval');
				var str = $('#metabackgroundpositiony').val();
				var num = $('#metabackgroundpositionynum').val();
				if (num.length > 0){
					str = num + str;
				}
				$(el).val(str).trigger('change');
			});

			$('#metabackgroundpositionx,#metabackgroundpositionxnum').on('change',function(){
				var el = $('#metabackgroundpositionxval');
				var str = $('#metabackgroundpositionx').val();
				var num = $('#metabackgroundpositionxnum').val();
				if (num.length > 0){
					str = num + str;
				}
				$(el).val(str).trigger('change');
			});

			$('#metabackgroundpositionx,#metabackgroundpositiony').on('change',function(){
				updatePositionSelection($(this));
			});

			$('#metabackgroundpositionx,#metabackgroundpositiony').each(function(){
				updatePositionSelection($(this));
			});
			//End Meta Background

			// background image
			$('#contentbackgroundimageurl').on('change',function(){
				var v = $(this).val();
				var str = "";
				if (typeof v !='undefined' && v.length > 3){
					str = "url('" + v + "')";
					$('.content-css-bg-option').show();
				} else {
					$('.content-css-bg-option').hide();
				}
				$('#contentbackgroundimage').val(str).trigger('change');
			});

			var v = $('#contentbackgroundimageurl').val();
			var str = "";
			if (typeof v !='undefined' && v.length > 3){
				str = "url('" + v + "')";
				$('.content-css-bg-option').show();
			} else {
				$('.content-css-bg-option').hide();
			}

			$('#contentbackgroundpositiony,#contentbackgroundpositionynum').on('change',function(){
				var el = $('#contentbackgroundpositionyval');
				var str = $('#contentbackgroundpositiony').val();
				var num = $('#contentbackgroundpositionynum').val();
				if (num.length > 0){
					str = num + str;
				}
				$(el).val(str).trigger('change');
			});

			$('#contentbackgroundpositionx,#contentbackgroundpositionxnum').on('change',function(){
				var el = $('#contentbackgroundpositionxval');
				var str = $('#contentbackgroundpositionx').val();
				var num = $('#contentbackgroundpositionxnum').val();
				if (num.length > 0){
					str = num + str;
				}
				$(el).val(str).trigger('change');
			});

			$('#contentbackgroundpositionx,#contentbackgroundpositiony').on('change',function(){
				updatePositionSelection($(this));
			});

			$('#contentbackgroundpositionx,#contentbackgroundpositiony').each(function(){
				updatePositionSelection($(this));
			});
			//End Object Background

			$('#contentwidthnum,#contentwidthuom').on('change',function(){
				var el = $('#contentwidthuomval');
				var str = $('#contentwidthuom').val();
				var num = $('#contentwidthnum').val();
				if (Mura.isNumeric(num)){
					str = num + str;
				} else {
					str='';
				}
				$(el).val(str).trigger('change');
			});


			// update width UI controls 
			function updateObjectWidthSelection(){
				var curVal = $('#objectwidthsel').val();
				var	curOption = $('#object-widthsel-ui .object-widthsel-option[data-value="' + curVal + '"]');
				var defaultOption = $('#object-widthsel-ui .object-widthsel-option[data-value="mura-twelve"]');
				var bpSel =	$('#objectbreakpointsel');
				var bpDiv = $('div.objectbreakpointcontainer');

				if (curVal == ''){
					$(bpSel).val('').niceSelect('update');
					$(bpDiv).hide();
					resetGridWidth();
					unsetGridWidth();
				} else {
					if (curVal == 'mura-twelve' || curVal == 'mura-expanded'){
						$(bpDiv).hide();
					} else {
						$(bpDiv).show();					
					}
				}
				if (curOption.length){
					setGridWidth(curOption);
					setGridIndicators(curOption);					
				} else {
					setGridWidth(defaultOption);
					setGridIndicators(defaultOption);					
				}
			}
			// run on change of hidden dropdown
			$('#objectwidthsel').on('change', function(){
					updateObjectWidthSelection();
			});
			// run on load
			$('#objectwidthsel').trigger('change');

			// constrain content
			$('#constraincontenttoggle').change(function(){
				if ($(this).is(':checked')){
					$('#objectconstrainsel').val('constrain').trigger('change').niceSelect('update');
				} else {
					$('#objectconstrainsel').val('').trigger('change').niceSelect('update');
				}
			})
			
			// expanded width
			function toggleExpandedWidth(){
				var expToggle = $('#expandedwidthtoggle');
				if ($(expToggle).is(':checked')){
					$('#objectwidthsel').val('mura-expanded').trigger('change').niceSelect('update');
				} else {
					$('#objectwidthsel').val('mura-twelve').trigger('change').niceSelect('update');
				}
			}

			$('#expandedwidthtoggle').change(function(){
				toggleExpandedWidth();
			})

			// numeric input - select on focus
			$('#configuratorContainer input.numeric').on('click', function(){
				$(this).select();
			});

			// numeric input - restrict value
			$('#configuratorContainer input.numeric').on('keyup', function(){
				var v = $(this).val();
				var n = $(this).attr('name').toLowerCase();
				if (n == 'contentmarginleft' || n == 'contentmarginright' || n == 'metamarginleft' || n == 'metamarginright'){
					if (v == 'a'){
						v = 'auto';
					}
					if(!(v=='a' || v=='au' || v=='aut'|| v=='auto')){
						v=v.replace(numRE,'');
					}
				} else {
					v=v.replace(numRE,'');
				}
				$(this).val(v);
			});

			// colorpicker
			$('.mura-colorpicker input[type=text]').on('keyup',function(){
				if ($(this).val().length == 0){
					$(this).parents('.mura-colorpicker').find('.mura-colorpicker-swatch').css('background-color','transparent');
				}
			})

			$('.btn-group').hover(function(){ 
				$(this).addClass('open'); 
			},
			function(){ 
				$(this).removeClass('open'); 
			});
			//wait to tell the listener to start reacting to allow setup js to fire
			setTimeout(
				function(){
					window.configuratorInited=true;
				},
				1000
			)
		});
	</script>
	</cfif>
</cfif>
