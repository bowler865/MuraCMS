<cfsilent>
<cfset $=application.serviceFactory.getBean("muraScope").init(rc.siteID)>
</cfsilent>
<cfinclude template="js.cfm">
<cfoutput>
<div class="mura-header">
	<h1>Edit Text</h1>
</div> <!-- /.mura-header -->

<div class="block block-constrain">
	<div class="block block-bordered">
	  	<div class="block-content">
		  	<div class="mura-control-group">
				<textarea name="source" id="source" class="htmlEditor" data-width="100%"></textarea>
			</div>
			<div class="mura-actions">
				<div class="form-actions">
					<button class="btn mura-primary" id="updateBtn"><i class="mi-check-circle"></i>Update</button>
				</div>
			</div>
		</div> <!-- /.block-content -->
	</div> <!-- /.block-bordered -->
</div> <!-- /.block-constrain -->

<script>
	Mura(function(m){
		var target='source';

        siteManager.setDisplayObjectModalWidth(800);
		
        siteManager.requestDisplayObjectParams(function(params){
			CKEDITOR.instances[target].setData(params[target])
		});

        m("##updateBtn").click(function(){
            var params={};
        	params[target]=CKEDITOR.instances[target].getData();
            siteManager.updateDisplayObjectParams(params,false);
        });
    });
</script>
</cfoutput>
