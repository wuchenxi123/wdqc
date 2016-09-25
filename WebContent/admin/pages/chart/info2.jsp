<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
		String ctx = request.getContextPath();
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
 <script src="<%=ctx %>/admin/plugins/echart/echarts.js"></script>
</head>
<body>
	<section class="content-header">
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>市场分析</a></li>
			<li class="active">收入分析</li>
		</ol>
	</section>
	
	<section class="content">
	<div class="row">
		<div class="col-xs-12">
	   		<div id="bar_cap" style="height:500px;width:50%;float:left"></div>
	   		<div id="bar_cla" style="height:500px;width:50%;float:left"></div>
	   	</div>
	 </div>
   	</section>
 
<script type="text/javascript">
	
	/* 校区收入 */
	function camData(){
		var datas = {
				value : [],
				name : []
		};
	    $.ajax({
		    type : "POST",
		    async : false, //同步执行
		    url : ctx + '/extra/getCampusIncome.ac',
		    data : {},
		    
		    success : function(data, textStatus, jqXHR) {
				if ("success" == textStatus) {
					for (var key in data) {
						datas.value.push(data[key]);
						datas.name.push(key);
					}
				}
			}
		});
		return datas;
	}
	
	/* 校区人数 */
	function numData() {
		var datas = {
				name : [],
				value : []
		}
	    $.ajax({
		    type : "POST",
		    async : false, //同步执行
		    url : ctx + '/extra/getCampusStuentCount.ac',
		    data : {},
		    
		    success : function(data, textStatus, jqXHR) {
				if ("success" == textStatus) {
					for (var key in data) {
						datas.value.push(data[key]);
						datas.name.push(key);
					}
				}
			}
		});
		return datas;
	}
	
	/*班级数据*/
	function numCs() {
		var cs = {
		    	csNames : [],
		    	sumIncomes : [],
		    	csPeoplecount : []
		    }
	    $.ajax({
		    type : "POST",
		    async : false, //同步执行
		    url : ctx + '/cs_StatisticsIncome.ac',
		    data : {},
		    
		    success : function(data, textStatus, jqXHR) {
				if ("success" == textStatus) {
					for ( var i = 0; i < data.datas.length; i++) { 				
						cs.csNames.push(data.datas[i].csName);
						cs.sumIncomes.push(data.datas[i].sumIncome);
						cs.csPeoplecount.push(data.datas[i].csPeoplecount);
					}
				}
			}
		});
		return cs;
	}
	
	require.config({
	    paths: {
	    	echarts: '<%=ctx %>/admin/plugins/echart'
	    }
	});
	// 使用
	require(
	    [
	        'echarts',
	        'echarts/chart/bar', // 使用柱状图就加载bar模块，按需加载
	        'echarts/chart/line', // 使用柱状图就加载bar模块，按需加载
	        'echarts/chart/pie' // 使用柱状图就加载bar模块，按需加载
	    ],
	    DrawCharts  
	    );
		function DrawCharts(ec) {
			income_cap = camData();
			peo_cap = numData();
			data_cla = numCs();
			FunDraw1(ec);
			FunDraw2(ec);
		}  

    function FunDraw1(ec) {
        // 基于准备好的dom，初始化echarts图表
        var myChart = ec.init(document.getElementById('bar_cap')); 
        
        option = {
        	    title : {
        	        text: '校区收入分析'
        	    },
        	    tooltip : {
        	        trigger: 'axis'
        	    },
        	    legend: {
        	        data:['校区收入','校区人数']
        	    },
        	    toolbox: {
        	        show : true,
        	        feature : {
        	            mark : {show: true},
        	            dataView : {show: true, readOnly: false},
        	            magicType : {show: true, type: ['line', 'bar']},
        	            restore : {show: true},
        	            saveAsImage : {show: true}
        	        }
        	    },
        	    calculable : true,
        	    xAxis : [
        	        {
        	            type : 'category',
        	            data : peo_cap.name
        	        }
        	    ],
        	    yAxis : [
        	        {
        	            type : 'value'
        	        }
        	    ],
        	    series : [
        	        {
        	            name:'校区收入',
        	            type:'bar',
        	            data:income_cap.value,
        	            markPoint : {
        	                data : [
        	                    {type : 'max', name: '最大值'},
        	                    {type : 'min', name: '最小值'}
        	                ]
        	            },
        	            markLine : {
        	                data : [
        	                    {type : 'average', name: '平均值'}
        	                ]
        	            }
        	        },
        	        {
        	            name:'校区人数',
        	            type:'bar',
        	            data:peo_cap.value,
        	            markPoint : {
        	                data : [
        	                    {type : 'max', name: '最大值'},
        	                    {type : 'min', name: '最小值'}
        	                ]
        	            },
        	            markLine : {
        	                data : [
        	                    {type : 'average', name : '平均值'}
        	                ]
        	            }
        	        }
        	    ]
        	};
        // 为echarts对象加载数据 
        myChart.setOption(option); 
    };
    
    function FunDraw2(ec) {
        // 基于准备好的dom，初始化echarts图表
        var myChart = ec.init(document.getElementById('bar_cla')); 
        
        option = {
        	    title : {
        	        text: '班级收入分析'
        	    },
        	    tooltip : {
        	        trigger: 'axis'
        	    },
        	    legend: {
        	        data:['班级收入','班级人数']
        	    },
        	    toolbox: {
        	        show : true,
        	        feature : {
        	            mark : {show: true},
        	            dataView : {show: true, readOnly: false},
        	            magicType : {show: true, type: ['line', 'bar']},
        	            restore : {show: true},
        	            saveAsImage : {show: true}
        	        }
        	    },
        	    calculable : true,
        	    xAxis : [
        	        {
        	            type : 'category',
        	            data : data_cla.csNames
        	        }
        	    ],
        	    yAxis : [
        	        {
        	            type : 'value'
        	        }
        	    ],
        	    series : [
        	        {
        	            name:'班级收入',
        	            type:'bar',
        	            data: data_cla.sumIncomes,
        	            markPoint : {
        	                data : [
        	                    {type : 'max', name: '最大值'},
        	                    {type : 'min', name: '最小值'}
        	                ]
        	            },
        	            markLine : {
        	                data : [
        	                    {type : 'average', name: '平均值'}
        	                ]
        	            }
        	        },
        	        {
        	            name:'班级人数',
        	            type:'bar',
        	            data: data_cla.csPeoplecount,
        	            markPoint : {
        	                data : [
        	                    {type : 'max', name: '最大值'},
        	                    {type : 'min', name: '最小值'}
        	                ]
        	            },
        	            markLine : {
        	                data : [
        	                    {type : 'average', name : '平均值'}
        	                ]
        	            }
        	        }
        	    ]
        	};
        // 为echarts对象加载数据 
        myChart.setOption(option); 
    };
</script>
</body>
</html>