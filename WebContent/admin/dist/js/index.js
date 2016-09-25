 function fnLoadDatas() {
		url = ctx + '/extra/getSignInfo.ac';

		$.post(url, {

		}, function(data, textStatus, jqXHR) {
			if ("success" == textStatus) {
				$("#sgincount").html(data.count);
				$("#fedsum").html('￥'+data.costsum);

			}
		});
	};
	function fnLoadCampus() {
		url = ctx + '/cp_Show.ac';

		$.post(url, {

		}, function(data, textStatus, jqXHR) {
			if ("success" == textStatus) {
				var cpId=$("#cpId").val();
				for ( var i = 0; i < data.datas.length; i++) {
					if(data.datas[i].cpId==cpId){
						$("[id='campusname']").html(data.datas[i].cpName);
					}
					
				}								
			}
		});
	}
	$(document).ready(function() {
		//加载数据
		fnLoadDatas();
		//权限管理
		$.page.Roleset();
		//载入校区
		fnLoadCampus();
		
	});