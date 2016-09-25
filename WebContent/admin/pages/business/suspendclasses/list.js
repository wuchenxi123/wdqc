/*var ctx = "${pageContext.request.contextPath}";
$formLoad = function(url, pk) {
	url ='http://localhost:8080/weiyanggucheng/cou_Show.ac';
		$.post(url, {
		}, function(data, textStatus, jqXHR) {
			if ("success" == textStatus) {
				for(var i=0;i<data.datas.length;i++){						
					alert(data.datas[i].coId);				
				}								
		}
	}); 
};*/
var grid = null;
$(document).ready(function() {
	 	  grid = $('#user_datatable').DataTable({
	      processing: true,
	      searching : false,
	      serverSide: true,
	      autoWidth : true,
	      pagingType: "simple_numbers",
	      aLengthMenu:[10,5,20,50,100,500],
	      ajax: {
	          "url": ctx+'/st_ListByCampus.ac?param._ne_stStatus=0',
	          "type": "POST",
	          data : function(d){
	            	  // add query param to data
	            var params = $('.Datatable_Param_Form form').serializeArray();
	            var p = $.serializeJson(params); 
	            $.apply(d,p);
	            }
	      },
/*	      columnDefs: [ {
	          searchable: false,
	          orderable: false,
	          targets: 0,
	          sDefaultContent : ''
	      },{
	          searchable: false,
	          orderable: false,
	          targets: 7
	      } ], */
	      order: [[ 11, 'desc' ]],
	      /* aoColumnDefs: [{
			 sDefaultContent: '',
			 aTargets: [ '_all' ]
		  }], */
	      columns: [
	                { orderable : false ,searchable : false ,defaultContent : ''},	

	  	          { data : "stName" },
	  	          { data : "stSex" },
	  	          { data : "stAge" },
	  	          { data : "stMobile" },
	  	          { data : "stWechat" },
	  	          { data : "campus" ,orderable : false ,},
	  	          { data : "stStatus" } ,
	  	          { data : "stReside" } ,
	  	          { data : "creatorname",orderable : false , } ,	         
	  			  {	data : "salerName",orderable : false ,defaultContent : '无' ,},
	  			  { data : "createTime" } ,
	  	          {orderable : false ,searchable : false,defaultContent : '' , width : 130}
	      ], 
	      fnRowCallback : function(nRow,aData,iDataIndex){	
	    	  	var suspendPage = ctx + '/admin/pages/business/suspendclasses/edit.jsp';
			   	/*var Update = ctx + '/st_Update.ac';*/
				var html = '<div class="btn-group btn-group-xs" role="group" aria-label="...">';/**/
				html = html + '<a class="btn" href="javascript:loadPage(\'' + suspendPage + '\',\'' + aData.stId + '\'); " > <i class="ion-ios-compose"></i>办理停课</a>';
				html = html + '</div>';
				$('td:eq(-1)', nRow).html(html);
				$('td:eq(2)', nRow).html(aData.stSex=='0'?'男':'女');

				var stStatus = "";
				switch (aData.stStatus) {
				case "0":
					stStatus = '开课';
					break;
				case "1":
					stStatus = '停课';
					break;
				case "2":
					stStatus = '课程过期';
					break;
				default:

				}
				$('td:eq(7)', nRow).html(stStatus);
				return nRow;
	      },
	      oLanguage : $.dt.oLanguage,
	      dom : "<'row'<'col-sm-2'l><'col-sm-9 Datatable_Param_Form'><'col-sm-3'f>><'row'<'col-sm-12't>><'row'<'col-sm-5'i><'col-sm-7'p>>",
	      initComplete : addQueryParam
	    });
	    
	    grid.on( 'order.dt search.dt page.dt length.dt draw.dt', function () {
	    	grid.column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
	            cell.innerHTML = i+1;
	        } );
	    } );
	    
	    $.page.set({
	    	Grid : grid,
	    	Update:function(url, g) {
			if (!url)
				url = $.page.config.Update;
			if (!g)
				g = $.page.config.Grid;
			$.post(url, {

			}, function(data, textStatus, jqXHR) {
				if ("success" == textStatus) {
					// refresh datatables
					g.draw();
				} else {
					alert(data.msg);
				}
			});
		},
	    });
	  });
	function addQueryParam(data){
		$('.Datatable_Param_Form').html($('#Datatable_Param_Form').html());
		$('#Datatable_Param_Form').remove();
		
		// key down event
		$('.Datatable_Param_Form input').keydown(function(event) {
			switch (event.keyCode) {
			case 0xD:
				reload();
				break;
			default:
				
			}
		});
	}
	function reload(){
		grid.ajax.reload();
	}